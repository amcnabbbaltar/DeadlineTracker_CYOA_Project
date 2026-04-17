using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Networking;
using Ink.Runtime;

namespace DialogueSystem
{
    public class NarrativePlayer : MonoBehaviour
    {
        [Header("UI Components")]
        public TextMeshProUGUI passageText;
        public Button choiceButtonPrefab;
        public Transform choiceButtonContainer;
        public TextMeshProUGUI myChoiceCounterUI;
        public TextMeshProUGUI deadlineTimerUI;
        [SerializeField] public Image characterFull;

        [SerializeField] public Image character1;

        [SerializeField] public Image character2;
        [SerializeField] public Image storyBackground;
        public Animator storyImageAnimator;

        [Header("Ink Source")]
        [SerializeField] private UnityEngine.TextAsset inkJSONAsset = null;
        public Story story;
        private int myChoices = 0;

        public string imagesPath = "";
        public string animationsPath = "Animations";

        [Header("Typewriter Settings")]
        public float typeDelay = 0.02f;
        public bool typing = false;

        [Header("Auto Continue")]
        public bool autoContinue = false;
        public float autoContinueDelay = 0.5f;

        [Header("Character Transition")]
        public float charFadeDuration = 0.5f;
        private bool isDualMode = false;

        [Header("Audio")]
        [SerializeField] private AudioSource ambianceSource;
        [SerializeField] private AudioSource contextualSource;
        [SerializeField] private AudioSource typewriterSource;
        public AudioClip typewriterClip;
        public string soundsPath = "Sounds";
        public float ambianceFadeDuration = 1.5f;

        void Start()
        {
            if (inkJSONAsset == null)
            {
                Debug.LogError("No Ink JSON assigned!");
                return;
            }

            story = new Story(inkJSONAsset.text);
            story.ObserveVariable("time", (varName, newVal) => UpdateDeadlineTimer());
            UpdateDeadlineTimer();
            RefreshInkView();
        }

        void UpdateDeadlineTimer()
        {
            if (deadlineTimerUI == null) return;

            int current   = Convert.ToInt32(story.variablesState["time"]);
            int dlValue   = Convert.ToInt32(story.variablesState["deadline"]);
            int remaining = Mathf.Max(0, dlValue - current);

            // Current time in 12-hour format
            int rawHour  = current / 60;
            int hour12   = rawHour % 12;
            if (hour12 == 0) hour12 = 12;
            int curMins  = current % 60;
            string period = rawHour < 12 ? "AM" : "PM";

            // Remaining broken into hours + minutes
            int remHours = remaining / 60;
            int remMins  = remaining % 60;

            deadlineTimerUI.text = string.Format(
                "Time {0}:{1:D2} {2}  •  Remaining {3}h {4:D2}m",
                hour12, curMins, period, remHours, remMins);
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

                if (typewriterSource != null && typewriterClip != null && fullText[i] != ' ' && fullText[i] != '\n')
                    typewriterSource.PlayOneShot(typewriterClip);

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
                bool isSingleContinue = story.currentChoices.Count == 1
                    && story.currentChoices[0].text.Trim() == "Continue";

                if (autoContinue && isSingleContinue)
                {
                    StartCoroutine(AutoAdvance(0));
                    return;
                }

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
                if (autoContinue)
                {
                    StartCoroutine(AutoAdvance(-1));
                    return;
                }
                AddChoiceButton("Continue", () => RefreshInkView());
            }
        }

        IEnumerator AutoAdvance(int choiceIndex)
        {
            yield return new WaitForSeconds(autoContinueDelay);
            if (choiceIndex >= 0)
                story.ChooseChoiceIndex(choiceIndex);
            RefreshInkView();
        }

        // -------------------------------------------------
        // TAG HANDLING
        // -------------------------------------------------
        bool HandleTags(List<string> tags)
        {
            if (tags == null || tags.Count == 0)
                return false;

            string singleChar = null;
            string char1 = null;
            string char2 = null;

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
                    singleChar = tag.Substring("character:".Length).Trim();
                else if (tag.StartsWith("character_1:"))
                    char1 = tag.Substring("character_1:".Length).Trim();
                else if (tag.StartsWith("character_2:"))
                    char2 = tag.Substring("character_2:".Length).Trim();
                else if (tag.StartsWith("ambiance:"))
                {
                    string clipName = tag["ambiance:".Length..].Trim();
                    StartCoroutine(PlayAmbianceAsync(clipName));
                }
                else if (tag == "ambiance_stop")
                {
                    StartCoroutine(FadeOutAmbiance());
                }
                else if (tag.StartsWith("sound:"))
                {
                    string clipName = tag["sound:".Length..].Trim();
                    StartCoroutine(PlayContextualAsync(clipName));
                }
                else if (tag.StartsWith("anim:"))
                {
                    if (storyImageAnimator) storyImageAnimator.enabled = true;
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

            if (singleChar != null)
                ApplySingleCharacter(singleChar);
            else if (char1 != null || char2 != null)
                ApplyDualCharacter(char1, char2);

            return false;
        }

        // -------------------------------------------------
        // CHARACTER TRANSITIONS
        // -------------------------------------------------
        void ApplySingleCharacter(string imageName)
        {
            if (storyImageAnimator) storyImageAnimator.enabled = false;
            StartCoroutine(ApplySingleCharacterAsync(imageName));
        }

        IEnumerator ApplySingleCharacterAsync(string imageName)
        {
            Sprite sprite = null;
            yield return StartCoroutine(LoadSpriteAsync(imageName, s => sprite = s));
            if (sprite == null) yield break;

            if (isDualMode)
                yield return StartCoroutine(TransitionToSingle(sprite));
            else if (characterFull.gameObject.activeSelf)
                yield return StartCoroutine(FadeImageTransition(sprite, characterFull, charFadeDuration));
            else
                yield return StartCoroutine(FadeInFromDisabled(characterFull, sprite));

            isDualMode = false;
        }

        IEnumerator FadeInFromDisabled(Image target, Sprite sprite)
        {
            target.sprite = sprite;
            target.preserveAspect = true;
            var col = target.color;
            col.a = 0f;
            target.color = col;
            target.gameObject.SetActive(true);

            float elapsed = 0f;
            while (elapsed < charFadeDuration)
            {
                elapsed += Time.deltaTime;
                col.a = Mathf.Lerp(0f, 1f, elapsed / charFadeDuration);
                target.color = col;
                yield return null;
            }
            col.a = 1f;
            target.color = col;
        }

        void ApplyDualCharacter(string char1Name, string char2Name)
        {
            if (storyImageAnimator) storyImageAnimator.enabled = false;
            StartCoroutine(ApplyDualCharacterAsync(char1Name, char2Name));
        }

        IEnumerator ApplyDualCharacterAsync(string char1Name, string char2Name)
        {
            Sprite sprite1 = null, sprite2 = null;
            if (char1Name != null) yield return StartCoroutine(LoadSpriteAsync(char1Name, s => sprite1 = s));
            if (char2Name != null) yield return StartCoroutine(LoadSpriteAsync(char2Name, s => sprite2 = s));

            if (!isDualMode)
                yield return StartCoroutine(TransitionToDual(sprite1, sprite2));
            else
            {
                if (sprite1 != null) StartCoroutine(FadeImageTransition(sprite1, character1, charFadeDuration));
                if (sprite2 != null) StartCoroutine(FadeImageTransition(sprite2, character2, charFadeDuration));
            }

            isDualMode = true;
        }

        string ImageUrl(string imageName)
        {
            string rel = string.IsNullOrEmpty(imagesPath) ? imageName : imagesPath + "/" + imageName;
            return Application.streamingAssetsPath + "/" + rel + ".png";
        }

        IEnumerator LoadSpriteAsync(string imageName, Action<Sprite> onLoaded)
        {
            string url = ImageUrl(imageName);
            using var req = UnityWebRequestTexture.GetTexture(url);
            yield return req.SendWebRequest();
            if (req.result != UnityWebRequest.Result.Success)
            {
                Debug.LogWarning("[NarrativePlayer] Could not load image: " + url);
                onLoaded?.Invoke(null);
            }
            else
            {
                Texture2D tex = DownloadHandlerTexture.GetContent(req);
                Sprite sprite = Sprite.Create(tex, new Rect(0, 0, tex.width, tex.height), new Vector2(0.5f, 0.5f));
                onLoaded?.Invoke(sprite);
            }
        }

        IEnumerator TransitionToSingle(Sprite newSprite)
        {
            // Fade out character1 and character2 simultaneously
            float elapsed = 0f;
            bool c1Active = character1 != null && character1.gameObject.activeSelf;
            bool c2Active = character2 != null && character2.gameObject.activeSelf;

            while (elapsed < charFadeDuration)
            {
                elapsed += Time.deltaTime;
                float a = Mathf.Lerp(1f, 0f, elapsed / charFadeDuration);
                if (c1Active) { var col = character1.color; col.a = a; character1.color = col; }
                if (c2Active) { var col = character2.color; col.a = a; character2.color = col; }
                yield return null;
            }

            if (character1 != null) character1.gameObject.SetActive(false);
            if (character2 != null) character2.gameObject.SetActive(false);

            // Fade in characterFull
            characterFull.sprite = newSprite;
            characterFull.preserveAspect = true;
            var cfColor = characterFull.color;
            cfColor.a = 0f;
            characterFull.color = cfColor;
            characterFull.gameObject.SetActive(true);

            elapsed = 0f;
            while (elapsed < charFadeDuration)
            {
                elapsed += Time.deltaTime;
                cfColor.a = Mathf.Lerp(0f, 1f, elapsed / charFadeDuration);
                characterFull.color = cfColor;
                yield return null;
            }
            cfColor.a = 1f;
            characterFull.color = cfColor;
        }

        IEnumerator TransitionToDual(Sprite sprite1, Sprite sprite2)
        {
            // Fade out characterFull
            float elapsed = 0f;
            bool cfActive = characterFull != null && characterFull.gameObject.activeSelf;

            while (elapsed < charFadeDuration)
            {
                elapsed += Time.deltaTime;
                if (cfActive)
                {
                    var col = characterFull.color;
                    col.a = Mathf.Lerp(1f, 0f, elapsed / charFadeDuration);
                    characterFull.color = col;
                }
                yield return null;
            }
            if (characterFull != null) characterFull.gameObject.SetActive(false);

            // Set up character1 and character2 at alpha 0
            if (sprite1 != null && character1 != null)
            {
                character1.sprite = sprite1;
                character1.preserveAspect = true;
                var col = character1.color; col.a = 0f; character1.color = col;
                character1.gameObject.SetActive(true);
            }
            if (sprite2 != null && character2 != null)
            {
                character2.sprite = sprite2;
                character2.preserveAspect = true;
                var col = character2.color; col.a = 0f; character2.color = col;
                character2.gameObject.SetActive(true);
            }

            // Fade in both simultaneously
            elapsed = 0f;
            while (elapsed < charFadeDuration)
            {
                elapsed += Time.deltaTime;
                float a = Mathf.Lerp(0f, 1f, elapsed / charFadeDuration);
                if (sprite1 != null && character1 != null) { var col = character1.color; col.a = a; character1.color = col; }
                if (sprite2 != null && character2 != null) { var col = character2.color; col.a = a; character2.color = col; }
                yield return null;
            }
            if (sprite1 != null && character1 != null) { var col = character1.color; col.a = 1f; character1.color = col; }
            if (sprite2 != null && character2 != null) { var col = character2.color; col.a = 1f; character2.color = col; }
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
            StartCoroutine(LoadAndFadeCoroutine(imageName, targetImage));
        }

        IEnumerator LoadAndFadeCoroutine(string imageName, Image targetImage)
        {
            Sprite sprite = null;
            yield return StartCoroutine(LoadSpriteAsync(imageName, s => sprite = s));
            if (sprite != null)
                yield return StartCoroutine(FadeImageTransition(sprite, targetImage));
        }

        void LoadAndDisplayImageInstant(string imageName, Image targetImage)
        {
            if (targetImage == null) return;
            StartCoroutine(LoadAndInstantCoroutine(imageName, targetImage));
        }

        IEnumerator LoadAndInstantCoroutine(string imageName, Image targetImage)
        {
            yield return StartCoroutine(LoadSpriteAsync(imageName, s =>
            {
                if (s != null)
                {
                    targetImage.sprite = s;
                    targetImage.preserveAspect = true;
                }
            }));
        }

        // -------------------------------------------------
        // AUDIO
        // -------------------------------------------------
        string AudioUrl(string clipName)
        {
            string rel = string.IsNullOrEmpty(soundsPath) ? clipName : soundsPath + "/" + clipName;
            return Application.streamingAssetsPath + "/" + rel;
        }

        static AudioType ExtToAudioType(string ext)
        {
            return ext.ToLower() switch
            {
                ".ogg"  => AudioType.OGGVORBIS,
                ".mp3"  => AudioType.MPEG,
                ".wav"  => AudioType.WAV,
                ".aiff" => AudioType.AIFF,
                ".aif"  => AudioType.AIFF,
                _       => AudioType.UNKNOWN
            };
        }

        IEnumerator LoadAudioAsync(string clipName, Action<AudioClip> onLoaded)
        {
            // If the clip name already contains an extension, use it directly.
            string knownExt = System.IO.Path.GetExtension(clipName);
            if (!string.IsNullOrEmpty(knownExt))
            {
                AudioType audioType = ExtToAudioType(knownExt);
                string url = AudioUrl(clipName);
                using var req = UnityWebRequestMultimedia.GetAudioClip(url, audioType);
                yield return req.SendWebRequest();
                if (req.result == UnityWebRequest.Result.Success)
                    onLoaded?.Invoke(DownloadHandlerAudioClip.GetContent(req));
                else
                {
                    Debug.LogWarning("[NarrativePlayer] Could not load audio: " + url);
                    onLoaded?.Invoke(null);
                }
                yield break;
            }

            // No extension provided — try .ogg, .wav, .mp3
            string[] exts     = { ".ogg", ".wav", ".mp3" };
            AudioType[] types = { AudioType.OGGVORBIS, AudioType.WAV, AudioType.MPEG };

            for (int i = 0; i < exts.Length; i++)
            {
                string url = AudioUrl(clipName) + exts[i];
                using var req = UnityWebRequestMultimedia.GetAudioClip(url, types[i]);
                yield return req.SendWebRequest();
                if (req.result == UnityWebRequest.Result.Success)
                {
                    onLoaded?.Invoke(DownloadHandlerAudioClip.GetContent(req));
                    yield break;
                }
            }

            Debug.LogWarning("[NarrativePlayer] Could not load audio: " + clipName);
            onLoaded?.Invoke(null);
        }

        IEnumerator PlayAmbianceAsync(string clipName)
        {
            if (ambianceSource == null) yield break;

            AudioClip clip = null;
            yield return StartCoroutine(LoadAudioAsync(clipName, c => clip = c));
            if (clip == null) yield break;

            // Fade out whatever is playing, then fade in the new clip
            if (ambianceSource.isPlaying)
            {
                float elapsed = 0f;
                float startVol = ambianceSource.volume;
                while (elapsed < ambianceFadeDuration)
                {
                    elapsed += Time.deltaTime;
                    ambianceSource.volume = Mathf.Lerp(startVol, 0f, elapsed / ambianceFadeDuration);
                    yield return null;
                }
                ambianceSource.Stop();
            }

            ambianceSource.clip = clip;
            ambianceSource.loop = true;
            ambianceSource.volume = 0f;
            ambianceSource.Play();

            float fadeIn = 0f;
            while (fadeIn < ambianceFadeDuration)
            {
                fadeIn += Time.deltaTime;
                ambianceSource.volume = Mathf.Lerp(0f, 1f, fadeIn / ambianceFadeDuration);
                yield return null;
            }
            ambianceSource.volume = 1f;
        }

        IEnumerator FadeOutAmbiance()
        {
            if (ambianceSource == null || !ambianceSource.isPlaying) yield break;

            float startVol = ambianceSource.volume;
            float elapsed = 0f;
            while (elapsed < ambianceFadeDuration)
            {
                elapsed += Time.deltaTime;
                ambianceSource.volume = Mathf.Lerp(startVol, 0f, elapsed / ambianceFadeDuration);
                yield return null;
            }
            ambianceSource.Stop();
            ambianceSource.volume = 1f;
        }

        IEnumerator PlayContextualAsync(string clipName)
        {
            if (contextualSource == null) yield break;

            AudioClip clip = null;
            yield return StartCoroutine(LoadAudioAsync(clipName, c => clip = c));
            if (clip != null)
                contextualSource.PlayOneShot(clip);
        }
    }
}
