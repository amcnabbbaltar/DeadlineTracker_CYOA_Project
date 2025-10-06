using UnityEngine;
using TMPro;
using Ink.Runtime;

namespace DialogueSystem
{
    public class StressTracker : MonoBehaviour
    {
        [Header("References")]
        public NarrativePlayer narrativePlayer; // Drag your NarrativePlayer here
        public TMP_Text stressText; // UI text element to show variable changes

        private Story inkStory;
        private int stressValue;

        void Start()
        {
            if (narrativePlayer != null)
            {
                inkStory = narrativePlayer.story;
            }

            // Update periodically
            InvokeRepeating(nameof(UpdateStressFromStory), 1f, 0.5f);

            DontDestroyOnLoad(gameObject);
        }

        void UpdateStressFromStory()
        {
            if (narrativePlayer == null || narrativePlayer.story == null || stressText == null)
                return;

            var story = narrativePlayer.story;
            object val = story.variablesState["stress"];
            if (val == null)
                return;

            GameSession.Instance.stressLevel = (int)val;

            stressText.text = $"Stress: { GameSession.Instance.stressLevel}";
        }
    }
}
