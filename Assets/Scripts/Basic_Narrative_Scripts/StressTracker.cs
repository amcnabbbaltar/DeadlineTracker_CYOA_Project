using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;

namespace DialogueSystem
{
    public class StressTracker : MonoBehaviour
    {
        [Header("References")]
        public NarrativePlayer narrativePlayer; // Drag your NarrativePlayer here
        public Text stressText; // UI text element to show variable changes

        private Story inkStory;

        void Start()
        {
            if (narrativePlayer != null)
            {
                inkStory = narrativePlayer.story;
            }

            // Update periodically
            InvokeRepeating(nameof(UpdateStressText), 1f, 0.5f);
        }

        void UpdateStressText()
        {
            if (narrativePlayer == null || narrativePlayer.story == null || stressText == null)
                return;

            var story = narrativePlayer.story;
            object val = story.variablesState["stress"];
            if (val == null)
                return;

            int stressValue = (int)val;

            // Just update the text with the new value
            stressText.text = $"Stress: {stressValue}";
        }
    }
}
