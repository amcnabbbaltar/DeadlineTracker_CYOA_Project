using System.IO;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEngine;

public class TweeToInkConverter : EditorWindow
{
    private string tweePath;
    private string outputPath;

    private Dictionary<string, string> globalVars = new Dictionary<string, string>();

    // ---------------- WINDOW UI ----------------
    [MenuItem("Tools/Twee to Ink Converter (CHOICE-PRESERVING CLEAN BUILD)")]
    public static void ShowWindow()
    {
        GetWindow<TweeToInkConverter>("Twee → Ink Converter");
    }

    void OnGUI()
    {
        GUILayout.Label("SugarCube → Ink Converter (CHOICE-PRESERVING CLEAN BUILD)", EditorStyles.boldLabel);

        if (GUILayout.Button("Select Twee File"))
            tweePath = EditorUtility.OpenFilePanel("Select Twee File", "", "twee");

        if (!string.IsNullOrEmpty(tweePath))
            GUILayout.Label("Selected: " + tweePath);

        if (!string.IsNullOrEmpty(tweePath) && GUILayout.Button("Convert"))
            ConvertTweeToInk(tweePath);
    }

    // ---------------- MAIN CONVERSION ----------------
    void ConvertTweeToInk(string path)
    {
        string tweeText = File.ReadAllText(path);

        tweeText = RemoveLeadingGarbage(tweeText);

        globalVars.Clear();
        string inkOutput = ParseTwee(tweeText);

        string inkFull = GenerateVarBlock() + "\n\n" + inkOutput;

        outputPath = Path.ChangeExtension(path, ".ink");
        File.WriteAllText(outputPath, inkFull);

        EditorUtility.DisplayDialog("Success", "Converted to Ink:\n" + outputPath, "OK");
    }

    // ---------------- GLOBAL VARS BLOCK ----------------
    string GenerateVarBlock()
    {
        if (globalVars.Count == 0) return "";

        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.AppendLine("=== global_variables ===");

        foreach (var v in globalVars)
            sb.AppendLine($"VAR {v.Key} = {v.Value}");

        return sb.ToString();
    }

    // ---------------- LEADING GARBAGE REMOVAL ----------------
    string RemoveLeadingGarbage(string text)
    {
        int idx = text.IndexOf("::");
        if (idx < 0) return text;
        return text.Substring(idx);
    }

    // ---------------- QUOTE FIXER ----------------
    string FixBrokenQuotes(string text)
    {
        if (string.IsNullOrWhiteSpace(text))
            return text;

        text = Regex.Replace(text, "\"{3,}", "\"");
        text = Regex.Replace(text, "\"{2}", "\"");
        text = Regex.Replace(text, "\"+(\\s|$)", "\" ");

        return text.Trim();
    }

    // ---------------- SYSTEM PASSAGE FILTERS ----------------
    bool IsNonStoryPassage(string rawHeader)
    {
        string name = rawHeader.Split('[')[0].Trim().ToLower();

        return
            name == "storytitle" ||
            name == "storydata" ||
            name == "story javascript" ||
            name == "story_javascript" ||
            name == "story stylesheet" ||
            name == "storystylesheet" ||
            name == "story_stylesheet" ||
            name == "storyinit" ||
            name == "passageheader" ||
            name == "passagefooter" ||
            name == "ui_macros";
    }

    bool HasNonStoryTags(string header)
    {
        header = header.ToLower();

        return
            header.Contains("[stylesheet]") ||
            header.Contains("[css]") ||
            header.Contains("[script]") ||
            header.Contains("[javascript]") ||
            header.Contains("[twinescript]") ||
            header.Contains("[macro]");
    }

    bool IsRealStoryPassage(string name, string body)
    {
        if (string.IsNullOrWhiteSpace(name)) return false;
        if (name.Contains("[") || name.Contains("]")) return false;
        if (string.IsNullOrWhiteSpace(body)) return false;

        string cleaned = StripAllHTMLCSS(body);

        if (!Regex.IsMatch(cleaned, @"[A-Za-z0-9]"))
            return false;

        return true;
    }

    // ---------------- TOTAL HTML + CSS REMOVAL ----------------
    string StripAllHTMLCSS(string text)
    {
        text = Regex.Replace(text, @"<!--.*?-->", "", RegexOptions.Singleline);
        text = Regex.Replace(text, @"<[^>]+>", "", RegexOptions.Singleline);
        text = Regex.Replace(text, @"&lt;.*?&gt;", "", RegexOptions.Singleline);
        text = Regex.Replace(text, @"\{[^}]*\}", "", RegexOptions.Singleline);
        text = Regex.Replace(text, @"[A-Za-z-]+\s*:\s*[^;\n]+;?", "", RegexOptions.Singleline);
        text = Regex.Replace(text, @"@[\w\-]+\s*[^{]*\{[^}]*\}", "", RegexOptions.Singleline);
        text = Regex.Replace(text, @"@import[^;\n]*;", "", RegexOptions.Singleline);

        return text;
    }

    // ---------------- JAVASCRIPT REMOVAL ----------------
    string RemoveJavaScript(string text)
    {
        text = Regex.Replace(text, @"<<script>>.*?<</script>>", "", RegexOptions.Singleline);
        text = Regex.Replace(text, @"<script[^>]*>.*?</script>", "", RegexOptions.Singleline);
        return text;
    }

    // ---------------- PASSAGE PARSER ----------------
    string ParseTwee(string twee)
    {
        var regex = new Regex(@"::\s*(?<name>[^\n]+)\n(?<body>.*?)(?=\n::|$)", RegexOptions.Singleline);
        var matches = regex.Matches(twee);

        System.Text.StringBuilder ink = new System.Text.StringBuilder();

        foreach (Match m in matches)
        {
            string header = m.Groups["name"].Value.Trim();

            header = Regex.Replace(header, @"\{.*?\}", "");
            header = Regex.Replace(header, @"<[^>]+>", "");
            header = Regex.Replace(header, @"&lt;.*?&gt;", "");
            header = FixBrokenQuotes(header);

            string titleOnly = header.Split('[')[0].Trim();
            string body = m.Groups["body"].Value;

            if (IsNonStoryPassage(header)) continue;
            if (HasNonStoryTags(header)) continue;
            if (!IsRealStoryPassage(titleOnly, body)) continue;

            // Clean body fully
            body = StripAllHTMLCSS(body);
            body = RemoveJavaScript(body);
            body = FixBrokenQuotes(body);

            // CHOICES FIRST (links, timelinks, [[ ]])
            body = ConvertChoicesAndLinks(body);

            // THEN LOGIC MACROS (set/if/run/etc.)
            body = ConvertLogic(body);

            // Strip metadata
            body = Regex.Replace(body, @"\{""position"".*?""size"".*?\}", "", RegexOptions.Singleline);

            titleOnly = FixBrokenQuotes(titleOnly);
            string title = CleanName(titleOnly);

            ink.AppendLine($"=== {title} ===");
            ink.AppendLine(body.Trim());
            ink.AppendLine();
        }

        return ink.ToString();
    }

    // ---------------- LOGIC CONVERSION ----------------
    string ConvertLogic(string text)
    {
        text = FixBrokenQuotes(text);

        // <<set $var = value>>
        text = Regex.Replace(text,
            @"<<set\s+\$(\w+)\s*=\s*([^>]+)>>",
            m =>
            {
                string varName = m.Groups[1].Value;
                string val = m.Groups[2].Value.Trim();
                if (!globalVars.ContainsKey(varName))
                    globalVars[varName] = "0";
                return $"~ {varName} = {ConvertValue(val)}";
            });

        // increments like <<set $var += 1>>
        text = Regex.Replace(text,
            @"<<set\s+\$(\w+)\s*\+=\s*([^>]+)>>",
            m =>
            {
                string varName = m.Groups[1].Value;
                string val = m.Groups[2].Value.Trim();
                if (!globalVars.ContainsKey(varName))
                    globalVars[varName] = "0";
                return $"~ {varName} += {ConvertValue(val)}";
            });

        text = Regex.Replace(text,
            @"<<set\s+\$(\w+)\s*-\=\s*([^>]+)>>",
            m =>
            {
                string varName = m.Groups[1].Value;
                string val = m.Groups[2].Value.Trim();
                if (!globalVars.ContainsKey(varName))
                    globalVars[varName] = "0";
                return $"~ {varName} -= {ConvertValue(val)}";
            });

        // Conditionals
        text = Regex.Replace(text,
            @"<<if\s+([^>]+)>>",
            m => "{ " + ConvertCondition(m.Groups[1].Value) + ":");

        text = Regex.Replace(text,
            @"<<elseif\s+([^>]+)>>",
            m => "- else if (" + ConvertCondition(m.Groups[1].Value) + "):");

        text = Regex.Replace(text, @"<<else>>", "- else:");
        text = Regex.Replace(text, @"<</\s*if\s*>>", "}");

        // <<run ...>>
        text = Regex.Replace(text,
            @"<<run\s+([^>]+)>>",
            m => ConvertRunMacro(m.Groups[1].Value));

        // Any remaining macros get stripped
        text = Regex.Replace(text, @"<<.*?>>", "");

        return text;
    }

    // ---------------- CHOICE + LINK HANDLING ----------------
    string ConvertChoicesAndLinks(string body)
    {
        string[] lines = body.Split('\n');
        System.Text.StringBuilder sb = new System.Text.StringBuilder();

        foreach (string rawLine in lines)
        {
            string line = rawLine.Trim();

            if (string.IsNullOrWhiteSpace(line))
            {
                sb.AppendLine();
                continue;
            }

            // 1) SugarCube: <<link "Text">><<goto "Target">><</link>>
            Match linkMacro = Regex.Match(line,
                @"<<link\s+""(?<label>[^""]+)""\s*>>\s*<<goto\s+""(?<target>[^""]+)""\s*>>.*?<</link>>",
                RegexOptions.Singleline);

            if (linkMacro.Success)
            {
                string label = linkMacro.Groups["label"].Value.Trim();
                string target = CleanName(linkMacro.Groups["target"].Value.Trim());

                sb.AppendLine($"+ {label}");
                sb.AppendLine($"    -> {target}");
                continue;
            }

            // 2) SugarCube: <<timelink "Label" cost "Target">> ... <</timelink>>
            // We treat this as a choice; timing + payload logic can be recreated manually in Ink.
            Match timelinkMacro = Regex.Match(line,
                @"<<timelink\s+""(?<label>[^""]+)""\s+(?<cost>[^\s""]+)\s+""(?<target>[^""]+)""\s*>>",
                RegexOptions.Singleline);

            if (timelinkMacro.Success)
            {
                string label = timelinkMacro.Groups["label"].Value.Trim();
                string target = CleanName(timelinkMacro.Groups["target"].Value.Trim());

                sb.AppendLine($"+ {label}");
                sb.AppendLine($"    -> {target}");
                continue;
            }

            // 3) Standalone Twine-style [[choice]] at line start
            Match choice = Regex.Match(line,
                @"^\s*(\*|>|-)?\s*\[\[(?<display>[^\|\]]+)(\|(?<target>[^\]]+))?\]\]\s*$");

            if (choice.Success)
            {
                string display = choice.Groups["display"].Value.Trim();
                string target = choice.Groups["target"].Success
                                ? choice.Groups["target"].Value.Trim()
                                : display;

                sb.AppendLine($"+ {display}");
                sb.AppendLine($"    -> {CleanName(target)}");
                continue;
            }

            // 4) Inline [[display|target]] links
            line = Regex.Replace(line,
                @"\[\[(?<display>[^\|\]]+)\|(?<target>[^\]]+)\]\]",
                m => $"{m.Groups["display"].Value} -> {CleanName(m.Groups["target"].Value)}");

            // 5) Inline [[display->target]] links
            line = Regex.Replace(line,
                @"\[\[(?<display>[^\-\]]+)->(?<target>[^\]]+)\]\]",
                m => $"{m.Groups["display"].Value} -> {CleanName(m.Groups["target"].Value)}");

            // 6) Inline [[target]] links (no display text)
            line = Regex.Replace(line,
                @"\[\[(?<target>[^\|\]]+)\]\]",
                m => $"{m.Groups["target"].Value} -> {CleanName(m.Groups["target"].Value)}");

            sb.AppendLine(line);
        }

        return sb.ToString();
    }

    // ---------------- VALUES ----------------
    string ConvertValue(string v)
    {
        v = v.Replace("$", "").Trim();
        if (int.TryParse(v, out _)) return v;
        if (v == "true" || v == "false") return v;
        return $"\"{v}\"";
    }

    string ConvertCondition(string cond)
    {
        cond = cond.Replace("$", "").Trim();

        // SugarCube-style "is", "is not", "not", "and", "or"
        cond = Regex.Replace(cond, @"\bis not\b", "!=");
        cond = Regex.Replace(cond, @"\bis\b", "==");
        cond = Regex.Replace(cond, @"\bnot\b", "!");
        cond = cond.Replace(" and ", " && ");
        cond = cond.Replace(" or ", " || ");

        return cond;
    }

    string ConvertRunMacro(string js)
    {
        var inc = Regex.Match(js, @"\$(\w+)\s*\+=\s*(\d+)");
        if (inc.Success)
        {
            string key = inc.Groups[1].Value;
            if (!globalVars.ContainsKey(key))
                globalVars[key] = "0";
            return $"~ {key} += {inc.Groups[2].Value}";
        }

        var assign = Regex.Match(js, @"\$(\w+)\s*=\s*(.+?);?");
        if (assign.Success)
        {
            string key = assign.Groups[1].Value;
            string val = assign.Groups[2].Value.Trim();
            if (!globalVars.ContainsKey(key))
                globalVars[key] = "0";
            return $"~ {key} = {ConvertValue(val)}";
        }

        return "";
    }

    // ---------------- NAME CLEANUP ----------------
    string CleanName(string name)
    {
        return name.Replace(" ", "_").Replace("-", "_").Trim();
    }
}
