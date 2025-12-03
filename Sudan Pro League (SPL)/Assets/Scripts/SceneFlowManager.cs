using UnityEngine;
using TMPro;
using System.Collections;
using UnityEngine.SceneManagement;

public class SceneFlowManager : MonoBehaviour
{
    [Header("Scene Objects")]
    public GameObject splashScreen;
    public GameObject mainMenu;

    [Header("Audio")]
    public AudioSource mainThemeAudio; // Assign AudioSource with theme clip

    [Header("Loading Screen")]
    public Canvas loadingCanvas;             // Canvas for loading screen
    public TextMeshProUGUI loadingText;      // TMPRO text "Loading..."
    public float fadeDuration = 1f;          // Fade in/out duration

    private bool isLoading = false;

    private void Awake()
    {
        // Ensure default state at game start
        if (splashScreen != null) splashScreen.SetActive(true);
        if (mainMenu != null) mainMenu.SetActive(false);

        if (loadingCanvas != null) loadingCanvas.enabled = false;

        if (mainThemeAudio != null)
        {
            mainThemeAudio.Stop();
            mainThemeAudio.loop = true;
        }
    }

    /// <summary>
    /// Called by SplashScreenManager when splash sequence finishes.
    /// </summary>
    public void OnSplashFinished()
    {
        Debug.Log("Splash finished. Transitioning to main menu...");

        // Disable splash
        if (splashScreen != null)
            splashScreen.SetActive(false);

        // Enable main menu
        if (mainMenu != null)
            mainMenu.SetActive(true);

        // Play audio loop
        if (mainThemeAudio != null && !mainThemeAudio.isPlaying)
        {
            mainThemeAudio.Play();
        }
    }

    /// <summary>
    /// Public method to load a new scene with loading screen.
    /// </summary>
    public void LoadScene(string sceneName)
    {
        if (!isLoading)
            StartCoroutine(LoadSceneRoutine(sceneName));
    }

    private IEnumerator LoadSceneRoutine(string sceneName)
    {
        isLoading = true;

        // Show loading screen
        if (loadingCanvas != null) loadingCanvas.enabled = true;

        // Start looping animation
        if (loadingText != null)
            StartCoroutine(LoopFadeText(loadingText));

        // Begin async load
        AsyncOperation asyncLoad = SceneManager.LoadSceneAsync(sceneName);
        asyncLoad.allowSceneActivation = false;

        // Wait until load reaches 90% (Unity async threshold)
        while (asyncLoad.progress < 0.9f)
        {
            yield return null;
        }

        // Optional short wait for polish
        yield return new WaitForSeconds(1f);

        // Activate scene
        asyncLoad.allowSceneActivation = true;

        // Hide loading screen
        if (loadingCanvas != null) loadingCanvas.enabled = false;
        isLoading = false;
    }

    // ✅ Loop fade animation for TMPRO text
    private IEnumerator LoopFadeText(TextMeshProUGUI text)
    {
        while (isLoading)
        {
            yield return StartCoroutine(FadeTextAlpha(text, 0f, 1f, fadeDuration));
            yield return StartCoroutine(FadeTextAlpha(text, 1f, 0f, fadeDuration));
        }
    }

    private IEnumerator FadeTextAlpha(TextMeshProUGUI text, float from, float to, float duration)
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
