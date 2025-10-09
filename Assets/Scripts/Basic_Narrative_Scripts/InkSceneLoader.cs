using UnityEngine;
using UnityEngine.SceneManagement;
using Ink.Runtime;

namespace DialogueSystem
{
    public class InkSceneLoader : MonoBehaviour
    {
        public NarrativePlayer narrativePlayer; 

        private Story inkStory;

        void Start()
        {
           
            // Check tags every few seconds (or trigger after each story advance)
            InvokeRepeating(nameof(CheckSceneTag), 0.5f, 0.5f);
        }

        void CheckSceneTag()
        {
            if (inkStory == null)
            {
                 if (narrativePlayer != null)
                 {
                    inkStory = narrativePlayer.story;
                    Debug.Log("No InkStory"); 
                 }
        
                return;
            }
               


            foreach (string tag in inkStory.currentTags)
            {
                Debug.Log(tag);
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
            SceneManager.LoadScene(sceneName);
        }
    }
}
