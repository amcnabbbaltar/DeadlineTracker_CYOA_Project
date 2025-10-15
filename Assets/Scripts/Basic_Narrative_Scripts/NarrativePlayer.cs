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
using UnityEngine.TextCore.Text;
using static UnityEngine.GraphicsBuffer;

namespace DialogueSystem
{
    public class NarrativePlayer : MonoBehaviour
    {
        [Header("UI Components")]
        public TextMeshProUGUI passageText;
        public Button choiceButtonPrefab;
        public Transform choiceButtonContainer;
        public TextMeshProUGUI myChoiceCounterUI;
        [SerializeField] public Image storyImage; // ✅ Add this to show scene illustrations
        [SerializeField] public Image storyBackground; // ✅ Add this to show scene illustrations
        public Animator storyImageAnimator;
        public Animation storyImageAnimation;

        [Header("Ink Source")]
        [SerializeField] private UnityEngine.TextAsset inkJSONAsset = null;
        public Story story;
        private int myChoices = 0;

        public string imagesPath = "Dialogue_Exemples\\images";
        public string animationsPath = "Dialogue_Exemples\\Animations";

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
                    LoadAndDisplayImageFade(background, storyBackground);
                }
                if (tag.StartsWith("background_instant:"))
                {
                    string background = tag.Substring("background_instant:".Length).Trim();
                    Debug.Log($"Instantly switching background to: {background}");
                    LoadAndDisplayImageInstant(background, storyBackground);
                }
                else if (tag.StartsWith("character:"))
                {
                    string character = tag.Substring("character:".Length).Trim();
                    if (storyImageAnimator) storyImageAnimator.enabled = false; // Turning off the animation so that it doesn't override the image
                    Debug.Log($"Switching character to: {character}");
                    LoadAndDisplayImageFade(character, storyImage);

                }
                else if (tag.StartsWith("character_instant:"))
                {
                    string character = tag.Substring("character_instant:".Length).Trim();
                    if (storyImageAnimator) storyImageAnimator.enabled = false; // Turning off the animation so that it doesn't override the image
                    Debug.Log($"Instantly switching character to: {character}");
                    LoadAndDisplayImageInstant(character, storyImage);

                }
                else if (tag.StartsWith("anim:"))
                {
                    string animation = tag.Substring("anim:".Length).Trim();

                    if (storyImageAnimator)
                    {
                        storyImageAnimator.enabled = true;
                        Debug.Log($"Switching character animation to: {animation}");
                        LoadAndDisplayAnimationFade(animation, storyImage);
                        

                    }
                    else
                    {
                        Debug.LogWarning("No Animator assigned to storyImageAnimator.");
                    }
                }
                else if (tag.StartsWith("anim_instant:"))
                {
                    string animation = tag.Substring("anim_instant:".Length).Trim();

                    if (storyImageAnimator)
                    {
                        storyImageAnimator.enabled = true;
                        Debug.Log($"Instantly switching character animation to: {animation}");
                        LoadAndDisplayAnimationInstant(animation, storyImage);


                    }
                    else
                    {
                        Debug.LogWarning("No Animator assigned to storyImageAnimator.");
                    }
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
    
    void LoadAndDisplayImageFade(string imageName, Image targetImage) // Added target image variable to specify what to change (image or background)
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

        void LoadAndDisplayImageInstant(string imageName, Image targetImage) // Added target image variable to specify what to change (image or background)
        {

            if (targetImage == null)
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

                // Use abrupt swap
                targetImage.sprite = newSprite;
                targetImage.preserveAspect = true;
            }
        }
        void LoadAndDisplayAnimationFade(string animationName, Image targetImage) // Added target animation variable to specify what to change
        {

            if (targetImage == null)
            {
                Debug.LogWarning("No target animation assigned for " + animationName);
                return;

            }

            string filePath = IOPath.Combine(animationsPath, animationName + ".anim");

            if (!File.Exists(filePath))
            {
                Debug.LogWarning("Animation not found: " + filePath);
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
        
        void LoadAndDisplayAnimationInstant(string animationName, Image targetImage) // Added target animation variable to specify what to change
        {

            if (targetImage == null)
            {
                Debug.LogWarning("No target animation assigned for " + animationName);
                return;

            }

            string filePath = IOPath.Combine(animationsPath, animationName + ".anim");

            if (!File.Exists(filePath))
            {
                Debug.LogWarning("Animation not found: " + filePath);
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


                // Use abrupt swap
                targetImage.sprite = newSprite;
                targetImage.preserveAspect = true;
            }
        }

    }
}
