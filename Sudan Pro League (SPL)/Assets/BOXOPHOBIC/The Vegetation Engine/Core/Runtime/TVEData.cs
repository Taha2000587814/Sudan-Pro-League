// Cristian Pop - https://boxophobic.com/

using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace TheVegetationEngine
{
    public enum PropertyType
    {
        Texture = 0,
        Vector = 1,
        Value = 2,
    }

    public class TVEConstants
    {
        public const string ElementName = "Element";
        public const string ElementTypeTag = "ElementType";
        public const string ElementLayerMask = "_ElementLayerMask";
        public const string ElementDirectionMode = "_ElementDirectionMode";
        public const string ElementRaycastMode = "_ElementRaycastMode";
        public const string RaycastLayerMask = "_RaycastLayerMask";
        public const string RaycastDistanceEndValue = "_RaycastDistanceEndValue";
    }

    [System.Serializable]
    public class TVEMeshData
    {
        public Mesh mesh;
        public List<float> variationMask;
        public List<float> occlusionMask;
        public List<float> detailMask;
        public List<float> heightMask;
        public List<Vector2> detailCoord;
        public List<float> motion2Mask;
        public List<float> motion3Mask;
        public List<Vector3> pivotPositions;

        public TVEMeshData()
        {

        }
    }

    public class TVEMeshSettings
    {
        public bool isReadable = false;
        public bool keepQuads = false;

        public TVEMeshSettings()
        {

        }
    }

    [System.Serializable]
    public class TVEElementMaterialData
    {
        public Shader shader;
        public List<TVEElementPropertyData> props;

        public TVEElementMaterialData()
        {

        }
    }

    [System.Serializable]
    public class TVEElementPropertyData
    {
        public PropertyType type;
        public string prop;
        public Texture texture;
        public Vector4 vector;
        public float value;

        public TVEElementPropertyData()
        {

        }
    }

    [System.Serializable]
    public class TVEElementData
    {
        public TVEElement element;
        public int elementDataID = 0;
        public int instancedDataID = 0;
        public int renderDataID = 0;
        public List<int> layers;
        //public GameObject gameObject;
        //public Mesh mesh;
        //public Renderer renderer;
        //public Material material;
        //public float fadeValue;
        public bool useGlobalVolumeVisibility = true;

        public TVEElementData()
        {

        }
    }

    [System.Serializable]
    public class TVEInstancedData
    {
        public int instancedDataID = 0;
        public int renderDataID = 0;
        public List<int> layers;
        public Material material;
        public Mesh mesh;
        public List<TVEElement> elements = new List<TVEElement>();
        public List<Renderer> renderers = new List<Renderer>();
        public MaterialPropertyBlock propertyBlock = new MaterialPropertyBlock();

        public TVEInstancedData()
        {

        }
    }

    [System.Serializable]
    public class TVERenderData
    {
        [Tooltip("When enabled, the render texture will be created and rendered.")]
        public bool isEnabled = true;
        [Tooltip("When enabled, the elements are rendered in realtime.")]
        public bool isRendering = true;
        [Tooltip("When enabled, the global volume follows the main camera.")]
        public bool isFollowing = false;
        [Tooltip("When enabled, the elements are rendered by the main camera.")]
        public bool isProjected = false;

        [Space(10)]
        [Tooltip("Sets the render texture format.")]
        public RenderTextureFormat texFormat = RenderTextureFormat.Default;
        [Tooltip("Sets the render texture width.")]
        public int texWidth = 1024;
        [Tooltip("Sets the render texture height.")]
        public int texHeight = 1024;
        [Tooltip("Sets the render texture resolution scale.")]
        public float texScale = 1;
        [ColorUsage(true, true)]
        [Tooltip("Sets render texture background color.")]
        public Color texColor = Color.black;

        [Space(10)]
        [Tooltip("Sets the shaders global render texture property name.")]
        public string texName = "TVE_CustomTex";
        [Tooltip("Sets the shaders global render texture coordinates property name.")]
        public string texCoord = "TVE_CustomCoord";
        [Tooltip("Sets the shaders global background color property name.")]
        public string texParams = "TVE_CustomParams";
        [Tooltip("Sets the shaders global max layers count as an int.")]
        public string texLayers = "TVE_CustomLayers";
        [Tooltip("Sets the shaders global layers usage as a float array, where 0 uses the background color and 1 samples the render texture.")]
        public string texUsage = "TVE_CustomUsage";

        [Space(10)]
        [Tooltip("The material ElementType tag used for elements filtering.")]
        public string materialTag = "CustomElement";
        [Tooltip("Sets the shader rendering passes.")]
        public int materialPass = 0;

        [Space(10)]
        [Tooltip("When enabled, the render texture resolution will match the screen resolution.")]
        public bool useScreenResolution = false;
        [Tooltip("When enabled, the active color space will be applied to the background color.")]
        public bool useActiveColorSpace = true;
        [Tooltip("When enabled, the render texture will render elements based on their layer.")]
        public bool useRenderTextureArray = true;

        [System.NonSerialized]
        public int renderDataID = 0;
        [System.NonSerialized]
        public int bufferSize = 0;
        [System.NonSerialized]
        public float[] bufferUsage;
        [System.NonSerialized]
        public RenderTexture texObject;
        [System.NonSerialized]
        public CommandBuffer[] commandBuffers;
        [System.NonSerialized]
        public Vector3 volumePosition;
        [System.NonSerialized]
        public Vector3 volumeScale;

        public TVERenderData()
        {

        }
    }
}