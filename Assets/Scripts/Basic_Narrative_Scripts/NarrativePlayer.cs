using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;
using IOPath = System.IO.Path;

namespace DialogueSystem
{
    public class NarrativePlayer : MonoBehaviour
    {
        [Header("UI Components")]
        public TextMeshProUGUI passageText;
        public Button choiceButtonPrefab;
        public Transform choiceButtonContainer;
        public TextMeshProUGUI myChoiceCounterUI;
        public Image storyImage; // ✅ Add this to show scene illustrations
        public Image storyBackground; // ✅ Add this to show scene illustrations

        [Header("Ink Source")]
        [SerializeField] private TextAsset inkJSONAsset = null;
        public Story story;
        private int myChoices = 0;

        public string imagesPath = "Dialogue_Exemples\\images";

        void Start()
        {
            if (inkJSONAsset == null)
            {
                Debug.LogError("No Ink JSON assigned!");
                return;
            }


            story = new Story(inkJSONAsset.text);
            SetGameSessionVariables();
            RefreshInkView();


        }
       
        void SetGameSessionVariables()
        {
            story.variablesState["stress"] = GameSession.Instance.stressLevel;
        }

        void ClearChoices()
        {
            for (int i = choiceButtonContainer.childCount - 1; i >= 0; i--)
                Destroy(choiceButtonContainer.GetChild(i).gameObject);
        }

        Button AddChoiceButton(string label, Action onClick)
        {
            var btn = Instantiate(choiceButtonPrefab, choiceButtonContainer);
            var tmp = btn.GetComponentInChildren<TextMeshProUGUI>();
            if (tmp) tmp.text = label;
            btn.onClick.AddListener(() =>
            {
                myChoices++;
                if (myChoiceCounterUI)
                    myChoiceCounterUI.text = "Choices made: " + myChoices;
                onClick?.Invoke();
            });
            return btn;
        }

        void RefreshInkView(bool processAfterWait = false)
        {
            if (story == null) return;
            ClearChoices();

            StringBuilder sb = new StringBuilder();
            bool hitWaitTag = false;

            // Continue until we hit a wait or reach choices/end
            while (story.canContinue && !hitWaitTag)
            {
                string line = story.Continue().Trim();

                // Always process tags *after* continuing
                bool hadTags = story.currentTags != null && story.currentTags.Count > 0;
                if (hadTags)
                    hitWaitTag = HandleTags(story.currentTags);

                // Append text after handling tags
                if (!string.IsNullOrEmpty(line))
                    sb.AppendLine(line);

                if (hitWaitTag)
                    break;
            }

            if (passageText)
                passageText.text = sb.ToString().Trim();

            // If we hit a wait, stop here — coroutine will resume later
            if (hitWaitTag)
                return;

            // === Handle choices ===
            if (story.currentChoices.Count > 0)
            {
                foreach (Choice c in story.currentChoices)
                {
                    AddChoiceButton(c.text.Trim(), () =>
                    {
                        story.ChooseChoiceIndex(c.index);
                        RefreshInkView();
                    });
                }
            }
            else if (story.canContinue)
            {
                AddChoiceButton("Continue", () => RefreshInkView());
            }
            else
            {
                AddChoiceButton("Restart story", () =>
                {
                    story.ResetState();
                    myChoices = 0;
                    if (myChoiceCounterUI)
                        myChoiceCounterUI.text = "Choices made: 0";
                    RefreshInkView();
                });
            }
        }

        bool HandleTags(List<string> tags)
        {
            if (tags == null || tags.Count == 0)
                return false;

            foreach (string tag in tags)
            {
                //if (tag.StartsWith("image:"))
                //{
                //    string imageName = tag.Substring("image:".Length).Trim();
                //    Debug.Log($"Switching image to: {imageName}");
                //    LoadAndDisplayImage(imageName);
                //}
                if (tag.StartsWith("background:"))
                {
                    string background = tag.Substring("background:".Length).Trim();
                    Debug.Log($"Switching background to: {background}");
                    LoadAndDisplayImage(background, storyBackground);
                }
                else if (tag.StartsWith("character:"))
                {
                    string character = tag.Substring("character:".Length).Trim();
                    Debug.Log($"Switching character to: {character}");
                    LoadAndDisplayImage(character, storyImage);

                    //// If you detect it's a gif animation tag, just checking if the file name ends with "_gif"
                    //if (character.EndsWith("_gif"))
                    //    StartCoroutine(PlayGifLikeAnimation(character.Replace("_gif", ""), storyImage)); // So, checking the ink files for "XXX_gif", the "XXX" will be the base name
                    //else
                    //    LoadAndDisplayImage(character, storyImage);
                }
                else if (tag.StartsWith("wait:"))
                {
                    string timeStr = tag.Substring("wait:".Length).Trim();
                    if (float.TryParse(timeStr, out float waitTime))
                    {
                        StartCoroutine(WaitAndContinue(waitTime));
                        return true;
                    }
                }
                
            }

            return false;
        }

        IEnumerator WaitAndContinue(float waitTime)
        {
            // Optional: disable buttons during wait
            foreach (Transform child in choiceButtonContainer)
                child.gameObject.SetActive(false);

            yield return new WaitForSeconds(waitTime);

            Debug.Log($"Wait finished ({waitTime}s), resuming Ink...");

            // ✅ Resume story properly
            if (story.canContinue || story.currentChoices.Count > 0)
                RefreshInkView(true);
            else
                AddChoiceButton("Continue", () => RefreshInkView());
        }

        IEnumerator FadeImageTransition(Sprite newSprite, Image target, float fadeDuration = 0.8f) // Changed this to be neutral to any target and not only storyImage
        {
            if (target == null)
                yield break;

            // Ensure an Image component exists and has a color
            Color c = target.color;

            // 1. Fade out
            float t = 0f;
            while (t < fadeDuration)
            {
                t += Time.deltaTime;
                c.a = Mathf.Lerp(1f, 0f, t / fadeDuration);
                target.color = c;
                yield return null;
            }

            // 2. Swap sprite once invisible
            target.sprite = newSprite;
            target.preserveAspect = true;

            // 3. Fade back in
            t = 0f;
            while (t < fadeDuration)
            {
                t += Time.deltaTime;
                c.a = Mathf.Lerp(0f, 1f, t / fadeDuration);
                target.color = c;
                yield return null;
            }
        }
        void LoadAndDisplayImage(string imageName, Image targetImage) // Added target image variable to specify what to change (image or background)
        {

            if(targetImage == null)
            {
                Debug.LogWarning("No target image assigned for " + imageName);
                return;

            }

            string filePath = IOPath.Combine(imagesPath, imageName + ".png");

            if (!File.Exists(filePath))
            {
                Debug.LogWarning("Image not found: " + filePath);
                return;
            }

            byte[] bytes = File.ReadAllBytes(filePath);
            Texture2D texture = new Texture2D(2, 2);
            if (texture.LoadImage(bytes))
            {
                Sprite newSprite = Sprite.Create(
                    texture,
                    new Rect(0, 0, texture.width, texture.height),
                    new Vector2(0.5f, 0.5f)
                );

                // Use fade transition instead of abrupt swap
                StartCoroutine(FadeImageTransition(newSprite, targetImage));
            }
        }

        //IEnumerator PlayGifLikeAnimation(string baseName, Image target, float frameRate = 0.04f, float fadeDuration = 0.8f)
        //{
        //    string folder = IOPath.Combine(imagesPath, baseName + "_frames");
        //    if (!Directory.Exists(folder))
        //    {
        //        Debug.LogWarning("No frames folder for " + baseName);
        //        yield break;
        //    }

        //    string[] frameFiles = Directory.GetFiles(folder, "*.png");
        //    if (frameFiles.Length == 0)
        //    {
        //        Debug.LogWarning("No frames found in " + folder);
        //        yield break;
        //    }

        //    // Loading all the frames as sprites
        //    List<Sprite> frames = new List<Sprite>();
        //    foreach (string file in frameFiles)
        //    {
        //        byte[] bytes = File.ReadAllBytes(file);
        //        Texture2D tex = new Texture2D(2, 2);
        //        tex.LoadImage(bytes);
        //        frames.Add(Sprite.Create(tex, new Rect(0, 0, tex.width, tex.height), new Vector2(0.5f, 0.5f)));
        //    }

        //    yield return StartCoroutine(FadeImageTransition(frames[0], target, fadeDuration)); // fading

        //    // Loop animation
        //    while (true)
        //    {
        //        foreach (Sprite s in frames)
        //        {
        //            target.sprite = s;
        //            target.preserveAspect = true;
        //            yield return new WaitForSeconds(frameRate);
        //        }
        //    }
        //}


    }
}
