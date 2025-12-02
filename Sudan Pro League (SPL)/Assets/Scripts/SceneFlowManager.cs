using UnityEngine;

public class SceneFlowManager : MonoBehaviour
{
    [Header("Scene Objects")]
    public GameObject splashScreen;
    public GameObject mainMenu;

    [Header("Audio")]
    public AudioSource mainThemeAudio; // Assign AudioSource with theme clip

    private void Awake()
    {
        // Ensure default state at game start
        if (splashScreen != null) splashScreen.SetActive(true);
        if (mainMenu != null) mainMenu.SetActive(false);

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
}
