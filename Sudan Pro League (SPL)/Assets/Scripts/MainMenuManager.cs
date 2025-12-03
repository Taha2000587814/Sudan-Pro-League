using UnityEngine;
using UnityEngine.UI;
using TMPro;
using System.Collections;
using System.Collections.Generic;
#if ENABLE_INPUT_SYSTEM
using UnityEngine.InputSystem; // New Input System
#endif

public class MainMenuManager : MonoBehaviour
{
    [Header("Screens")]
    public GameObject startScreen;
    public GameObject mainMenuScreen;

    [Header("UI Elements")]
    public Image gameLogo;
    public Image figureImage;
    public TextMeshProUGUI pressAText;
    public List<Button> menuButtons;
    public Image previewImage;
    public TextMeshProUGUI versionText;

    [System.Serializable]
    public class ButtonPreviewPair
    {
        public Button button;
        public Sprite previewSprite;
    }

    [Header("Preview assignments")]
    public List<ButtonPreviewPair> buttonPreviewPairs;

    [Header("Animation settings")]
    public float fadeDuration = 1f;
    public float pressAFadeDuration = 1f;

    [Header("Audio settings")]
    public AudioSource themeAudio;
    public AudioSource sfxAudioSource;
    public AudioClip switchSFX;
    public AudioClip confirmSFX;

    [Header("Selection settings")]
    public Color normalButtonColor = Color.white;
    public Color normalFontColor = Color.black;
    public int startIndex = 0;

    [Header("Scrolling")]
    public ScrollRect scrollRect;
    public float scrollSmoothDuration = 0.25f; // smooth scroll speed

    private bool startScreenActive = true;
    private int currentIndex;
    private float inputCooldown = 0.25f;
    private float lastInputTime;

    void OnEnable()
    {
        // Default state
        if (startScreen != null) startScreen.SetActive(true);
        if (mainMenuScreen != null) mainMenuScreen.SetActive(false);

        // Reset alpha for fade-in (final position is whatever you set in scene)
        if (gameLogo != null) SetAlpha(gameLogo, 0f);
        if (figureImage != null) SetAlpha(figureImage, 0f);

        // Theme audio
        if (themeAudio != null)
        {
            themeAudio.Stop();
            themeAudio.loop = true;
            themeAudio.Play();
        }

        // Fade-in animations
        StartCoroutine(FadeInImage(gameLogo, fadeDuration));
        StartCoroutine(FadeInImage(figureImage, fadeDuration));
        StartCoroutine(LoopPressAText());

        // Version
        if (versionText != null)
            versionText.text = $"© 2025 Y2K Entertainment  Build v{Application.version}";

        // Menu setup
        currentIndex = Mathf.Clamp(startIndex, 0, menuButtons.Count - 1);
        UpdateButtonVisuals();
        UpdatePreviewImage();
        CenterOnSelected(true); // snap at start
    }

    void Update()
    {
        if (startScreenActive)
        {
            if (CheckConfirmInput())
                SwitchToMainMenu();
        }
        else
        {
            HandleNavigation();
            if (CheckConfirmInput())
                OnConfirm();
        }
    }

    void SwitchToMainMenu()
    {
        startScreenActive = false;
        if (startScreen != null) startScreen.SetActive(false);
        if (mainMenuScreen != null) mainMenuScreen.SetActive(true);
    }

    bool CheckConfirmInput()
    {
        // Old Input System
        if (Input.GetButtonDown("Submit")) return true;

        // Any key press can confirm on start screen only
        if (startScreenActive && Input.anyKeyDown) return true;

#if ENABLE_INPUT_SYSTEM
        // New Input System
        if (Gamepad.current != null && Gamepad.current.buttonSouth.wasPressedThisFrame) return true;
        if (Keyboard.current != null && Keyboard.current.enterKey.wasPressedThisFrame) return true;
#endif

        return false;
    }

    void HandleNavigation()
    {
        float input = 0f;

        // Old Input System axis
        input = Input.GetAxisRaw("Horizontal");

#if ENABLE_INPUT_SYSTEM
        // New Input System
        if (Gamepad.current != null)
            input = Gamepad.current.leftStick.x.ReadValue();

        if (Keyboard.current != null)
        {
            if (Keyboard.current.leftArrowKey.wasPressedThisFrame || Keyboard.current.aKey.wasPressedThisFrame)
                input = -1f;

            if (Keyboard.current.rightArrowKey.wasPressedThisFrame || Keyboard.current.dKey.wasPressedThisFrame)
                input = 1f;
        }

#endif

        if (Time.time - lastInputTime > inputCooldown)
        {
            if (input > 0.5f)
            {
                currentIndex = (currentIndex + 1) % menuButtons.Count;
                OnSwitch();
            }
            else if (input < -0.5f)
            {
                currentIndex = (currentIndex - 1 + menuButtons.Count) % menuButtons.Count;
                OnSwitch();
            }
        }
    }

    void OnSwitch()
    {
        lastInputTime = Time.time;

        UpdateButtonVisuals();
        UpdatePreviewImage();
        CenterOnSelected(false); // smooth

        if (sfxAudioSource != null && switchSFX != null)
            sfxAudioSource.PlayOneShot(switchSFX);
    }

    void OnConfirm()
    {
        if (sfxAudioSource != null && confirmSFX != null)
            sfxAudioSource.PlayOneShot(confirmSFX);

        if (menuButtons != null && menuButtons.Count > 0)
            menuButtons[currentIndex].onClick.Invoke();
    }

    // Reverse button + font colors automatically
    void UpdateButtonVisuals()
    {
        for (int i = 0; i < menuButtons.Count; i++)
        {
            var btnImage = menuButtons[i].GetComponent<Image>();
            var tmpText = menuButtons[i].GetComponentInChildren<TextMeshProUGUI>();

            if (btnImage == null || tmpText == null) continue;

            if (i == currentIndex)
            {
                // Swap colors (font becomes background and background becomes font)
                Color buttonColor = btnImage.color;
                Color fontColor = tmpText.color;

                btnImage.color = fontColor;
                tmpText.color = buttonColor;
            }
            else
            {
                // Restore defaults
                btnImage.color = normalButtonColor;
                tmpText.color = normalFontColor;
            }
        }
    }

    // Preview image aligned by explicit button mapping (not list order)
    void UpdatePreviewImage()
    {
        if (previewImage == null || buttonPreviewPairs == null) return;

        Button selectedButton = menuButtons[currentIndex];
        for (int i = 0; i < buttonPreviewPairs.Count; i++)
        {
            var pair = buttonPreviewPairs[i];
            if (pair != null && pair.button == selectedButton && pair.previewSprite != null)
            {
                previewImage.sprite = pair.previewSprite;
                return;
            }
        }
    }

    // Selector effect: center selected button in viewport (robust to layout/pivots)
    void CenterOnSelected(bool instant)
    {
        if (scrollRect == null || menuButtons == null || menuButtons.Count == 0) return;

        RectTransform content = scrollRect.content;
        RectTransform viewport = scrollRect.viewport != null
            ? scrollRect.viewport
            : scrollRect.GetComponent<RectTransform>();

        // Ensure layout is up-to-date before measuring
        Canvas.ForceUpdateCanvases();

        float contentWidth = content.rect.width;
        float viewportWidth = viewport.rect.width;
        float scrollRange = contentWidth - viewportWidth;
        if (scrollRange <= 0f) return; // Nothing to scroll

        RectTransform target = menuButtons[currentIndex].GetComponent<RectTransform>();

        // Center point of target in content local space
        Vector3 worldCenter = target.TransformPoint(target.rect.center);
        float localCenterX = content.InverseTransformPoint(worldCenter).x;

        // Desired content offset so target is centered in viewport
        float desiredContentX = localCenterX - (viewportWidth * 0.5f);
        float normalized = Mathf.Clamp01(desiredContentX / scrollRange);

        if (instant)
        {
            scrollRect.horizontalNormalizedPosition = normalized;
        }
        else
        {
            StopCoroutine(nameof(SmoothScrollTo));
            StartCoroutine(SmoothScrollTo(normalized, scrollSmoothDuration));
        }
    }

    IEnumerator SmoothScrollTo(float targetNormalized, float duration)
    {
        float start = scrollRect.horizontalNormalizedPosition;
        float time = 0f;

        while (time < duration)
        {
            scrollRect.horizontalNormalizedPosition = Mathf.Lerp(start, targetNormalized, time / duration);
            time += Time.deltaTime;
            yield return null;
        }

        scrollRect.horizontalNormalizedPosition = targetNormalized;
    }

    // Fade-in helpers (logo & figure)
    IEnumerator FadeInImage(Image img, float duration)
    {
        if (img == null) yield break;
        float time = 0f;
        Color c = img.color;
        while (time < duration)
        {
            c.a = Mathf.Lerp(0f, 1f, time / duration);
            img.color = c;
            time += Time.deltaTime;
            yield return null;
        }
        c.a = 1f;
        img.color = c;
    }

    IEnumerator LoopPressAText()
    {
        if (pressAText == null) yield break;
        while (startScreenActive)
        {
            yield return StartCoroutine(FadeTextAlpha(pressAText, 0f, 1f, pressAFadeDuration));
            yield return StartCoroutine(FadeTextAlpha(pressAText, 1f, 0f, pressAFadeDuration));
        }
    }

    IEnumerator FadeTextAlpha(TextMeshProUGUI text, float from, float to, float duration)
    {
        if (text == null) yield break;
        float time = 0f;
        Color c = text.color;
        while (time < duration)
        {
            c.a = Mathf.Lerp(from, to, time / duration);
            text.color = c;
            time += Time.deltaTime;
            yield return null;
        }
        c.a = to;
        text.color = c;
    }

    void SetAlpha(Image img, float alpha)
    {
        if (img == null) return;
        Color c = img.color;
        c.a = alpha;
        img.color = c;
    }
}
