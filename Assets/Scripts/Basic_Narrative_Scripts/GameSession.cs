using UnityEngine;
using UnityEngine.SceneManagement;
using Ink.Runtime;
public class GameSession : MonoBehaviour
{
    public static GameSession Instance;
    public int stressLevel = 0;

    private void Awake()
    {
        if (Instance == null)
        {
            Instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }
    }
}