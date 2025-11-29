// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;
using UnityEngine.Rendering;
using System.Collections.Generic;
using UnityEngine.Serialization;
using System.Collections;
using System.Linq;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TheVegetationEngine
{
    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.a39m1w5ouu94")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Global Volume")]
    public class TVEGlobalVolume : StyledMonoBehaviour
    {
        public enum ElementsVisibility
        {
            AlwaysHidden = 0,
            AlwaysVisible = 10,
            HiddenAtRuntime = 20,
        }

        public enum ElementsSorting
        {
            SortInEditMode = 0,
            SortAtRuntime = 10,
        }

        public enum RenderDataMode
        {
            Off = -1,
            FollowMainCamera256 = 8,
            FollowMainCamera512 = 9,
            FollowMainCamera1024 = 10,
            FollowMainCamera2048 = 11,
            FollowMainCamera4096 = 12,
            InsideGlobalVolume256 = 256,
            InsideGlobalVolume512 = 512,
            InsideGlobalVolume1024 = 1024,
            InsideGlobalVolume2048 = 2048,
            InsideGlobalVolume4096 = 4096,
        }

        [StyledBanner(0.890f, 0.745f, 0.309f, "Global Volume")]
        public bool styledBanner;

        [StyledCategory("Camera Settings", 5, 10)]
        public bool cameraCat;

        [StyledMessage("Error", "Main Camera not found! Make sure you have a main camera with Main Camera tag in your scene! Particle elements updating will be skipped without it. Enter play mode to update the status!", 0, 10)]
        public bool styledCameraMessaage = false;

        [Tooltip("Sets the main camera used for scene rendering.")]
        public Camera mainCamera;

        [StyledCategory("Elements Settings")]
        public bool elementsCat;

#if UNITY_EDITOR
        [StyledMessage("Info", "Realtime Sorting is not supported for elements with GPU Instanceing enabled!", 0, 10)]
        public bool styledSortingMessaage = true;
#endif

        [Tooltip("Controls the elements visibility in scene and game view.")]
        public ElementsVisibility elementsVisibility = ElementsVisibility.HiddenAtRuntime;
        [HideInInspector]
        public ElementsVisibility elementsVisibilityOld = ElementsVisibility.HiddenAtRuntime;
        [Tooltip("Controls the elements sorting by element position. Always on in edit mode.")]
        public ElementsSorting elementsSorting = ElementsSorting.SortInEditMode;
        [Tooltip("Controls the elements fading at the volume edges if the Enable Volume Edge Fading support is toggled on the element material.")]
        [Range(0.0f, 1.0f)]
        public float elementsEdgeFade = 0.75f;

        [StyledCategory("Render Settings")]
        public bool dataCat;

        [Tooltip("Render mode used for Colors elements rendering.")]
        [FormerlySerializedAs("renderColorsData")]
        public RenderDataMode renderColors = RenderDataMode.InsideGlobalVolume1024;

        [Tooltip("Render mode used for Extras elements rendering.")]
        [FormerlySerializedAs("renderExtrasData")]
        public RenderDataMode renderExtras = RenderDataMode.InsideGlobalVolume1024;

        [Tooltip("Render mode used for Motion elements rendering.")]
        [FormerlySerializedAs("renderMotionData")]
        public RenderDataMode renderMotion = RenderDataMode.InsideGlobalVolume1024;

        [Tooltip("Render mode used for Size elements rendering.")]
        [FormerlySerializedAs("renderReactData")]
        public RenderDataMode renderVertex = RenderDataMode.InsideGlobalVolume1024;

        [Tooltip("Uses high precision render textures for Colors elements HDR support and for high quality Motion Interaction. Enter playmode to see the changes!")]
        [Space(10)]
        public bool useHighPrecisionRendering = true;

        [StyledInteractive()]
        public bool useFollowMainCamera = false;

        [Space(10)]
        [Tooltip("The volume scale used for follow main camera render data mode.")]
        public Vector3 followMainCameraVolume = new Vector3(100, 100, 100);
        [Tooltip("Pushes the follow main camera volume in the camera forward direction to avoid rendering elements behind the camera.")]
        [Range(0.0f, 1.0f)]
        public float followMainCameraOffset = 1;

        [StyledInteractive()]
        public bool usesFollowActive = true;

        [System.NonSerialized]
        public List<TVERenderData> renderDataSet;

        [System.NonSerialized]
        public List<TVEElementData> renderElements;

        [System.NonSerialized]
        public List<TVEInstancedData> renderInstanced;

        [StyledSpace(10)]
        public bool styledSpace0;

        [System.NonSerialized]
        public TVERenderData colorsData = new TVERenderData();
        [System.NonSerialized]
        public TVERenderData extrasData = new TVERenderData();
        [System.NonSerialized]
        public TVERenderData motionData = new TVERenderData();
        [System.NonSerialized]
        public TVERenderData vertexData = new TVERenderData();

        MaterialPropertyBlock propertyBlock;

        Matrix4x4 projectionMatrix;
        Matrix4x4 modelViewMatrix = new Matrix4x4
        (
            new Vector4(1f, 0f, 0f, 0f),
            new Vector4(0f, 0f, -1f, 0f),
            new Vector4(0f, -1f, 0f, 0f),
            new Vector4(0f, 0f, 0f, 1f)
        );

        void Start()
        {
            gameObject.name = "Global Volume";
            gameObject.transform.SetSiblingIndex(3);

            CreateRenderBuffers();

            SortElementObjects();
            SetElementsVisibility();
        }

        void Update()
        {
            if (mainCamera == null)
            {
                mainCamera = Camera.main;
            }

            if (propertyBlock == null)
            {
                propertyBlock = new MaterialPropertyBlock();
            }

            if (elementsSorting == ElementsSorting.SortAtRuntime)
            {
                SortElementObjects();
            }

            if (elementsVisibilityOld != elementsVisibility)
            {
                SetElementsVisibility();

                elementsVisibilityOld = elementsVisibility;
            }

            UpdateRenderBuffers();
            ExecuteRenderBuffers();

            SetGlobalShaderParameters();

#if UNITY_EDITOR
            if (elementsSorting == ElementsSorting.SortAtRuntime)
            {
                styledSortingMessaage = true;
            }
            else
            {
                styledSortingMessaage = false;
            }

            if (mainCamera == null)
            {
                styledCameraMessaage = true;
            }
            else
            {
                styledCameraMessaage = false;
            }

            useFollowMainCamera = false;

            for (int i = 0; i < renderDataSet.Count; i++)
            {
                var renderData = renderDataSet[i];

                if (renderData == null)
                {
                    continue;
                }

                if (renderData.isFollowing)
                {
                    useFollowMainCamera = true;
                }
            }
#endif
        }

        public void InitVolumeRendering()
        {
            renderDataSet = new List<TVERenderData>();
            renderElements = new List<TVEElementData>();
            renderInstanced = new List<TVEInstancedData>();

            colorsData = new TVERenderData();
            colorsData.isEnabled = true;
            colorsData.texName = "TVE_ColorsTex";
            colorsData.texParams = "TVE_ColorsParams";
            colorsData.texCoord = "TVE_ColorsCoords";
            colorsData.texLayers = "TVE_ColorsLayers";
            colorsData.texUsage = "TVE_ColorsUsage";

            colorsData.materialTag = "ColorsElement";
            colorsData.materialPass = 0;

            colorsData.renderDataID = colorsData.materialTag.GetHashCode();
            colorsData.texWidth = 1024;
            colorsData.texHeight = 1024;
            colorsData.bufferSize = -1;
            colorsData.useRenderTextureArray = true;

            if (useHighPrecisionRendering)
            {
                colorsData.texFormat = RenderTextureFormat.ARGBHalf;
            }
            else
            {
                colorsData.texFormat = RenderTextureFormat.Default;
            }

            extrasData = new TVERenderData();
            extrasData.isEnabled = true;

            extrasData.texName = "TVE_ExtrasTex";
            extrasData.texParams = "TVE_ExtrasParams";
            extrasData.texCoord = "TVE_ExtrasCoords";
            extrasData.texLayers = "TVE_ExtrasLayers";
            extrasData.texUsage = "TVE_ExtrasUsage";

            extrasData.materialTag = "ExtrasElement";
            extrasData.materialPass = 0;

            extrasData.renderDataID = extrasData.materialTag.GetHashCode();
            extrasData.texWidth = 1024;
            extrasData.texHeight = 1024;
            extrasData.bufferSize = -1;
            extrasData.useRenderTextureArray = true;
            extrasData.texFormat = RenderTextureFormat.Default;

            motionData = new TVERenderData();
            motionData.isEnabled = true;

            motionData.texName = "TVE_MotionTex";
            motionData.texParams = "TVE_MotionParams";
            motionData.texCoord = "TVE_MotionCoords";
            motionData.texLayers = "TVE_MotionLayers";
            motionData.texUsage = "TVE_MotionUsage";

            motionData.materialTag = "MotionElement";
            motionData.materialPass = 0;

            motionData.renderDataID = motionData.materialTag.GetHashCode();
            motionData.texWidth = 1024;
            motionData.texHeight = 1024;
            motionData.bufferSize = -1;
            motionData.useRenderTextureArray = true;

            if (useHighPrecisionRendering)
            {
                motionData.texFormat = RenderTextureFormat.ARGBHalf;
            }
            else
            {
                motionData.texFormat = RenderTextureFormat.Default;
            }

            vertexData = new TVERenderData();
            vertexData.isEnabled = true;
            vertexData.texName = "TVE_VertexTex";
            vertexData.texParams = "TVE_VertexParams";
            vertexData.texCoord = "TVE_VertexCoords";
            vertexData.texLayers = "TVE_VertexLayers";
            vertexData.texUsage = "TVE_VertexUsage";

            vertexData.materialTag = "VertexElement";
            vertexData.materialPass = 0;

            vertexData.renderDataID = vertexData.materialTag.GetHashCode();
            vertexData.texWidth = 1024;
            vertexData.texHeight = 1024;
            vertexData.bufferSize = -1;
            vertexData.useRenderTextureArray = true;
            vertexData.texFormat = RenderTextureFormat.ARGBHalf;

            UpdateRenderData(colorsData, renderColors);
            UpdateRenderData(extrasData, renderExtras);
            UpdateRenderData(motionData, renderMotion);
            UpdateRenderData(vertexData, renderVertex);

            renderDataSet.Add(colorsData);
            renderDataSet.Add(extrasData);
            renderDataSet.Add(motionData);
            renderDataSet.Add(vertexData);
        }

        void UpdateRenderData(TVERenderData renderData, RenderDataMode renderDataMode)
        {
            if (renderDataMode == RenderDataMode.Off)
            {
                renderData.isEnabled = false;
                renderData.texWidth = 32;
                renderData.texHeight = 32;
                renderData.bufferSize = -1;
                renderData.isFollowing = false;
            }
            else if (renderDataMode == RenderDataMode.FollowMainCamera256)
            {
                renderData.isEnabled = true;
                renderData.texWidth = 256;
                renderData.texHeight = 256;
                renderData.isFollowing = true;
            }
            else if (renderDataMode == RenderDataMode.FollowMainCamera512)
            {
                renderData.isEnabled = true;
                renderData.texWidth = 512;
                renderData.texHeight = 512;
                renderData.isFollowing = true;
            }
            else if (renderDataMode == RenderDataMode.FollowMainCamera1024)
            {
                renderData.isEnabled = true;
                renderData.texWidth = 1024;
                renderData.texHeight = 1024;
                renderData.isFollowing = true;
            }
            else if (renderDataMode == RenderDataMode.FollowMainCamera2048)
            {
                renderData.isEnabled = true;
                renderData.texWidth = 2048;
                renderData.texHeight = 2048;
                renderData.isFollowing = true;
            }
            else if (renderDataMode == RenderDataMode.FollowMainCamera4096)
            {
                renderData.isEnabled = true;
                renderData.texWidth = 4096;
                renderData.texHeight = 4096;
                renderData.isFollowing = true;
            }
            else if (renderDataMode == RenderDataMode.InsideGlobalVolume256)
            {
                renderData.isEnabled = true;
                renderData.texWidth = 256;
                renderData.texHeight = 256;
                renderData.isFollowing = false;
            }
            else if (renderDataMode == RenderDataMode.InsideGlobalVolume512)
            {
                renderData.isEnabled = true;
                renderData.texWidth = 512;
                renderData.texHeight = 512;
                renderData.isFollowing = false;
            }
            else if (renderDataMode == RenderDataMode.InsideGlobalVolume1024)
            {
                renderData.isEnabled = true;
                renderData.texWidth = 1024;
                renderData.texHeight = 1024;
                renderData.isFollowing = false;
            }
            else if (renderDataMode == RenderDataMode.InsideGlobalVolume2048)
            {
                renderData.isEnabled = true;
                renderData.texWidth = 2048;
                renderData.texHeight = 2048;
                renderData.isFollowing = false;
            }
            else if (renderDataMode == RenderDataMode.InsideGlobalVolume4096)
            {
                renderData.isEnabled = true;
                renderData.texWidth = 4096;
                renderData.texHeight = 4096;
                renderData.isFollowing = false;
            }
        }

        void CreateRenderBuffers()
        {
            for (int i = 0; i < renderDataSet.Count; i++)
            {
                var renderData = renderDataSet[i];

                if (renderData == null)
                {
                    continue;
                }

                CreateRenderBuffer(renderData);
            }
        }

        public void CreateRenderBuffer(TVERenderData renderData)
        {
            if (renderData.texObject != null)
            {
                renderData.texObject.Release();
            }

            if (renderData.commandBuffers != null)
            {
                for (int b = 0; b < renderData.commandBuffers.Length; b++)
                {
                    renderData.commandBuffers[b].Clear();
                }
            }

            renderData.bufferUsage = new float[9];
            Shader.SetGlobalFloatArray(renderData.texUsage, renderData.bufferUsage);

            if (renderData.isEnabled && renderData.bufferSize > -1)
            {
                int texWidth;
                int texHeight;

                if (renderData.useScreenResolution)
                {
                    texWidth = Mathf.Max(Mathf.RoundToInt(Screen.currentResolution.width * renderData.texScale), 32);
                    texHeight = Mathf.Max(Mathf.RoundToInt(Screen.currentResolution.height * renderData.texScale), 32);
                }
                else
                {
                    texWidth = Mathf.Max(Mathf.RoundToInt(renderData.texWidth * renderData.texScale), 32);
                    texHeight = Mathf.Max(Mathf.RoundToInt(renderData.texHeight * renderData.texScale), 32);
                }

                renderData.texObject = new RenderTexture(texWidth, texHeight, 0, renderData.texFormat);

                if (renderData.useRenderTextureArray)
                {
                    renderData.texObject.dimension = TextureDimension.Tex2DArray;
                }
                else
                {
                    renderData.texObject.dimension = TextureDimension.Tex2D;
                }

                renderData.texObject.volumeDepth = renderData.bufferSize + 1;
                renderData.texObject.name = renderData.texName;
                renderData.texObject.wrapMode = TextureWrapMode.Clamp;

                renderData.commandBuffers = new CommandBuffer[renderData.bufferSize + 1];

                for (int b = 0; b < renderData.commandBuffers.Length; b++)
                {
                    renderData.commandBuffers[b] = new CommandBuffer();
                    renderData.commandBuffers[b].name = renderData.texName;
                }

                Shader.SetGlobalTexture(renderData.texName, renderData.texObject);
                Shader.SetGlobalInt(renderData.texLayers, renderData.bufferSize + 1);
            }
            else
            {
                if (renderData.useRenderTextureArray)
                {
                    Shader.SetGlobalTexture(renderData.texName, Resources.Load<Texture2DArray>("Internal ArrayTex"));
                }
                else
                {
                    Shader.SetGlobalTexture(renderData.texName, Texture2D.whiteTexture);
                }

                Shader.SetGlobalInt(renderData.texLayers, 1);
            }
        }

        void UpdateRenderBuffers()
        {
            for (int d = 0; d < renderDataSet.Count; d++)
            {
                var renderData = renderDataSet[d];

                if (renderData == null || renderData.commandBuffers == null || !renderData.isEnabled || !renderData.isRendering)
                {
                    continue;
                }

                var bufferParams = Shader.GetGlobalVector(renderData.texParams);

                for (int b = 0; b < renderData.commandBuffers.Length; b++)
                {
                    renderData.commandBuffers[b].Clear();
                    renderData.commandBuffers[b].ClearRenderTarget(true, true, bufferParams);
                    renderData.bufferUsage[b] = 0;

                    for (int e = 0; e < renderElements.Count; e++)
                    {
                        var elementData = renderElements[e];

                        if (renderData.renderDataID == elementData.renderDataID)
                        {
                            if (elementData.layers[b] == 1)
                            {
                                Camera.SetupCurrent(mainCamera);

                                propertyBlock.SetFloat("_RaycastFadeValue", elementData.element.elementFadeValue);
                                elementData.element.elementRenderer.SetPropertyBlock(propertyBlock);

                                renderData.commandBuffers[b].DrawRenderer(elementData.element.elementRenderer, elementData.element.elementMaterial, 0, renderData.materialPass);
                                renderData.bufferUsage[b] = 1;
                            }
                        }

                    }

                    for (int e = 0; e < renderInstanced.Count; e++)
                    {
                        var elementData = renderInstanced[e];

                        if (!elementData.material.enableInstancing)
                        {
                            continue;
                        }

                        if (elementData.renderers.Count == 0)
                        {
                            continue;
                        }

                        if (renderData.renderDataID == elementData.renderDataID)
                        {
                            if (elementData.layers[b] == 1)
                            {
                                Matrix4x4[] matrix4X4s = new Matrix4x4[elementData.renderers.Count];
                                float[] fadeValues = new float[elementData.renderers.Count];

                                for (int p = 0; p < elementData.renderers.Count; p++)
                                {
                                    matrix4X4s[p] = elementData.renderers[p].localToWorldMatrix;
                                    fadeValues[p] = elementData.elements[p].elementFadeValue;
                                }

                                elementData.propertyBlock.SetFloatArray("_RaycastFadeValue", fadeValues);

                                renderData.commandBuffers[b].DrawMeshInstanced(elementData.mesh, 0, elementData.material, renderData.materialPass, matrix4X4s, matrix4X4s.Count(), elementData.propertyBlock);
                                renderData.bufferUsage[b] = 1;
                            }
                        }
                    }
                }

                Shader.SetGlobalFloatArray(renderData.texUsage, renderData.bufferUsage);

                //for (int u = 0; u < renderData.bufferUsage.Length; u++)
                //{
                //    Debug.Log(renderData.texUsage + " Index: " + u + " Usage: " + renderData.bufferUsage[u]);
                //}
            }
        }

        void ExecuteRenderBuffers()
        {
            for (int i = 0; i < renderDataSet.Count; i++)
            {
                var renderData = renderDataSet[i];

                if (renderData == null || renderData.commandBuffers == null || !renderData.isEnabled || !renderData.isRendering)
                {
                    continue;
                }

                GL.PushMatrix();
                RenderTexture currentRenderTexture = RenderTexture.active;

                var position = Vector3.zero;
                var scale = Vector3.zero;

                if (renderData.isFollowing)
                {
                    if (mainCamera != null && !renderData.isProjected)
                    {
                        var offsetX = followMainCameraVolume.x / 2 * mainCamera.transform.forward.x * followMainCameraOffset;
                        var offsetZ = followMainCameraVolume.z / 2 * mainCamera.transform.forward.z * followMainCameraOffset;
                        var cameraPos = mainCamera.transform.position + new Vector3(offsetX, 1, offsetZ);

                        float gridX = followMainCameraVolume.x / renderData.texWidth;
                        float gridZ = followMainCameraVolume.z / renderData.texHeight;
                        float posX = Mathf.Round(cameraPos.x / gridX) * gridX;
                        float posZ = Mathf.Round(cameraPos.z / gridZ) * gridZ;

                        position = new Vector3(posX, mainCamera.transform.position.y, posZ);
                        scale = new Vector3(followMainCameraVolume.x, followMainCameraVolume.y, followMainCameraVolume.z);
                    }
                }
                else
                {
                    position = gameObject.transform.position;
                    scale = gameObject.transform.lossyScale;
                }

                if (renderData.isProjected)
                {
                    if (mainCamera != null)
                    {
                        projectionMatrix = mainCamera.projectionMatrix;
                    }
                }
                else
                {
                    GL.modelview = modelViewMatrix;

                    projectionMatrix = Matrix4x4.Ortho(-scale.x / 2 + position.x,
                                                        scale.x / 2 + position.x,
                                                        scale.z / 2 - position.z,
                                                       -scale.z / 2 - position.z,
                                                       -scale.y / 2 + position.y,
                                                        scale.y / 2 + position.y);
                }

                var x = 1 / scale.x;
                var y = 1 / scale.z;
                var z = 1 / scale.x * position.x - 0.5f;
                var w = 1 / scale.z * position.z - 0.5f;
                var coord = new Vector4(x, y, -z, -w);

                renderData.volumePosition = position;
                renderData.volumeScale = scale;

                Shader.SetGlobalVector(renderData.texCoord, coord);

                GL.LoadProjectionMatrix(projectionMatrix);

                for (int b = 0; b < renderData.commandBuffers.Length; b++)
                {
                    Graphics.SetRenderTarget(renderData.texObject, 0, CubemapFace.Unknown, b);
                    Graphics.ExecuteCommandBuffer(renderData.commandBuffers[b]);
                }

                RenderTexture.active = currentRenderTexture;
                GL.PopMatrix();
            }
        }

        void SetGlobalShaderParameters()
        {
            Shader.SetGlobalFloat("TVE_ElementsFadeValue", elementsEdgeFade);
        }

        public void SortElementObjects()
        {
            for (int i = 0; i < renderElements.Count - 1; i++)
            {
                for (int j = 0; j < renderElements.Count - 1; j++)
                {
                    if (renderElements[j] != null && renderElements[j].element.gameObject.transform.position.y > renderElements[j + 1].element.gameObject.transform.position.y)
                    {
                        var next = renderElements[j + 1];
                        renderElements[j + 1] = renderElements[j];
                        renderElements[j] = next;
                    }
                }
            }
        }

        void SetElementsVisibility()
        {
            if (elementsVisibility == ElementsVisibility.AlwaysHidden)
            {
                DisableElementsVisibility();
            }
            else if (elementsVisibility == ElementsVisibility.AlwaysVisible)
            {
                EnableElementsVisibility();
            }
            else if (elementsVisibility == ElementsVisibility.HiddenAtRuntime)
            {
                if (Application.isPlaying)
                {
                    DisableElementsVisibility();
                }
                else
                {
                    EnableElementsVisibility();
                }
            }
        }

        void EnableElementsVisibility()
        {
            for (int i = 0; i < renderElements.Count; i++)
            {
                var elementData = renderElements[i];

                if (elementData != null && elementData.useGlobalVolumeVisibility)
                {
                    elementData.element.elementRenderer.enabled = true;
                }
            }
        }

        void DisableElementsVisibility()
        {
            for (int i = 0; i < renderElements.Count; i++)
            {
                var elementData = renderElements[i];

                if (elementData != null && elementData.useGlobalVolumeVisibility)
                {
                    elementData.element.elementRenderer.enabled = false;
                }
            }
        }

#if UNITY_EDITOR        
        void OnDrawGizmosSelected()
        {
            Gizmos.color = Color.black;
            //Gizmos.color = new Color(0.890f, 0.745f, 0.309f, 1f);
            Gizmos.DrawWireCube(transform.position, transform.lossyScale);
        }

        void OnDrawGizmos()
        {
            Gizmos.color = new Color(0.0f, 0.0f, 0.0f, 0.1f);
            Gizmos.DrawWireCube(transform.position, transform.lossyScale);

            if (useFollowMainCamera)
            {
                if (mainCamera != null)
                {
                    if (Selection.Contains(mainCamera.gameObject))
                    {
                        Gizmos.color = Color.black;
                        //Gizmos.color = new Color(0.890f, 0.745f, 0.309f, 1f);
                    }

                    var offsetX = followMainCameraVolume.x / 2 * mainCamera.transform.forward.x * followMainCameraOffset;
                    var offsetZ = followMainCameraVolume.z / 2 * mainCamera.transform.forward.z * followMainCameraOffset;
                    var cameraPos = mainCamera.transform.position + new Vector3(offsetX, 1, offsetZ);

                    Gizmos.DrawWireCube(new Vector3(cameraPos.x, mainCamera.transform.position.y, cameraPos.z), followMainCameraVolume);
                }
            }
        }

        void OnValidate()
        {
            if (renderDataSet == null)
            {
                return;
            }

            if (colorsData == null || extrasData == null || motionData == null || vertexData == null)
            {
                return;
            }

            UpdateRenderData(colorsData, renderColors);
            UpdateRenderData(extrasData, renderExtras);
            UpdateRenderData(motionData, renderMotion);
            UpdateRenderData(vertexData, renderVertex);

            CreateRenderBuffers();
        }
#endif
    }
}
