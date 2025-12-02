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
    public GameObject startScreen;       // Contains logo + figure + Press A text
    public GameObject mainMenuScreen;    // Contains menu buttons

    [Header("UI Elements")]
    public Image gameLogo;               // Logo image
    public Image figureImage;            // Figure image
    public TextMeshProUGUI pressAText;   // "Press A" text
    public List<Button> menuButtons;     // Buttons in main menu
    public Image previewImage;           // Preview card image
    public List<Sprite> previewSprites;  // Sprites for each mode preview
    public TextMeshProUGUI versionText;  // Version display text

    [Header("Animation Settings")]
    public float logoSlideDuration = 1f;
    public Vector3 logoStartPos;         // Starting position for logo
    private Vector3 logoEndPos;          // Final position from scene
    public float figureSlideDuration = 1f;
    public Vector3 figureStartPos;       // Starting position for figure
    private Vector3 figureEndPos;        // Final position from scene
    public float pressAFadeDuration = 1f;

    [Header("Audio Settings")]
    public AudioSource themeAudio;       // Background theme music
    public AudioSource sfxAudioSource;   // Separate AudioSource for SFX
    public AudioClip switchSFX;
    public AudioClip confirmSFX;

    [Header("Selection Settings")]
    public Color highlightColor = Color.yellow;
    public Color normalColor = Color.clear;
    public int startIndex = 0;

    [Header("Scrolling")]
    public ScrollRect scrollRect;        // Assign your horizontal ScrollRect

    private bool startScreenActive = true;
    private int currentIndex;
    private float inputCooldown = 0.25f;
    private float lastInputTime;

    void OnEnable()
    {
        // Default state
        startScreen.SetActive(true);
        mainMenuScreen.SetActive(false);

        // Capture final positions directly from the scene
        if (gameLogo != null) logoEndPos = gameLogo.rectTransform.localPosition;
        if (figureImage != null) figureEndPos = figureImage.rectTransform.localPosition;

        // Reset to start positions (off‑screen or defined in Inspector)
        if (gameLogo != null) gameLogo.rectTransform.localPosition = logoStartPos;
        if (figureImage != null) figureImage.rectTransform.localPosition = figureStartPos;

        // Play theme audio
        if (themeAudio != null)
        {
            themeAudio.loop = true;
            themeAudio.Play();
        }

        // Animate into the scene positions
        StartCoroutine(SlideIn(gameLogo.rectTransform, logoStartPos, logoEndPos, logoSlideDuration));
        StartCoroutine(SlideIn(figureImage.rectTransform, figureStartPos, figureEndPos, figureSlideDuration));
        StartCoroutine(LoopPressAText());

        // Version display
        if (versionText != null)
        {
            versionText.text = $"© 2025 Y2K Entertainment  Build v{Application.version}";
        }

        // Menu setup
        currentIndex = Mathf.Clamp(startIndex, 0, menuButtons.Count - 1);
        UpdateButtonVisuals();
        UpdatePreviewImage();
        CenterOnSelected();
    }


    void Update()
    {
        if (startScreenActive)
        {
            if (CheckConfirmInput())
            {
                SwitchToMainMenu();
            }
        }
        else
        {
            HandleNavigation();
            if (CheckConfirmInput())
            {
                OnConfirm();
            }
        }
    }

    // ✅ Switch from start screen to main menu
    void SwitchToMainMenu()
    {
        startScreenActive = false;
        startScreen.SetActive(false);
        mainMenuScreen.SetActive(true);
    }

    // ✅ Unified confirm input
    bool CheckConfirmInput()
    {
        // Old Input System
        if (Input.anyKeyDown || Input.GetButtonDown("Submit"))
            return true;

#if ENABLE_INPUT_SYSTEM
        // New Input System
        if (Gamepad.current != null && Gamepad.current.buttonSouth.wasPressedThisFrame) // A button
            return true;

        if (Keyboard.current != null && Keyboard.current.enterKey.wasPressedThisFrame)
            return true;
#endif

        return false;
    }

    // ✅ Unified navigation input
    void HandleNavigation()
    {
        float input = 0f;

        // Old Input System
        input = Input.GetAxisRaw("Horizontal");

#if ENABLE_INPUT_SYSTEM
        // New Input System
        if (Gamepad.current != null)
            input = Gamepad.current.leftStick.x.ReadValue();

        if (Keyboard.current != null)
        {
            if (Keyboard.current.aKey.wasPressedThisFrame) input = -1f;
            if (Keyboard.current.dKey.wasPressedThisFrame) input = 1f;
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
        CenterOnSelected();

        if (sfxAudioSource != null && switchSFX != null)
            sfxAudioSource.PlayOneShot(switchSFX);
    }

    void OnConfirm()
    {
        if (sfxAudioSource != null && confirmSFX != null)
            sfxAudioSource.PlayOneShot(confirmSFX);

        menuButtons[currentIndex].onClick.Invoke();
    }

    // ✅ Highlight system using Underline + Frame children
    void UpdateButtonVisuals()
    {
        for (int i = 0; i < menuButtons.Count; i++)
        {
            Transform underline = menuButtons[i].transform.Find("Underline");
            if (underline != null)
                underline.gameObject.SetActive(i == currentIndex);

            Transform frame = menuButtons[i].transform.Find("HighlightFrame");
            if (frame != null)
                frame.gameObject.SetActive(i == currentIndex);
        }
    }

    void UpdatePreviewImage()
    {
        if (previewImage != null && previewSprites.Count > currentIndex)
        {
            previewImage.sprite = previewSprites[currentIndex];
        }
    }

    // ✅ Scroll centering
    void CenterOnSelected()
    {
        if (scrollRect != null && menuButtons.Count > 0)
        {
            RectTransform target = menuButtons[currentIndex].GetComponent<RectTransform>();

            float contentWidth = scrollRect.content.rect.width - scrollRect.viewport.rect.width;
            if (contentWidth <= 0) return; // No scrolling needed

            float targetPosX = Mathf.Clamp01((target.localPosition.x * -1) / contentWidth);
            scrollRect.horizontalNormalizedPosition = targetPosX;
        }
    }

    // ✅ Animations
    IEnumerator SlideIn(RectTransform target, Vector3 from, Vector3 to, float duration)
    {
        float time = 0f;
        while (time < duration)
        {
            target.localPosition = Vector3.Lerp(from, to, time / duration);
            time += Time.deltaTime;
            yield return null;
        }
        target.localPosition = to;
    }

    IEnumerator LoopPressAText()
    {
        while (startScreenActive)
        {
            yield return StartCoroutine(FadeTextAlpha(pressAText, 0f, 1f, pressAFadeDuration));
            yield return StartCoroutine(FadeTextAlpha(pressAText, 1f, 0f, pressAFadeDuration));
        }
    }

    IEnumerator FadeTextAlpha(TextMeshProUGUI text, float from, float to, float duration)
    {
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
}
