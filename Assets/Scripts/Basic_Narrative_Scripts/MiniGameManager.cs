using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;
using UnityEngine.SceneManagement;
namespace DialogueSystem
{
    public class MiniGameManager : MonoBehaviour
    {
        public NarrativePlayer narrativePlayer; // Drag your NarrativePlayer here
        private Story inkStory;
        private int Stress;
        public Text stressText;
        /// <summary>
        /// Awake is called when the script instance is being loaded.
        /// </summary>
        void Awake()
        {
            if (narrativePlayer == null)
            {
                narrativePlayer = GameObject.FindObjectOfType<NarrativePlayer>();
            }
        }
        /// <summary>
        /// Start is called on the frame when a script is enabled just before
        /// any of the Update methods is called the first time.
        /// </summary>
        void Start()
        {
            if (narrativePlayer != null)
            {
                inkStory = narrativePlayer.story;
            }
            
        }
        // Start is called before the first frame update
        public void UpdateStress()
        {
            GameSession.Instance.stressLevel++;
            stressText.text = $"Stress: { GameSession.Instance.stressLevel}";
            if(GameSession.Instance.stressLevel >  10)
            {
                SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex - 1);
            }
        }
    }
}
