using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class SplashScreenManager : MonoBehaviour
{
    [Header("UI Elements")]
    public CanvasGroup logoGroup;
    public CanvasGroup infoGroup;

    [Header("Timing")]
    public float fadeInDuration = 1f;
    public float splashDuration = 3f;
    public float fadeOutDuration = 1f;

    [Header("Scene Flow")]
    public SceneFlowManager sceneFlowManager;

    void Start()
    {
        StartCoroutine(HandleSplashSequence());
    }

    IEnumerator HandleSplashSequence()
    {
        // Fade in logos
        yield return StartCoroutine(FadeCanvasGroup(logoGroup, fadeInDuration, 1f));

        // Fade in info
        yield return StartCoroutine(FadeCanvasGroup(infoGroup, fadeInDuration, 1f));

        // Wait before fading out
        yield return new WaitForSeconds(splashDuration);

        // Fade out logos
        yield return StartCoroutine(FadeCanvasGroup(logoGroup, fadeOutDuration, 0f));

        // Fade out info
        yield return StartCoroutine(FadeCanvasGroup(infoGroup, fadeOutDuration, 0f));

        // Notify SceneFlowManager
        if (sceneFlowManager != null)
        {
            sceneFlowManager.OnSplashFinished();
        }
    }

    IEnumerator FadeCanvasGroup(CanvasGroup group, float duration, float targetAlpha)
    {
        float startAlpha = group.alpha;
        float time = 0f;

        while (time < duration)
        {
            group.alpha = Mathf.Lerp(startAlpha, targetAlpha, time / duration);
            time += Time.deltaTime;
            yield return null;
        }

        group.alpha = targetAlpha;
        group.interactable = targetAlpha > 0f;
        group.blocksRaycasts = targetAlpha > 0f;
    }
}
