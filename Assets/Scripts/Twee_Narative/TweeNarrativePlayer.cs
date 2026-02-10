using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using TMPro;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.UI;

namespace SimpleTwineDialogue
{
    public class TextAdventureWithVisualContainers : MonoBehaviour
    {
        [Header("UI Components")]
        public TextMeshProUGUI passageText;
        public Button choiceButtonPrefab;
        public Transform choiceButtonContainer;
        public TextMeshProUGUI myChoiceCounterUI;

        [Header("Visual Containers (assign in Inspector)")]
        public Transform backgroundContainer;
        public Transform characterContainer;

        [Tooltip("Prefab must have an Image component (UI -> Image). Used if container has no Image child.")]
        public Image imagePrefab;

        [Tooltip("Optional: Animator to enable/disable for character animation. If null, will try to find one on the character Image.")]
        public Animator characterAnimator;

        [Header("Typewriter Settings")]
        public float typeDelay = 0.02f;
        public bool typing = false;

        [Header("File Loading")]
        public bool loadFromWeb;

        [Header("Load from Web")]
        public string webFileURL;
        public string imageBaseURL;

        [Header("Load from Local (StreamingAssets)")]
        public string localFileName = "Story.twee";
        public string localImagesFolder = "";

        [Header("Start Passage Name")]
        public string startPassageName = "Start";

        [Header("If a passage has NO [[links]], show a Continue button to go to the next passage in file order")]
        public bool allowContinueFallback = false;

        private int myChoices = 0;

        private TweeParser tweeParser;
        private Dictionary<string, TweeParser.Passage> passages;

        private Image backgroundImage;
        private Image characterImage;

        // Keep passage order (for optional Continue fallback)
        private readonly List<string> passageOrder = new List<string>();

        // ---------------- Tag map from header tags ----------------
        private class TagInfo
        {
            public string background;
            public bool backgroundInstant;
            public string character;
            public bool characterInstant;
            public string anim;
            public float? waitSeconds;
        }
        private readonly Dictionary<string, TagInfo> tagMap = new Dictionary<string, TagInfo>(StringComparer.OrdinalIgnoreCase);

        // ---------------- Choice parsing from body ----------------
        private class BodyChoice
        {
            public string label;
            public string target;
        }

        private static readonly Regex LinkRegex = new Regex(@"\[\[(?<inside>.*?)\]\]", RegexOptions.Compiled);

        void Start()
        {
            tweeParser = new TweeParser();

            backgroundImage = GetOrCreateContainerImage(backgroundContainer, "BackgroundImage");
            characterImage = GetOrCreateContainerImage(characterContainer, "CharacterImage");

            if (characterAnimator == null && characterImage != null)
                characterAnimator = characterImage.GetComponent<Animator>();

            if (loadFromWeb)
                StartCoroutine(LoadTweeFile(webFileURL));
            else
                StartCoroutine(LoadTweeFile(Path.Combine(Application.streamingAssetsPath, localFileName)));
        }

        Image GetOrCreateContainerImage(Transform container, string defaultName)
        {
            if (container == null)
            {
                Debug.LogWarning($"{defaultName} container not assigned.");
                return null;
            }

            var existing = container.GetComponentInChildren<Image>(true);
            if (existing != null) return existing;

            if (imagePrefab == null)
            {
                Debug.LogError("imagePrefab not assigned, and container has no Image child.");
                return null;
            }

            Image img = Instantiate(imagePrefab, container);
            img.name = defaultName;
            img.gameObject.SetActive(true);
            img.preserveAspect = true;
            return img;
        }

        IEnumerator LoadTweeFile(string filePathOrUrl)
        {
            string rawText;

            if (loadFromWeb)
            {
                UnityWebRequest request = UnityWebRequest.Get(filePathOrUrl);
                yield return request.SendWebRequest();

                if (request.result == UnityWebRequest.Result.ConnectionError || request.result == UnityWebRequest.Result.ProtocolError)
                {
                    Debug.LogError(request.error);
                    yield break;
                }

                rawText = request.downloadHandler.text;
            }
            else
            {
                if (!File.Exists(filePathOrUrl))
                {
                    Debug.LogError("Twee file not found: " + filePathOrUrl);
                    yield break;
                }

                rawText = File.ReadAllText(filePathOrUrl, Encoding.UTF8);
            }

            passages = tweeParser.ParseTweeFileFromText(rawText);

            // Build tags + order from raw text
            BuildTagMapAndOrderFromRawTwee(rawText);

            StartAtBestPassage();
        }

        void StartAtBestPassage()
        {
            if (passages == null || passages.Count == 0)
            {
                Debug.LogError("No passages parsed from Twee.");
                return;
            }

            string chosen = null;

            if (!string.IsNullOrWhiteSpace(startPassageName) && passages.ContainsKey(startPassageName) && !IsMetadataPassage(startPassageName))
                chosen = startPassageName;
            else if (passages.ContainsKey("Start") && !IsMetadataPassage("Start"))
                chosen = "Start";
            else
            {
                foreach (var title in passageOrder)
                {
                    if (passages.ContainsKey(title) && !IsMetadataPassage(title))
                    {
                        chosen = title;
                        break;
                    }
                }
            }

            if (chosen == null)
            {
                foreach (var kv in passages) { chosen = kv.Key; break; }
            }

            DisplayPassage(chosen);
        }

        bool IsMetadataPassage(string title)
        {
            if (string.IsNullOrWhiteSpace(title)) return true;

            if (title.Equals("StoryTitle", StringComparison.OrdinalIgnoreCase)) return true;
            if (title.Equals("StoryData", StringComparison.OrdinalIgnoreCase)) return true;
            if (title.Equals("StoryInit", StringComparison.OrdinalIgnoreCase)) return true;
            if (title.Equals("StorySettings", StringComparison.OrdinalIgnoreCase)) return true;
            if (title.Equals("Stylesheet", StringComparison.OrdinalIgnoreCase)) return true;
            if (title.Equals("StyleSheet", StringComparison.OrdinalIgnoreCase)) return true;
            if (title.Equals("Script", StringComparison.OrdinalIgnoreCase)) return true;
            if (title.Equals("JavaScript", StringComparison.OrdinalIgnoreCase)) return true;

            return false;
        }

        // ------------------------------------------------------------
        // Display Passage (NOW parses choices from BODY, not TweeParser)
        // ------------------------------------------------------------
        public void DisplayPassage(string passageTitle)
        {
            if (passages == null || !passages.TryGetValue(passageTitle, out var passage))
            {
                Debug.LogError("Passage not found: " + passageTitle);
                return;
            }

            if (IsMetadataPassage(passageTitle))
            {
                Debug.LogWarning("Skipping metadata passage: " + passageTitle);
                return;
            }

            StopAllCoroutines();
            ClearChoices();

            TagInfo tags = tagMap.TryGetValue(passageTitle, out var t) ? t : null;
            bool hasWait = HandleTags(tags, out float waitSeconds);

            // NEW: Extract [[links]] from body so choices always work
            List<BodyChoice> choices = ExtractChoicesFromBody(passage.Body ?? "", out string cleanedText);

            StartCoroutine(TypeTextThenChoices(cleanedText, choices, hasWait, waitSeconds, passageTitle));
        }

        IEnumerator TypeTextThenChoices(string fullText, List<BodyChoice> choices, bool hasWaitTag, float waitSeconds, string currentTitle)
        {
            typing = true;
            passageText.text = "";

            Canvas.ForceUpdateCanvases();

            for (int i = 0; i < fullText.Length; i++)
            {
                if (Input.GetMouseButtonDown(0))
                {
                    passageText.text = fullText;
                    break;
                }

                passageText.text += fullText[i];

                var rt = passageText.GetComponent<RectTransform>();
                if (rt != null)
                    rt.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, passageText.preferredHeight);

                Canvas.ForceUpdateCanvases();
                yield return new WaitForSeconds(typeDelay);
            }

            typing = false;

            if (hasWaitTag && waitSeconds > 0f)
                yield return new WaitForSeconds(waitSeconds);

            BuildChoiceButtonsFromParsed(choices, currentTitle);
        }

        void BuildChoiceButtonsFromParsed(List<BodyChoice> choices, string currentTitle)
        {
            ClearChoices();

            if (choices != null && choices.Count > 0)
            {
                foreach (var c in choices)
                {
                    var btn = Instantiate(choiceButtonPrefab, choiceButtonContainer);
                    btn.GetComponentInChildren<TextMeshProUGUI>().text = c.label;

                    string target = c.target;
                    btn.onClick.AddListener(() =>
                    {
                        myChoices++;
                        if (myChoiceCounterUI) myChoiceCounterUI.text = "Choices made: " + myChoices;
                        DisplayPassage(target);
                    });
                }
                return;
            }

            // Optional continue fallback if there are no [[links]]
            if (allowContinueFallback)
            {
                string next = GetNextPassageInOrder(currentTitle);
                if (!string.IsNullOrEmpty(next))
                {
                    var btn = Instantiate(choiceButtonPrefab, choiceButtonContainer);
                    btn.GetComponentInChildren<TextMeshProUGUI>().text = "Continue";
                    btn.onClick.AddListener(() =>
                    {
                        myChoices++;
                        if (myChoiceCounterUI) myChoiceCounterUI.text = "Choices made: " + myChoices;
                        DisplayPassage(next);
                    });
                    return;
                }
            }

            // Otherwise restart
            var restart = Instantiate(choiceButtonPrefab, choiceButtonContainer);
            restart.GetComponentInChildren<TextMeshProUGUI>().text = "Restart story";
            restart.onClick.AddListener(() =>
            {
                myChoices = 0;
                if (myChoiceCounterUI) myChoiceCounterUI.text = "Choices made: 0";
                StartAtBestPassage();
            });
        }

        string GetNextPassageInOrder(string currentTitle)
        {
            int idx = passageOrder.FindIndex(t => t.Equals(currentTitle, StringComparison.OrdinalIgnoreCase));
            if (idx < 0) return null;

            for (int i = idx + 1; i < passageOrder.Count; i++)
            {
                string candidate = passageOrder[i];
                if (passages.ContainsKey(candidate) && !IsMetadataPassage(candidate))
                    return candidate;
            }
            return null;
        }

        // ------------------------------------------------------------
        // Choice extraction from body [[...]]
        // Supports: [[Target]] [[Label|Target]] [[Label->Target]]
        // Removes links from displayed text.
        // ------------------------------------------------------------
        List<BodyChoice> ExtractChoicesFromBody(string body, out string cleanedBody)
        {
            var results = new List<BodyChoice>();
            if (string.IsNullOrEmpty(body))
            {
                cleanedBody = "";
                return results;
            }

            var matches = LinkRegex.Matches(body);

            cleanedBody = LinkRegex.Replace(body, "").TrimEnd();

            foreach (Match m in matches)
            {
                string inside = m.Groups["inside"].Value.Trim();
                if (string.IsNullOrEmpty(inside)) continue;

                ParseChoiceInside(inside, out string label, out string target);
                if (string.IsNullOrEmpty(label) || string.IsNullOrEmpty(target)) continue;

                results.Add(new BodyChoice { label = label, target = target });
            }

            return results;
        }

        static void ParseChoiceInside(string inside, out string label, out string target)
        {
            label = null;
            target = null;

            inside = inside?.Trim();
            if (string.IsNullOrEmpty(inside)) return;

            int arrowIdx = inside.IndexOf("->", StringComparison.Ordinal);
            int pipeIdx = inside.IndexOf("|", StringComparison.Ordinal);

            if (arrowIdx >= 0)
            {
                label = inside.Substring(0, arrowIdx).Trim();
                target = inside.Substring(arrowIdx + 2).Trim();
                return;
            }

            if (pipeIdx >= 0)
            {
                label = inside.Substring(0, pipeIdx).Trim();
                target = inside.Substring(pipeIdx + 1).Trim();
                return;
            }

            label = inside;
            target = inside;
        }

        void ClearChoices()
        {
            foreach (Transform child in choiceButtonContainer)
                Destroy(child.gameObject);
        }

        // ------------------------------------------------------------
        // Tags: background/character/anim/wait (same features as first class)
        // ------------------------------------------------------------
        bool HandleTags(TagInfo tags, out float waitSeconds)
        {
            waitSeconds = 0f;
            if (tags == null) return false;

            if (tags.waitSeconds.HasValue)
                waitSeconds = tags.waitSeconds.Value;

            if (!string.IsNullOrEmpty(tags.background))
                StartCoroutine(LoadImageToTarget(tags.background, backgroundImage, tags.backgroundInstant));

            if (!string.IsNullOrEmpty(tags.character))
            {
                if (characterAnimator != null)
                    characterAnimator.enabled = false;

                StartCoroutine(LoadImageToTarget(tags.character, characterImage, tags.characterInstant));
            }

            if (!string.IsNullOrEmpty(tags.anim))
            {
                if (characterAnimator != null)
                    characterAnimator.enabled = true;
            }

            return tags.waitSeconds.HasValue;
        }

        IEnumerator LoadImageToTarget(string name, Image target, bool instant)
        {
            if (target == null) yield break;

            string fileName = name.Trim();
            if (!Path.HasExtension(fileName))
                fileName += ".png";

            Texture2D tex = null;

            if (loadFromWeb)
            {
                string url = CombineUrl(imageBaseURL, fileName);
                UnityWebRequest req = UnityWebRequestTexture.GetTexture(url);
                yield return req.SendWebRequest();

                if (req.result == UnityWebRequest.Result.ConnectionError || req.result == UnityWebRequest.Result.ProtocolError)
                {
                    Debug.LogError("Image download error: " + req.error + " url=" + url);
                    yield break;
                }

                tex = DownloadHandlerTexture.GetContent(req);
            }
            else
            {
                string baseFolder = Application.streamingAssetsPath;
                if (!string.IsNullOrEmpty(localImagesFolder))
                    baseFolder = Path.Combine(baseFolder, localImagesFolder);

                string path = Path.Combine(baseFolder, fileName);

                if (!File.Exists(path))
                {
                    Debug.LogError("Image not found: " + path);
                    yield break;
                }

                byte[] bytes = File.ReadAllBytes(path);
                tex = new Texture2D(2, 2);
                tex.LoadImage(bytes);
            }

            if (tex == null) yield break;

            Sprite sprite = Sprite.Create(tex, new Rect(0, 0, tex.width, tex.height), new Vector2(0.5f, 0.5f));
            target.preserveAspect = true;

            if (instant)
            {
                target.sprite = sprite;
            }
            else
            {
                yield return StartCoroutine(FadeImageTransition(sprite, target, 0.8f));
            }
        }

        IEnumerator FadeImageTransition(Sprite newSprite, Image target, float fadeDuration = 0.8f)
        {
            if (target == null) yield break;

            Color c = target.color;
            float t = 0f;

            while (t < fadeDuration)
            {
                t += Time.deltaTime;
                c.a = Mathf.Lerp(1f, 0f, t / fadeDuration);
                target.color = c;
                yield return null;
            }

            target.sprite = newSprite;

            t = 0f;
            while (t < fadeDuration)
            {
                t += Time.deltaTime;
                c.a = Mathf.Lerp(0f, 1f, t / fadeDuration);
                target.color = c;
                yield return null;
            }
        }

        static string CombineUrl(string baseUrl, string file)
        {
            if (string.IsNullOrEmpty(baseUrl)) return file ?? "";
            if (string.IsNullOrEmpty(file)) return baseUrl;
            return baseUrl.TrimEnd('/') + "/" + file.TrimStart('/');
        }

        // ------------------------------------------------------------
        // Build tag map + passage order from raw Twee headers
        // :: Title [background:Room character:Alice wait:1.5 anim:idle]
        // ------------------------------------------------------------
        void BuildTagMapAndOrderFromRawTwee(string rawTweeText)
        {
            tagMap.Clear();
            passageOrder.Clear();

            if (string.IsNullOrEmpty(rawTweeText)) return;

            rawTweeText = rawTweeText.Replace("\r\n", "\n").Replace("\r", "\n");
            var lines = rawTweeText.Split('\n');

            for (int i = 0; i < lines.Length; i++)
            {
                string line = lines[i];
                if (!line.TrimStart().StartsWith("::")) continue;

                string header = line.Trim().Substring(2).Trim();

                string title;
                string tagsPart = null;

                int open = header.IndexOf('[', StringComparison.Ordinal);
                int close = header.LastIndexOf(']');

                if (open >= 0 && close > open)
                {
                    title = header.Substring(0, open).Trim();
                    tagsPart = header.Substring(open + 1, close - open - 1).Trim();
                }
                else
                {
                    title = header.Trim();
                }

                if (string.IsNullOrEmpty(title)) continue;

                passageOrder.Add(title);

                var info = new TagInfo();

                if (!string.IsNullOrEmpty(tagsPart))
                {
                    var parts = tagsPart.Split(new[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);
                    foreach (var p in parts)
                    {
                        string tag = p.Trim();
                        if (string.IsNullOrEmpty(tag)) continue;

                        if (tag.StartsWith("background_instant:", StringComparison.OrdinalIgnoreCase))
                        {
                            info.backgroundInstant = true;
                            info.background = tag.Substring("background_instant:".Length).Trim();
                        }
                        else if (tag.StartsWith("background:", StringComparison.OrdinalIgnoreCase))
                        {
                            info.backgroundInstant = false;
                            info.background = tag.Substring("background:".Length).Trim();
                        }
                        else if (tag.StartsWith("character_instant:", StringComparison.OrdinalIgnoreCase))
                        {
                            info.characterInstant = true;
                            info.character = tag.Substring("character_instant:".Length).Trim();
                        }
                        else if (tag.StartsWith("character:", StringComparison.OrdinalIgnoreCase))
                        {
                            info.characterInstant = false;
                            info.character = tag.Substring("character:".Length).Trim();
                        }
                        else if (tag.StartsWith("anim:", StringComparison.OrdinalIgnoreCase))
                        {
                            info.anim = tag.Substring("anim:".Length).Trim();
                        }
                        else if (tag.StartsWith("wait:", StringComparison.OrdinalIgnoreCase))
                        {
                            if (float.TryParse(tag.Substring("wait:".Length).Trim(), out float wt))
                                info.waitSeconds = Mathf.Max(0f, wt);
                        }
                    }
                }

                tagMap[title] = info;
            }
        }
    }
}
