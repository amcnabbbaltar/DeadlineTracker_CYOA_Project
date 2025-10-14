using JetBrains.Annotations;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class StressImageIndicator : MonoBehaviour
{
    // Start is called once before the first execution of Update after the MonoBehaviour is created

    public Image stressImage;
    public CanvasGroup canvasGroup;

    private static StressImageIndicator _instance;
    [Header("Fade Settings")]
    public float fadeSpeed = 2f;

    private float targetAlpha = 0f;

    void Start()
    {

        if (canvasGroup == null)
            canvasGroup = GetComponent<CanvasGroup>();
    }

    void Awake()
    {
        if (_instance != null) { Destroy(gameObject); return; }
        _instance = this;
        DontDestroyOnLoad(gameObject);              // survive scene loads
        if (!canvasGroup) canvasGroup = GetComponent<CanvasGroup>();
    }

    void OnEnable()
    {
        // after scene loads, reparent to the new Canvas if needed
        SceneManager.sceneLoaded += OnSceneLoaded;
    }
    void OnDisable()
    {
        SceneManager.sceneLoaded -= OnSceneLoaded;
    }

    void OnSceneLoaded(Scene s, LoadSceneMode m)
    {
        if (GetComponentInParent<Canvas>() == null)
        {
            var canvas = FindObjectOfType<Canvas>();
            if (canvas) transform.SetParent(canvas.transform, false);
        }
    }


    // Update is called once per frame
    void Update()
    {
        int stressLevel = GameSession.Instance.stressLevel;
        UpdateTargetAlpha(stressLevel);


        canvasGroup.alpha = Mathf.Lerp(canvasGroup.alpha, targetAlpha, Time.deltaTime * fadeSpeed);
    }

    void UpdateTargetAlpha(int stressLevel)
    {
        if (stressLevel <= 0)
            targetAlpha = 0f;
        else if (stressLevel > 0 && stressLevel <= 3)
            targetAlpha = 0.05f;
        else if (stressLevel > 3 && stressLevel <= 6)
            targetAlpha = 0.15f;
        else if (stressLevel > 6 && stressLevel <= 13)
            targetAlpha = 0.25f;
        else
            targetAlpha = 0.40f;
    }
}
