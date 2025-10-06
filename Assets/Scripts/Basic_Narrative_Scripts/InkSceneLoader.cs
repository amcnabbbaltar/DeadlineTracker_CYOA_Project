using UnityEngine;
using UnityEngine.SceneManagement;
using Ink.Runtime;

namespace DialogueSystem
{
    public class InkSceneLoader : MonoBehaviour
    {
        public NarrativePlayer narrativePlayer; // Your main Ink player

        private Story inkStory;

        void Start()
        {
            if (narrativePlayer != null)
                inkStory = narrativePlayer.story;

            // Check tags every few seconds (or trigger after each story advance)
            InvokeRepeating(nameof(CheckSceneTag), 0.5f, 0.5f);
        }

        void CheckSceneTag()
        {
            if (inkStory == null)
                return;

            foreach (string tag in inkStory.currentTags)
            {
                if (tag.StartsWith("scene:"))
                {
                    string sceneName = tag.Substring("scene:".Length).Trim();
                    LoadScene(sceneName);
                    break;
                }
            }
        }

        void LoadScene(string sceneName)
        {
            Debug.Log($"Loading scene: {sceneName}");
            SceneManager.LoadScene(sceneName);
        }
    }
}
