// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;

namespace TheVegetationEngine
{
    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.q99xysoa6kra")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Custom Render Data")]
    public class TVECustomRenderData : StyledMonoBehaviour
    {
        [StyledBanner(0.890f, 0.745f, 0.309f, "Custom Render Data")]
        public bool styledBanner;

        public TVERenderData renderData = new TVERenderData();

        [StyledSpace(5)]
        public bool styledSpace;

        void OnEnable()
        {
            AddRenderDataToVolume();
        }

        void OnDisable()
        {
            RemoveRenderDataFromVolume();
        }

        void OnDestroy()
        {
            RemoveRenderDataFromVolume();
        }

        void AddRenderDataToVolume()
        {
            if (TVEManager.Instance == null)
            {
                return;
            }

            var renderDataSet = TVEManager.Instance.globalVolume.renderDataSet;

            if (!renderDataSet.Contains(renderData))
            {
                renderData.renderDataID = renderData.materialTag.GetHashCode();

                TVEManager.Instance.globalVolume.renderDataSet.Add(renderData);
                TVEManager.Instance.globalVolume.CreateRenderBuffer(renderData);
            }
        }

        void RemoveRenderDataFromVolume()
        {
            if (TVEManager.Instance == null)
            {
                return;
            }

            var renderDataSet = TVEManager.Instance.globalVolume.renderDataSet;

            for (int i = 0; i < renderDataSet.Count; i++)
            {
                if (renderDataSet[i] == renderData)
                {
                    renderDataSet.RemoveAt(i);
                }
            }
        }

        void Update()
        {
            if (QualitySettings.activeColorSpace == ColorSpace.Linear && renderData.useActiveColorSpace)
            {
                Shader.SetGlobalColor(renderData.texParams, renderData.texColor.linear);
            }
            else
            {
                Shader.SetGlobalColor(renderData.texParams, renderData.texColor);
            }
        }

#if UNITY_EDITOR
        void OnValidate()
        {
            if (TVEManager.Instance == null)
            {
                return;
            }

            renderData.renderDataID = renderData.materialTag.GetHashCode();

            TVEManager.Instance.globalVolume.CreateRenderBuffer(renderData);
        }
#endif
    }
}
