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

        [Header("Ink Source")]
        [SerializeField] private TextAsset inkJSONAsset = null;
        public Story story;
        private int myChoices = 0;

        private string imagesPath;

        void Start()
        {
            if (inkJSONAsset == null)
            {
                Debug.LogError("No Ink JSON assigned!");
                return;
            }

            imagesPath = IOPath.Combine(Application.streamingAssetsPath, "Images");

            story = new Story(inkJSONAsset.text);
            RefreshInkView();

            DontDestroyOnLoad(gameObject);
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

        void RefreshInkView()
        {
            if (story == null) return;
            ClearChoices();

            StringBuilder sb = new StringBuilder();

            // Continue through story until we hit choices or end
            while (story.canContinue && story.currentChoices.Count == 0)
            {
                string line = story.Continue().Trim();
                if (!string.IsNullOrEmpty(line))
                    sb.AppendLine(line);

                HandleTags(story.currentTags);
            }

            if (passageText)
                passageText.text = sb.ToString().Trim();

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

        void HandleTags(List<string> tags)
        {
            if (tags == null || tags.Count == 0) return;

            foreach (string tag in tags)
            {
                if (tag.StartsWith("image:"))
                {
                    string imageName = tag.Substring("image:".Length).Trim();
                    LoadAndDisplayImage(imageName);
                }
            }
        }

        void LoadAndDisplayImage(string imageName)
        {
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
                if (storyImage)
                {
                    storyImage.sprite = Sprite.Create(texture,
                        new Rect(0, 0, texture.width, texture.height),
                        new Vector2(0.5f, 0.5f));
                    storyImage.preserveAspect = true;
                    storyImage.color = Color.white;
                }
            }
        }
    }
}
