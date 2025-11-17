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
        [SerializeField] public Image storyImage;
        [SerializeField] public Image storyBackground;
        public Animator storyImageAnimator;

        [Header("Ink Source")]
        [SerializeField] private UnityEngine.TextAsset inkJSONAsset = null;
        public Story story;
        private int myChoices = 0;

        public string imagesPath = "Dialogue_Exemples\\images";
        public string animationsPath = "Dialogue_Exemples\\Animations";

        [Header("Typewriter Settings")]
        public float typeDelay = 0.02f;
        public bool typing = false;

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

        // -------------------------------------------------
        // MAIN REFRESH + TYPEWRITER
        // -------------------------------------------------
        void RefreshInkView(bool processAfterWait = false)
        {
            if (story == null) return;

            ClearChoices();
            StopAllCoroutines();

            StringBuilder sb = new StringBuilder();
            bool hitWaitTag = false;

            while (story.canContinue && !hitWaitTag)
            {
                string line = story.Continue().Trim();

                bool hadTags = story.currentTags != null && story.currentTags.Count > 0;
                if (hadTags)
                    hitWaitTag = HandleTags(story.currentTags);

                if (!string.IsNullOrEmpty(line))
                    sb.AppendLine(line);

                if (hitWaitTag)
                    break;
            }

            // Typewriter instead of instant text
            StartCoroutine(TypeText(sb.ToString().Trim()));

            if (hitWaitTag)
                return;

            if (!story.canContinue && story.currentChoices.Count == 0)
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

        // -------------------------------------------------
        // TYPEWRITER SYSTEM
        // -------------------------------------------------
        IEnumerator TypeText(string fullText)
        {
            typing = true;
            passageText.text = "";

            Canvas.ForceUpdateCanvases();

            for (int i = 0; i < fullText.Length; i++)
            {
                // Skip typing if click
                if (Input.GetMouseButtonDown(0))
                {
                    passageText.text = fullText;
                    break;
                }

                passageText.text += fullText[i];

                // Resize text height for ScrollRect
                var rt = passageText.GetComponent<RectTransform>();
                rt.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, passageText.preferredHeight);

                Canvas.ForceUpdateCanvases();

                yield return new WaitForSeconds(typeDelay);
            }

            typing = false;
            DisplayChoicesAfterTyping();
        }

        void DisplayChoicesAfterTyping()
        {
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
        }

        // -------------------------------------------------
        // TAG HANDLING
        // -------------------------------------------------
        bool HandleTags(List<string> tags)
        {
            if (tags == null || tags.Count == 0)
                return false;

            foreach (string tag in tags)
            {
                if (tag.StartsWith("background:"))
                {
                    string background = tag.Substring("background:".Length).Trim();
                    LoadAndDisplayImageFade(background, storyBackground);
                }
                else if (tag.StartsWith("background_instant:"))
                {
                    string background = tag.Substring("background_instant:".Length).Trim();
                    LoadAndDisplayImageInstant(background, storyBackground);
                }
                else if (tag.StartsWith("character:"))
                {
                    string character = tag.Substring("character:".Length).Trim();
                    if (storyImageAnimator) storyImageAnimator.enabled = false;
                    LoadAndDisplayImageFade(character, storyImage);
                }
                else if (tag.StartsWith("character_instant:"))
                {
                    string character = tag.Substring("character_instant:".Length).Trim();
                    if (storyImageAnimator) storyImageAnimator.enabled = false;
                    LoadAndDisplayImageInstant(character, storyImage);
                }
                else if (tag.StartsWith("anim:"))
                {
                    string animation = tag.Substring("anim:".Length).Trim();
                    if (storyImageAnimator)
                    {
                        storyImageAnimator.enabled = true;
                    }
                }
                else if (tag.StartsWith("wait:"))
                {
                    if (float.TryParse(tag.Substring(5), out float waitTime))
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
            foreach (Transform child in choiceButtonContainer)
                child.gameObject.SetActive(false);

            yield return new WaitForSeconds(waitTime);

            if (story.canContinue || story.currentChoices.Count > 0)
                RefreshInkView(true);
            else
                AddChoiceButton("Continue", () => RefreshInkView());
        }

        // -------------------------------------------------
        // IMAGE LOADING + FADE
        // -------------------------------------------------
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
            target.preserveAspect = true;

            t = 0f;
            while (t < fadeDuration)
            {
                t += Time.deltaTime;
                c.a = Mathf.Lerp(0f, 1f, t / fadeDuration);
                target.color = c;
                yield return null;
            }
        }

        void LoadAndDisplayImageFade(string imageName, Image targetImage)
        {
            if (targetImage == null) return;

            string filePath = IOPath.Combine(imagesPath, imageName + ".png");
            if (!File.Exists(filePath))
                return;

            byte[] bytes = File.ReadAllBytes(filePath);
            Texture2D texture = new Texture2D(2, 2);

            if (texture.LoadImage(bytes))
            {
                Sprite newSprite = Sprite.Create(
                    texture,
                    new Rect(0, 0, texture.width, texture.height),
                    new Vector2(0.5f, 0.5f));

                StartCoroutine(FadeImageTransition(newSprite, targetImage));
            }
        }

        void LoadAndDisplayImageInstant(string imageName, Image targetImage)
        {
            if (targetImage == null) return;

            string filePath = IOPath.Combine(imagesPath, imageName + ".png");
            if (!File.Exists(filePath))
                return;

            byte[] bytes = File.ReadAllBytes(filePath);
            Texture2D texture = new Texture2D(2, 2);

            if (texture.LoadImage(bytes))
            {
                Sprite newSprite = Sprite.Create(
                    texture,
                    new Rect(0, 0, texture.width, texture.height),
                    new Vector2(0.5f, 0.5f));

                targetImage.sprite = newSprite;
                targetImage.preserveAspect = true;
            }
        }
    }
}
