using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

public class TweeParser
{
    // =============================
    // PASSAGE + CHOICE CLASSES
    // =============================
    public class Choice
    {
        public string Display;
        public string Target;
    }

    public class Passage
    {
        public string Title;
        public string Body;

        public List<string> Tags = new List<string>();
        public float WaitTime = 0f;
        public List<Choice> Choices = new List<Choice>();
    }

    // =============================
    // MAIN ENTRY POINT
    // =============================
    public Dictionary<string, Passage> ParseTweeFileFromText(string text)
    {
        Dictionary<string, Passage> passages = new Dictionary<string, Passage>();

        // Match:  :: PassageName [tag1 tag2] 
        // followed by body until next ::
        var regex = new Regex(@"::\s*(?<name>[^\n\[]+)\s*(\[(?<tags>[^\]]+)\])?\s*\n(?<body>.*?)(?=\n::|$)", RegexOptions.Singleline);

        var matches = regex.Matches(text);

        foreach (Match m in matches)
        {
            Passage p = new Passage();

            p.Title = m.Groups["name"].Value.Trim();
            p.Body = m.Groups["body"].Value.Trim();

            // ============= PARSE TAGS =============
            if (m.Groups["tags"].Success)
            {
                string[] rawTags = m.Groups["tags"].Value.Split(' ');

                foreach (var t in rawTags)
                {
                    string tag = t.Trim();
                    if (tag.Length == 0) continue;

                    p.Tags.Add(tag);

                    // Special tag: wait:2.5
                    if (tag.StartsWith("wait:"))
                    {
                        if (float.TryParse(tag.Substring(5), out float w))
                            p.WaitTime = w;
                    }
                }
            }

            // ============= PARSE CHOICES =============
            ParseChoices(p);

            passages[p.Title] = p;
        }

        return passages;
    }

    // =============================
    // CHOICE PARSER
    // =============================
    private void ParseChoices(Passage p)
    {
        // Standard Twine link formats:
        // [[Display|Target]]
        // [[Target]]
        // [[Display->Target]]

        var linkRegex = new Regex(@"\[\[(?<full>(?<display>[^\|\]]+)\|(?<target>[^\]]+))\]\]|\[\[(?<solo>[^\]]+)\]\]", RegexOptions.Singleline);

        MatchCollection links = linkRegex.Matches(p.Body);

        foreach (Match m in links)
        {
            if (m.Groups["full"].Success)
            {
                p.Choices.Add(new Choice
                {
                    Display = m.Groups["display"].Value.Trim(),
                    Target = CleanName(m.Groups["target"].Value.Trim())
                });
            }
            else if (m.Groups["solo"].Success)
            {
                string val = m.Groups["solo"].Value.Trim();

                p.Choices.Add(new Choice
                {
                    Display = val,
                    Target = CleanName(val)
                });
            }
        }

        // Remove link markup from body after extracting choices
        p.Body = linkRegex.Replace(p.Body, "");
    }

    // =============================
    // NAME CLEANER
    // =============================
    private string CleanName(string name)
    {
        return name.Replace(" ", "_").Replace("-", "_").Trim();
    }
}
