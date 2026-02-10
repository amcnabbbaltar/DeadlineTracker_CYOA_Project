using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;

namespace SimpleTwineDialogue
{
    public class TweeParser
    {
        [System.Serializable]
        public class Choice
        {
            public string DisplayText;
            public string TargetPassage;
        }

        [System.Serializable]
        public class Passage
        {
            public string Title;
            public string[] Tags;
            public string Body;
            public List<string> Images;
            public List<Choice> Choices; // <-- IMPORTANT: structured choices
        }

        public Dictionary<string, Passage> ParseTweeFile(string filePath)
        {
            var text = File.ReadAllText(filePath);
            return ParseTweeFileFromText(text);
        }

        public Dictionary<string, Passage> ParseTweeFileFromText(string text)
        {
            var passages = new Dictionary<string, Passage>();

            var passageRegex = new Regex(
                @"::\s*(?<title>[^\n]+)\s*(\[(?<tags>[^\]]+)\])?\s*\n(?<body>.*?)(?=\n::\s*|$)",
                RegexOptions.Singleline
            );

            var imageRegex = new Regex(@"\[\[Image:(?<path>[^\]]+)\]\]");
            var choiceRegex = new Regex(@"\[\[(?<choiceText>[^\|\]]+)\|(?<choiceTarget>[^\]]+)\]\]");
            var choiceNoPipeRegex = new Regex(@"\[\[(?<choiceTarget>[^\]]+)\]\]");
            var sugarCubeMacroRegex = new Regex(@"<<.*?>>", RegexOptions.Singleline);
            var htmlCommentRegex = new Regex(@"<!--.*?-->", RegexOptions.Singleline);

            var matches = passageRegex.Matches(text);
            foreach (Match match in matches)
            {
                var title = match.Groups["title"].Value.Trim();

                var tagsRaw = match.Groups["tags"].Value;
                var tags = string.IsNullOrWhiteSpace(tagsRaw)
                    ? new string[0]
                    : tagsRaw.Split(' ', System.StringSplitOptions.RemoveEmptyEntries);

                var body = (match.Groups["body"].Value ?? "").Trim();

                var images = new List<string>();
                var choices = new List<Choice>();

                // Remove comments
                body = htmlCommentRegex.Replace(body, "");

                // Extract images
                foreach (Match im in imageRegex.Matches(body))
                    images.Add(im.Groups["path"].Value.Trim());
                body = imageRegex.Replace(body, "");

                // Extract [[Display|Target]]
                foreach (Match c in choiceRegex.Matches(body))
                {
                    choices.Add(new Choice
                    {
                        DisplayText = c.Groups["choiceText"].Value.Trim(),
                        TargetPassage = c.Groups["choiceTarget"].Value.Trim()
                    });
                }
                body = choiceRegex.Replace(body, "");

                // OPTIONAL: Extract [[Target]] as choice
                foreach (Match c in choiceNoPipeRegex.Matches(body))
                {
                    var target = c.Groups["choiceTarget"].Value.Trim();
                    if (string.IsNullOrEmpty(target)) continue;

                    choices.Add(new Choice
                    {
                        DisplayText = target,
                        TargetPassage = target
                    });
                }
                body = choiceNoPipeRegex.Replace(body, "");

                // Strip SugarCube macros like <<set ...>>
                body = sugarCubeMacroRegex.Replace(body, "");

                // Cleanup whitespace
                body = Regex.Replace(body, @"[ \t]+\n", "\n");
                body = Regex.Replace(body, @"\n{3,}", "\n\n");
                body = body.Trim();

                passages[title] = new Passage
                {
                    Title = title,
                    Tags = tags,
                    Body = body,
                    Images = images,
                    Choices = choices
                };
            }

            return passages;
        }
    }
}
