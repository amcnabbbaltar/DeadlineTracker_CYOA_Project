using System.Collections;
using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using IOPath = System.IO.Path;
using System.IO;
[Serializable]
public class StoryMetadata
{
    public string start;
}
namespace SimpleTwineDialogue
{
    public class TextAdventure : MonoBehaviour
    {
        [Header("UI Components")] 
        public TextMeshProUGUI passageText;
        public Button choiceButtonPrefab;
        public Transform choiceButtonContainer;
        public Transform imageContainer;
        public Image imagePrefab;

        public TextMeshProUGUI myChoiceCounterUI;
        private int myChoices = 0;

        [Header("Typewriter Settings")] 
        public float typeDelay = 0.02f;
        public bool typing = false;

        [Header("Fade Settings")] 
        public float fadeDuration = 0.8f;

        [Header("Character + Background images")] 
        public Image storyImage;
        public Image storyBackground;
        public Animator storyImageAnimator;

        [Header("Story Settings")]
        public string startPassageName = "Start";

        [Header("Local Twee File")]
        public TextAsset tweeTextAsset;   // <---- ONLY THIS IS USED NOW

        private TweeParser tweeParser = new TweeParser();
        private Dictionary<string, TweeParser.Passage> passages;
        private string currentPassageTitle;

        

        void Start()
        {
            LoadFromTextAsset();
        }

        // ====================================
        // LOAD TWEE FROM TEXTASSET
        // ====================================
        void LoadFromTextAsset()
        {
            if (tweeTextAsset == null)
            {
                Debug.LogError("No Twee TextAsset assigned!");
                return;
            }

            passages = tweeParser.ParseTweeFileFromText(tweeTextAsset.text);

            CheckForStartPassage();
        }


        void CheckForStartPassage()
        {
            // Auto-find SugarCube start passage
            if (passages.ContainsKey("StoryData"))
            {
                var json = passages["StoryData"].Body.Trim();
                if (json.StartsWith("{"))
                {
                    try
                    {
                        var data = JsonUtility.FromJson<StoryMetadata>(json);
                        if (!string.IsNullOrWhiteSpace(data.start) && passages.ContainsKey(data.start))
                        {
                            Debug.Log("Using SugarCube start passage: " + data.start);
                            DisplayPassage(data.start);
                            return;
                        }
                    }
                    catch { }
                }
            }

            if (!string.IsNullOrWhiteSpace(startPassageName) &&
                passages.ContainsKey(startPassageName))
            {
                DisplayPassage(startPassageName);
                return;
            }

            // Fallback: use first passage found in the file
            foreach (var p in passages.Keys)
            {
                Debug.LogWarning("Start passage missing, using first passage: " + p);
                DisplayPassage(p);
                return;
            }

            Debug.LogError("No passages found at all.");
        }


        // ====================================
        // DISPLAY PASSAGE
        // ====================================
        public void DisplayPassage(string passageTitle)
        {
            if (!passages.TryGetValue(passageTitle, out var passage))
            {
                Debug.LogError("Passage not found: " + passageTitle);
                return;
            }

            currentPassageTitle = passageTitle;

            ClearChoices();
            ClearImages();

            HandleTags(passage.Tags);

            StopAllCoroutines();
            StartCoroutine(TypeTextRoutine(passage.Body, passage));
        }

        IEnumerator TypeTextRoutine(string content, TweeParser.Passage passage)
        {
            typing = true;
            passageText.text = "";
            Canvas.ForceUpdateCanvases();

            for (int i = 0; i < content.Length; i++)
            {
                if (Input.GetMouseButtonDown(0))
                {
                    passageText.text = content;
                    break;
                }

                passageText.text += content[i];
                Canvas.ForceUpdateCanvases();
                yield return new WaitForSeconds(typeDelay);
            }

            typing = false;
            yield return StartCoroutine(ShowChoicesRoutine(passage));
        }

        IEnumerator ShowChoicesRoutine(TweeParser.Passage passage)
        {
            if (passage.WaitTime > 0)
                yield return new WaitForSeconds(passage.WaitTime);

            if (passage.Choices.Count > 0)
            {
                foreach (var c in passage.Choices)
                    CreateChoiceButton(c.Display, c.Target);
            }
            else
            {
                CreateChoiceButton("Restart", "Start");
            }
        }

        void CreateChoiceButton(string label, string target)
        {
            var btn = Instantiate(choiceButtonPrefab, choiceButtonContainer);
            btn.GetComponentInChildren<TextMeshProUGUI>().text = label;

            btn.onClick.AddListener(() =>
            {
                myChoices++;
                if (myChoiceCounterUI)
                    myChoiceCounterUI.text = "Choices: " + myChoices;

                DisplayPassage(target);
            });
        }

        // ====================================
        // TAG HANDLING (unchanged)
        // ====================================
        void HandleTags(List<string> tags)
        {
            if (tags == null) return;

            foreach (string t in tags)
            {
                if (t.StartsWith("background:"))
                {
                    string name = t.Substring("background:".Length).Trim();
                    StartCoroutine(LoadBackgroundFade(name));
                }
                else if (t.StartsWith("background_instant:"))
                {
                    string name = t.Substring("background_instant:".Length).Trim();
                    StartCoroutine(LoadBackgroundInstant(name));
                }
                else if (t.StartsWith("character:"))
                {
                    string name = t.Substring("character:".Length).Trim();
                    if (storyImageAnimator) storyImageAnimator.enabled = false;
                    StartCoroutine(LoadCharacterFade(name));
                }
                else if (t.StartsWith("character_instant:"))
                {
                    string name = t.Substring("character_instant:".Length).Trim();
                    if (storyImageAnimator) storyImageAnimator.enabled = false;
                    StartCoroutine(LoadCharacterInstant(name));
                }
                else if (t.StartsWith("anim:"))
                {
                    if (storyImageAnimator)
                        storyImageAnimator.enabled = true;
                }
            }
        }

        // ====================================
        // LOCAL IMAGE LOADING (unchanged)
        // ====================================
        IEnumerator LoadBackgroundFade(string name)
        {
            yield return StartCoroutine(LoadSpriteRoutine(name, sprite =>
                StartCoroutine(FadeTransition(sprite, storyBackground))
            ));
        }

        IEnumerator LoadBackgroundInstant(string name)
        {
            yield return StartCoroutine(LoadSpriteRoutine(name, sprite =>
                storyBackground.sprite = sprite
            ));
        }

        IEnumerator LoadCharacterFade(string name)
        {
            yield return StartCoroutine(LoadSpriteRoutine(name, sprite =>
                StartCoroutine(FadeTransition(sprite, storyImage))
            ));
        }

        IEnumerator LoadCharacterInstant(string name)
        {
            yield return StartCoroutine(LoadSpriteRoutine(name, sprite =>
                storyImage.sprite = sprite
            ));
        }

        IEnumerator LoadSpriteRoutine(string filename, System.Action<Sprite> apply)
        {
            string path = IOPath.Combine(Application.streamingAssetsPath, filename + ".png");

            if (!File.Exists(path))
                yield break;

            Texture2D tex = new Texture2D(2, 2);
            tex.LoadImage(File.ReadAllBytes(path));

            Sprite s = Sprite.Create(tex, new Rect(0, 0, tex.width, tex.height), new Vector2(0.5f, 0.5f));
            apply?.Invoke(s);
        }

        IEnumerator FadeTransition(Sprite newSprite, Image target)
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

        void ClearChoices()
        {
            foreach (Transform child in choiceButtonContainer)
                Destroy(child.gameObject);
        }

        void ClearImages()
        {
            foreach (Transform child in imageContainer)
                Destroy(child.gameObject);
        }
    }
}
