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

        [Header("Ink Source")]
        [SerializeField] private TextAsset inkJSONAsset = null;
        public Story story;
        private int myChoices = 0;

        void Start()
        {
            if (inkJSONAsset == null)
            {
                Debug.LogError("No Ink JSON assigned!");
                return;
            }

            story = new Story(inkJSONAsset.text);
            RefreshInkView();
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

            // Collect all text until a choice or until story ends
            StringBuilder sb = new StringBuilder();

            // Pull lines until:
            //  - story.canContinue == false (end)
            //  - OR story.currentChoices.Count > 0 (player decision)
            while (story.canContinue && story.currentChoices.Count == 0)
            {
                string line = story.Continue().Trim();
                if (!string.IsNullOrEmpty(line))
                    sb.AppendLine(line);
            }

            // Display the text we just collected
            if (passageText)
                passageText.text = sb.ToString().Trim();

            // === HANDLE CHOICES ===
            if (story.currentChoices.Count > 0)
            {
                // Present player choices
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
                // No choices yet, but still text to continue later
                AddChoiceButton("Continue", () =>
                {
                    RefreshInkView();
                });
            }
            else
            {
                // END reached
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
    }
}
