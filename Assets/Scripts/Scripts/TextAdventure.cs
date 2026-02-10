using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace SimpleTwineDialogue
{
    public class TextAdventure : MonoBehaviour
    {
        [Header("UI Components")]
        public TextMeshProUGUI passageText;
        public Button choiceButtonPrefab;
        public Transform choiceButtonContainer;

        [Header("Optional: legacy multi-image system (can still be used)")]
        public Transform imageContainer;
        public Image imagePrefab;

        [Header("Narrative-style Images (like NarrativePlayer)")]
        public Image storyImage;          // character
        public Image storyBackground;     // background
        public Animator storyImageAnimator;

        [Header("Choice Counter (Optional)")]
        public TextMeshProUGUI myChoiceCounterUI;

        [Header("Local File Loading (StreamingAssets)")]
        [Tooltip("Twee/Twine file stored in StreamingAssets. Example: story.twee")]
        public string localFileName = "story.twee";

        [Tooltip("Optional subfolder under StreamingAssets for images. Example: Images (leave empty for root)")]
        public string imagesSubfolder = "Images";

        [Header("Start Passage Settings")]
        public string startPassageTitle = "Start";
        public bool autoDetectStartPassage = true;
        public List<string> startPassageCandidates = new List<string> { "Start", "BEGIN", "Begin", "Intro", "Introduction", "Home" };
        public bool fallbackToFirstPassage = true;

        [Header("Multiple Entry Points (Optional)")]
        public bool allowExternalStartCalls = true;

        [Header("Typewriter Settings")]
        public float typeDelay = 0.02f;
        public bool typing = false;

        [Header("Image Fade Settings")]
        public float imageFadeDuration = 0.8f;

        [Header("Tag Parsing")]
        [Tooltip("Supports lines like '::tag background:Forest' or '#background:Forest' inside the passage body.")]
        public bool removeTagLinesFromDisplayedText = true;

        private TweeParser tweeParser;
        private Dictionary<string, TweeParser.Passage> passages;

        private string currentPassageTitle;
        private int myChoices = 0;

        // used for wait:
        private bool waiting = false;

        // Animator parameter names (optional, if you want to mirror your other animator usage)
        // const string ANIM_HANGING = "IsHangingFromWall"; // example

        void Start()
        {
            tweeParser = new TweeParser();
            StartCoroutine(LoadTweeFileFromStreamingAssets());
        }

        // ---------- Public API ----------

        public void RestartStory()
        {
            myChoices = 0;
            UpdateChoiceCounter();
            TryStartStory();
        }

        public void StartAtPassage(string passageTitle)
        {
            if (!allowExternalStartCalls)
            {
                Debug.LogWarning("External start calls are disabled (allowExternalStartCalls=false).");
                return;
            }

            if (passages == null || passages.Count == 0)
            {
                Debug.LogError("Passages not loaded yet.");
                return;
            }

            passageTitle = ResolvePassageKeyCaseInsensitive(passageTitle);
            if (string.IsNullOrEmpty(passageTitle))
            {
                Debug.LogError($"Passage '{passageTitle}' not found.");
                return;
            }

            myChoices = 0;
            UpdateChoiceCounter();
            DisplayPassage(passageTitle);
        }

        public List<string> GetAllPassageTitles()
        {
            if (passages == null) return new List<string>();
            return passages.Keys.OrderBy(k => k).ToList();
        }

        // ---------- Loading ----------

        IEnumerator LoadTweeFileFromStreamingAssets()
        {
            string filePath = Path.Combine(Application.streamingAssetsPath, localFileName);

            if (!File.Exists(filePath))
            {
                Debug.LogError("Twee file not found in StreamingAssets: " + filePath);
                yield break;
            }

            string text = File.ReadAllText(filePath, Encoding.UTF8);
            passages = tweeParser.ParseTweeFileFromText(text);

            if (passages == null || passages.Count == 0)
            {
                Debug.LogError("No passages parsed from Twee file.");
                yield break;
            }

            TryStartStory();
        }

        void TryStartStory()
        {
            if (passages == null || passages.Count == 0)
            {
                Debug.LogError("Passages not loaded.");
                return;
            }

            // 1) Explicit start
            if (!string.IsNullOrWhiteSpace(startPassageTitle))
            {
                var resolved = ResolvePassageKeyCaseInsensitive(startPassageTitle);
                if (!string.IsNullOrEmpty(resolved))
                {
                    DisplayPassage(resolved);
                    return;
                }
            }

            // 2) Auto-detect
            if (autoDetectStartPassage && startPassageCandidates != null)
            {
                foreach (var c in startPassageCandidates.Where(s => !string.IsNullOrWhiteSpace(s)))
                {
                    var resolved = ResolvePassageKeyCaseInsensitive(c.Trim());
                    if (!string.IsNullOrEmpty(resolved))
                    {
                        DisplayPassage(resolved);
                        return;
                    }
                }
            }

            // 3) Fallback
            if (fallbackToFirstPassage)
            {
                var first = passages.Keys.OrderBy(k => k).FirstOrDefault();
                if (!string.IsNullOrEmpty(first))
                {
                    Debug.LogWarning($"No start passage found. Falling back to first passage: '{first}'");
                    DisplayPassage(first);
                    return;
                }
            }

            Debug.LogError("Could not determine a start passage.");
        }

        string ResolvePassageKeyCaseInsensitive(string key)
        {
            if (passages == null) return null;
            if (passages.ContainsKey(key)) return key;

            var map = passages.Keys.ToDictionary(k => k, k => k, StringComparer.OrdinalIgnoreCase);
            if (map.TryGetValue(key, out var realKey))
                return realKey;

            return null;
        }

        // ---------- Gameplay / UI ----------

        void OnChoiceSelected(string nextPassageTitle)
        {
            myChoices += 1;
            UpdateChoiceCounter();
            DisplayPassage(nextPassageTitle);
        }

        void UpdateChoiceCounter()
        {
            if (myChoiceCounterUI != null)
                myChoiceCounterUI.text = "Choices made: " + myChoices.ToString();
        }

        // Main render entry
        public void DisplayPassage(string passageTitle)
        {
            if (passages == null)
            {
                Debug.LogError("Passages not loaded.");
                return;
            }

            passageTitle = ResolvePassageKeyCaseInsensitive(passageTitle);
            if (string.IsNullOrEmpty(passageTitle))
            {
                Debug.LogError("Passage not found: " + passageTitle);
                return;
            }

            currentPassageTitle = passageTitle;

            // Cancel any ongoing typewriter / waits
            StopAllCoroutines();
            waiting = false;

            ClearChoices();
            ClearImagesLegacy();

            var passage = passages[passageTitle];

            // 1) Parse tags from passage text (NarrativePlayer-style)
            var tags = ExtractTagsFromBody(passage.Body ?? "", out string cleanedBody);

            // 2) Apply tags (images, anim, wait)
            bool hitWaitTag = HandleTags(tags);

            // 3) Typewriter text (skip on click)
            StartCoroutine(TypeText(cleanedBody));

            // If wait tag was found, choices will be shown after wait completes (not now)
            if (hitWaitTag)
                return;

            // 4) Show choices after typing finishes
            // (TypeText calls DisplayChoicesAfterTyping)
        }

        // ---------- Typewriter ----------

        IEnumerator TypeText(string fullText)
        {
            typing = true;
            if (passageText) passageText.text = "";

            fullText = (fullText ?? "").TrimEnd();

            for (int i = 0; i < fullText.Length; i++)
            {
                // click to skip typing
                if (Input.GetMouseButtonDown(0))
                {
                    if (passageText) passageText.text = fullText;
                    break;
                }

                if (passageText) passageText.text += fullText[i];
                yield return new WaitForSeconds(typeDelay);
            }

            typing = false;

            // If we aren't in a wait state, reveal choices now
            if (!waiting)
                DisplayChoicesAfterTyping();
        }

        void DisplayChoicesAfterTyping()
        {
            if (passages == null) return;
            if (!passages.TryGetValue(currentPassageTitle, out var passage)) return;

            ClearChoices();

            if (passage.Choices != null && passage.Choices.Count > 0)
            {
                foreach (var choice in passage.Choices)
                {
                    if (choice == null) continue;

                    var btn = Instantiate(choiceButtonPrefab, choiceButtonContainer);
                    var label = btn.GetComponentInChildren<TextMeshProUGUI>();
                    if (label != null) label.text = choice.DisplayText ?? "";

                    string target = choice.TargetPassage;
                    btn.onClick.AddListener(() => OnChoiceSelected(target));
                }
            }
            else
            {
                // Optional: if no choices, offer restart
                var btn = Instantiate(choiceButtonPrefab, choiceButtonContainer);
                var label = btn.GetComponentInChildren<TextMeshProUGUI>();
                if (label != null) label.text = "Restart story";
                btn.onClick.AddListener(() => RestartStory());
            }
        }

        // ---------- Tag System (NarrativePlayer-like) ----------

        // Supports:
        //  ::tag background:Forest
        //  ::tag background_instant:Forest
        //  ::tag character:Hero
        //  ::tag character_instant:Hero
        //  ::tag anim:Wave   (just enables animator; you can expand to play named states)
        //  ::tag wait:1.5
        //
        // Also supports hashtag lines:
        //  #background:Forest
        //  #wait:1.5
        List<string> ExtractTagsFromBody(string body, out string cleanedBody)
        {
            var tags = new List<string>();
            var sb = new StringBuilder();

            using (var reader = new StringReader(body ?? ""))
            {
                string line;
                while ((line = reader.ReadLine()) != null)
                {
                    string trimmed = line.Trim();

                    bool isTagLine =
                        trimmed.StartsWith("::tag ", StringComparison.OrdinalIgnoreCase) ||
                        trimmed.StartsWith("#");

                    if (isTagLine)
                    {
                        // ::tag background:Forest
                        if (trimmed.StartsWith("::tag ", StringComparison.OrdinalIgnoreCase))
                        {
                            string tag = trimmed.Substring(6).Trim();
                            if (!string.IsNullOrEmpty(tag)) tags.Add(tag);
                        }
                        // #background:Forest
                        else if (trimmed.StartsWith("#"))
                        {
                            string tag = trimmed.Substring(1).Trim();
                            if (!string.IsNullOrEmpty(tag)) tags.Add(tag);
                        }

                        if (!removeTagLinesFromDisplayedText)
                            sb.AppendLine(line);

                        continue;
                    }

                    sb.AppendLine(line);
                }
            }

            cleanedBody = sb.ToString();
            return tags;
        }

        bool HandleTags(List<string> tags)
        {
            if (tags == null || tags.Count == 0)
                return false;

            foreach (string tag in tags)
            {
                if (tag.StartsWith("background:", StringComparison.OrdinalIgnoreCase))
                {
                    string background = tag.Substring("background:".Length).Trim();
                    StartCoroutine(LoadAndDisplayImageFade(background, storyBackground));
                }
                else if (tag.StartsWith("background_instant:", StringComparison.OrdinalIgnoreCase))
                {
                    string background = tag.Substring("background_instant:".Length).Trim();
                    StartCoroutine(LoadAndDisplayImageInstant(background, storyBackground));
                }
                else if (tag.StartsWith("character:", StringComparison.OrdinalIgnoreCase))
                {
                    string character = tag.Substring("character:".Length).Trim();
                    if (storyImageAnimator) storyImageAnimator.enabled = false;
                    StartCoroutine(LoadAndDisplayImageFade(character, storyImage));
                }
                else if (tag.StartsWith("character_instant:", StringComparison.OrdinalIgnoreCase))
                {
                    string character = tag.Substring("character_instant:".Length).Trim();
                    if (storyImageAnimator) storyImageAnimator.enabled = false;
                    StartCoroutine(LoadAndDisplayImageInstant(character, storyImage));
                }
                else if (tag.StartsWith("anim:", StringComparison.OrdinalIgnoreCase))
                {
                    // Minimal: just enable animator (mirrors your NarrativePlayer)
                    if (storyImageAnimator) storyImageAnimator.enabled = true;
                }
                else if (tag.StartsWith("wait:", StringComparison.OrdinalIgnoreCase))
                {
                    if (float.TryParse(tag.Substring(5).Trim(), out float waitTime))
                    {
                        StartCoroutine(WaitThenRevealChoices(waitTime));
                        return true; // stop flow like NarrativePlayer
                    }
                }
            }

            return false;
        }

        IEnumerator WaitThenRevealChoices(float waitTime)
        {
            waiting = true;

            // Hide existing choice buttons
            foreach (Transform child in choiceButtonContainer)
                child.gameObject.SetActive(false);

            yield return new WaitForSeconds(waitTime);

            waiting = false;

            // If text is still typing, let TypeText finish then show choices
            if (!typing)
                DisplayChoicesAfterTyping();
        }

        // ---------- Image Loading (StreamingAssets) + Fade ----------

        IEnumerator LoadAndDisplayImageFade(string imageNameNoExt, Image target)
        {
            if (target == null) yield break;

            var sprite = LoadSpriteFromStreamingAssets(imageNameNoExt);
            if (sprite == null) yield break;

            yield return FadeImageTransition(sprite, target, imageFadeDuration);
        }

        IEnumerator LoadAndDisplayImageInstant(string imageNameNoExt, Image target)
        {
            if (target == null) yield break;

            var sprite = LoadSpriteFromStreamingAssets(imageNameNoExt);
            if (sprite == null) yield break;

            target.sprite = sprite;
            target.preserveAspect = true;
        }

        Sprite LoadSpriteFromStreamingAssets(string imageNameNoExt)
        {
            if (string.IsNullOrWhiteSpace(imageNameNoExt))
                return null;

            // assumes png like NarrativePlayer; you can add jpg support if you want
            string fileName = imageNameNoExt.EndsWith(".png", StringComparison.OrdinalIgnoreCase)
                ? imageNameNoExt
                : (imageNameNoExt + ".png");

            string imagePath = string.IsNullOrWhiteSpace(imagesSubfolder)
                ? Path.Combine(Application.streamingAssetsPath, fileName)
                : Path.Combine(Application.streamingAssetsPath, imagesSubfolder, fileName);

            if (!File.Exists(imagePath))
            {
                Debug.LogWarning("Image not found: " + imagePath);
                return null;
            }

            byte[] bytes = File.ReadAllBytes(imagePath);
            var texture = new Texture2D(2, 2, TextureFormat.RGBA32, false);

            if (!texture.LoadImage(bytes))
            {
                Debug.LogWarning("Failed to decode image: " + imagePath);
                return null;
            }

            return Sprite.Create(
                texture,
                new Rect(0, 0, texture.width, texture.height),
                new Vector2(0.5f, 0.5f)
            );
        }

        IEnumerator FadeImageTransition(Sprite newSprite, Image target, float fadeDuration)
        {
            if (target == null) yield break;

            Color c = target.color;
            float t = 0f;

            // fade out
            while (t < fadeDuration)
            {
                t += Time.deltaTime;
                c.a = Mathf.Lerp(1f, 0f, t / fadeDuration);
                target.color = c;
                yield return null;
            }

            target.sprite = newSprite;
            target.preserveAspect = true;

            // fade in
            t = 0f;
            while (t < fadeDuration)
            {
                t += Time.deltaTime;
                c.a = Mathf.Lerp(0f, 1f, t / fadeDuration);
                target.color = c;
                yield return null;
            }
        }

        // ---------- Legacy Multi-Image (Optional) ----------

        void ClearImagesLegacy()
        {
            if (imageContainer == null) return;
            foreach (Transform child in imageContainer)
                Destroy(child.gameObject);
        }

        // ---------- Cleanup ----------

        void ClearChoices()
        {
            if (choiceButtonContainer == null) return;
            foreach (Transform child in choiceButtonContainer)
                Destroy(child.gameObject);
        }
    }
}
