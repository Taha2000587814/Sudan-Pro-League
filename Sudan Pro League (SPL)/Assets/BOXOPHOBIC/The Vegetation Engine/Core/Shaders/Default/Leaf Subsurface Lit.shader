// Made with Amplify Shader Editor v1.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Default/Leaf Subsurface Lit"
{
	Properties
	{
		[StyledCategory(Render Settings, 5, 10)]_CategoryRender("[ Category Render ]", Float) = 0
		[Enum(Opaque,0,Transparent,1)]_RenderMode("Render Mode", Float) = 0
		[Enum(Off,0,On,1)]_RenderZWrite("Render ZWrite", Float) = 1
		[Enum(Both,0,Back,1,Front,2)]_RenderCull("Render Faces", Float) = 0
		[Enum(Flip,0,Mirror,1,Same,2)]_RenderNormals("Render Normals", Float) = 0
		[HideInInspector]_RenderQueue("Render Queue", Float) = 0
		[HideInInspector]_RenderPriority("Render Priority", Float) = 0
		[Enum(Off,0,On,1)]_RenderSpecular("Render Specular", Float) = 1
		[Enum(Off,0,On,1)]_RenderDecals("Render Decals", Float) = 0
		[Enum(Off,0,On,1)]_RenderSSR("Render SSR", Float) = 0
		[Space(10)]_RenderDirect("Render Direct", Range( 0 , 1)) = 1
		_RenderShadow("Render Shadow", Range( 0 , 1)) = 1
		_RenderAmbient("Render Ambient", Range( 0 , 1)) = 1
		[Enum(Off,0,On,1)][Space(10)]_RenderClip("Alpha Clipping", Float) = 1
		[Enum(Off,0,On,1)]_RenderCoverage("Alpha To Mask", Float) = 0
		_AlphaClipValue("Alpha Treshold", Range( 0 , 1)) = 0.5
		_AlphaFeatherValue("Alpha Feather", Range( 0 , 2)) = 0.5
		[StyledSpace(10)]_SpaceRenderFade("# Space Render Fade", Float) = 0
		_FadeGlancingValue("Fade by Glancing Angle", Range( 0 , 1)) = 0
		_FadeCameraValue("Fade by Camera Distance", Range( 0 , 1)) = 1
		[StyledCategory(Global Settings)]_CategoryGlobal("[ Category Global ]", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerColorsValue("Layer Colors", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerExtrasValue("Layer Extras", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerMotionValue("Layer Motion", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerVertexValue("Layer Vertex", Float) = 0
		[StyledSpace(10)]_SpaceGlobalLayers("# Space Global Layers", Float) = 0
		[StyledMessage(Info, Procedural Variation in use. The Variation might not work as expected when switching from one LOD to another., _VertexVariationMode, 1 , 0, 10)]_MessageGlobalsVariation("# Message Globals Variation", Float) = 0
		_GlobalColors("Global Color", Range( 0 , 1)) = 1
		_GlobalAlpha("Global Alpha", Range( 0 , 1)) = 1
		_GlobalOverlay("Global Overlay", Range( 0 , 1)) = 1
		_GlobalWetness("Global Wetness", Range( 0 , 1)) = 1
		_GlobalEmissive("Global Emissive", Range( 0 , 1)) = 1
		_GlobalSize("Global Size Fade", Range( 0 , 1)) = 1
		[StyledSpace(10)]_SpaceGlobalLocals("# Space Global Locals", Float) = 0
		[StyledRemapSlider(_ColorsMaskMinValue, _ColorsMaskMaxValue, 0, 1)]_ColorsMaskRemap("Color Mask", Vector) = (0,0,0,0)
		[HideInInspector]_ColorsMaskMinValue("Color Mask Min Value", Range( 0 , 1)) = 0
		[HideInInspector]_ColorsMaskMaxValue("Color Mask Max Value", Range( 0 , 1)) = 0
		_ColorsVariationValue("Color Variation", Range( 0 , 1)) = 0
		[StyledRemapSlider(_AlphaMaskMinValue, _AlphaMaskMaxValue, 0, 1, 10, 0)]_AlphaMaskRemap("Alpha Mask", Vector) = (0,0,0,0)
		_AlphaVariationValue("Alpha Variation", Range( 0 , 1)) = 1
		[StyledRemapSlider(_OverlayMaskMinValue, _OverlayMaskMaxValue, 0, 1)]_OverlayMaskRemap("Overlay Mask", Vector) = (0,0,0,0)
		[HideInInspector]_OverlayMaskMinValue("Overlay Mask Min Value", Range( 0 , 1)) = 0.45
		[HideInInspector]_OverlayMaskMaxValue("Overlay Mask Max Value", Range( 0 , 1)) = 0.55
		_OverlayVariationValue("Overlay Variation", Range( 0 , 1)) = 0
		[StyledSpace(10)]_SpaceGlobalPosition("# Space Global Position", Float) = 0
		[StyledToggle]_ColorsPositionMode("Use Pivot Position for Colors", Float) = 0
		[StyledToggle]_ExtrasPositionMode("Use Pivot Position for Extras", Float) = 0
		[StyledCategory(Main Settings)]_CategoryMain("[Category Main ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainAlbedoTex("Main Albedo", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainNormalTex("Main Normal", 2D) = "bump" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainMaskTex("Main Mask", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[HDR]_MainColor("Main Color", Color) = (1,1,1,1)
		_MainNormalValue("Main Normal", Range( -8 , 8)) = 1
		_MainOcclusionValue("Main Occlusion", Range( 0 , 1)) = 0
		_MainSmoothnessValue("Main Smoothness", Range( 0 , 1)) = 0
		[StyledCategory(Detail Settings)]_CategoryDetail("[ Category Detail ]", Float) = 0
		[Enum(Off,0,On,1)]_DetailMode("Detail Mode", Float) = 0
		[Enum(Overlay,0,Replace,1)]_DetailBlendMode("Detail Blend", Float) = 1
		[Enum(Vertex Blue,0,Projection,1)]_DetailTypeMode("Detail Type", Float) = 0
		[StyledRemapSlider(_DetailBlendMinValue, _DetailBlendMaxValue,0,1)]_DetailBlendRemap("Detail Blending", Vector) = (0,0,0,0)
		[StyledCategory(Occlusion Settings)]_CategoryOcclusion("[ Category Occlusion ]", Float) = 0
		[HDR]_VertexOcclusionColor("Vertex Occlusion Color", Color) = (1,1,1,1)
		[StyledRemapSlider(_VertexOcclusionMinValue, _VertexOcclusionMaxValue, 0, 1)]_VertexOcclusionRemap("Vertex Occlusion Mask", Vector) = (0,0,0,0)
		[HideInInspector]_VertexOcclusionMinValue("Vertex Occlusion Min Value", Range( 0 , 1)) = 0
		[HideInInspector]_VertexOcclusionMaxValue("Vertex Occlusion Max Value", Range( 0 , 1)) = 1
		[StyledCategory(Subsurface Settings)]_CategorySubsurface("[ Category Subsurface ]", Float) = 0
		_SubsurfaceValue("Subsurface Intensity", Range( 0 , 1)) = 1
		[HDR]_SubsurfaceColor("Subsurface Color", Color) = (0.4,0.4,0.1,1)
		[StyledRemapSlider(_SubsurfaceMaskMinValue, _SubsurfaceMaskMaxValue,0,1)]_SubsurfaceMaskRemap("Subsurface Mask", Vector) = (0,0,0,0)
		[HideInInspector]_SubsurfaceMaskMinValue("Subsurface Mask Min Value", Range( 0 , 1)) = 0
		[HideInInspector]_SubsurfaceMaskMaxValue("Subsurface Mask Max Value", Range( 0 , 1)) = 1
		[Space(10)][DiffusionProfile]_SubsurfaceDiffusion("Subsurface Diffusion", Float) = 0
		[HideInInspector]_SubsurfaceDiffusion_Asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[HideInInspector][Space(10)][ASEDiffusionProfile(_SubsurfaceDiffusion)]_SubsurfaceDiffusion_asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[Space(10)]_SubsurfaceScatteringValue("Subsurface Scattering", Range( 0 , 16)) = 2
		_SubsurfaceAngleValue("Subsurface Angle", Range( 1 , 16)) = 8
		_SubsurfaceNormalValue("Subsurface Normal", Range( 0 , 1)) = 0
		_SubsurfaceDirectValue("Subsurface Direct", Range( 0 , 1)) = 1
		_SubsurfaceAmbientValue("Subsurface Ambient", Range( 0 , 1)) = 0.2
		_SubsurfaceShadowValue("Subsurface Shadow", Range( 0 , 1)) = 1
		[StyledCategory(Gradient Settings)]_CategoryGradient("[ Category Gradient ]", Float) = 0
		[HDR]_GradientColorOne("Gradient Color One", Color) = (1,1,1,1)
		[HDR]_GradientColorTwo("Gradient Color Two", Color) = (1,1,1,1)
		[StyledRemapSlider(_GradientMinValue, _GradientMaxValue, 0, 1)]_GradientMaskRemap("Gradient Mask", Vector) = (0,0,0,0)
		[HideInInspector]_GradientMinValue("Gradient Mask Min", Range( 0 , 1)) = 0
		[HideInInspector]_GradientMaxValue("Gradient Mask Max ", Range( 0 , 1)) = 1
		[StyledCategory(Noise Settings)]_CategoryNoise("[ Category Noise ]", Float) = 0
		[StyledRemapSlider(_NoiseMinValue, _NoiseMaxValue, 0, 1)]_NoiseMaskRemap("Noise Mask", Vector) = (0,0,0,0)
		[StyledCategory(Emissive Settings)]_CategoryEmissive("[ Category Emissive]", Float) = 0
		[NoScaleOffset][Space(10)][StyledTextureSingleLine]_EmissiveTex("Emissive Texture", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_EmissiveUVs("Emissive UVs", Vector) = (1,1,0,0)
		[Enum(None,0,Any,10,Baked,20,Realtime,30)]_EmissiveFlagMode("Emissive Baking", Float) = 0
		[HDR]_EmissiveColor("Emissive Color", Color) = (0,0,0,0)
		[StyledEmissiveIntensity]_EmissiveIntensityParams("Emissive Intensity", Vector) = (1,1,1,0)
		[StyledCategory(Perspective Settings)]_CategoryPerspective("[ Category Perspective ]", Float) = 0
		[StyledCategory(Size Fade Settings)]_CategorySizeFade("[ Category Size Fade ]", Float) = 0
		[StyledMessage(Info, The Size Fade feature is recommended to be used to fade out vegetation at a distance in combination with the LOD Groups or with a 3rd party culling system., _SizeFadeMode, 1, 0, 10)]_MessageSizeFade("# Message Size Fade", Float) = 0
		[StyledCategory(Motion Settings)]_CategoryMotion("[ Category Motion ]", Float) = 0
		[StyledMessage(Info, Procedural variation in use. Use the Scale settings if the Variation is splitting the mesh., _VertexVariationMode, 1 , 0, 10)]_MessageMotionVariation("# Message Motion Variation", Float) = 0
		_MotionFacingValue("Motion Directional Mask", Range( 0 , 1)) = 1
		[StyledSpace(10)]_SpaceMotionGlobals("# SpaceMotionGlobals", Float) = 0
		_MotionAmplitude_10("Motion Bending", Range( 0 , 2)) = 0.2
		[IntRange]_MotionSpeed_10("Motion Speed", Range( 0 , 40)) = 2
		_MotionScale_10("Motion Scale", Range( 0 , 20)) = 0
		_MotionVariation_10("Motion Variation", Range( 0 , 20)) = 0
		[Space(10)]_MotionAmplitude_20("Motion Squash", Range( 0 , 2)) = 0.2
		_MotionAmplitude_22("Motion Rolling", Range( 0 , 2)) = 0.2
		[IntRange]_MotionSpeed_20("Motion Speed", Range( 0 , 40)) = 6
		_MotionScale_20("Motion Scale", Range( 0 , 20)) = 0.5
		_MotionVariation_20("Motion Variation", Range( 0 , 20)) = 0
		[Space(10)]_MotionAmplitude_32("Motion Flutter", Range( 0 , 2)) = 0.2
		[IntRange]_MotionSpeed_32("Motion Speed", Range( 0 , 40)) = 20
		_MotionScale_32("Motion Scale", Range( 0 , 20)) = 10
		_MotionVariation_32("Motion Variation", Range( 0 , 20)) = 0
		[Space(10)]_InteractionAmplitude("Interaction Amplitude", Range( 0 , 2)) = 1
		_InteractionMaskValue("Interaction Use Mask", Range( 0 , 1)) = 1
		[StyledSpace(10)]_SpaceMotionLocals("# SpaceMotionLocals", Float) = 0
		[StyledToggle]_MotionValue_20("Use Branch Motion Settings", Float) = 1
		[StyledToggle]_MotionValue_30("Use Flutter Motion Settings", Float) = 1
		[HideInInspector][StyledToggle]_VertexPivotMode("Enable Pre Baked Pivots", Float) = 0
		[HideInInspector][StyledToggle]_VertexDataMode("Enable Batching Support", Float) = 0
		[HideInInspector][StyledToggle]_VertexDynamicMode("Enable Dynamic Support", Float) = 0
		[HideInInspector]_render_normals("_render_normals", Vector) = (1,1,1,0)
		[HideInInspector]_Cutoff("Legacy Cutoff", Float) = 0.5
		[HideInInspector]_Color("Legacy Color", Color) = (0,0,0,0)
		[HideInInspector]_MainTex("Legacy MainTex", 2D) = "white" {}
		[HideInInspector]_BumpMap("Legacy BumpMap", 2D) = "white" {}
		[HideInInspector]_LayerReactValue("Legacy Layer React", Float) = 0
		[HideInInspector]_VertexRollingMode("Legacy Vertex Rolling", Float) = 1
		[HideInInspector]_MaxBoundsInfo("Legacy Bounds Info", Vector) = (1,1,1,1)
		[HideInInspector]_VertexVariationMode("_VertexVariationMode", Float) = 0
		[HideInInspector]_VertexMasksMode("_VertexMasksMode", Float) = 0
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 1
		[HideInInspector]_IsVersion("_IsVersion", Float) = 710
		[HideInInspector]_HasEmissive("_HasEmissive", Float) = 0
		[HideInInspector]_HasGradient("_HasGradient", Float) = 0
		[HideInInspector]_HasOcclusion("_HasOcclusion", Float) = 0
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		[HideInInspector]_IsLeafShader("_IsLeafShader", Float) = 1
		[HideInInspector]_IsSubsurfaceShader("_IsSubsurfaceShader", Float) = 1
		[HideInInspector]_render_cull("_render_cull", Float) = 0
		[HideInInspector]_render_src("_render_src", Float) = 5
		[HideInInspector]_render_dst("_render_dst", Float) = 10
		[HideInInspector]_render_zw("_render_zw", Float) = 1
		[HideInInspector]_render_coverage("_render_coverage", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull [_render_cull]
		ZWrite [_render_zw]
		Blend [_render_src] [_render_dst]
		
		AlphaToMask [_render_coverage]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 4.5
		#pragma shader_feature_local TVE_FEATURE_CLIP
		#pragma shader_feature_local TVE_FEATURE_BATCHING
		//TVE Injection Defines
		//SHADER INJECTION POINT BEGIN
		//SHADER INJECTION POINT END
		//TVE Pipeline Defines
		#define THE_VEGETATION_ENGINE
		#define TVE_IS_STANDARD_PIPELINE
		//TVE Shader Type Defines
		#define TVE_IS_VEGETATION_SHADER
		#define ASE_USING_SAMPLING_MACROS 1
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
		#define SAMPLE_TEXTURE3D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
		#define SAMPLE_TEXTURE3D(tex,samplerTex,coord) tex3D(tex,coord)
		#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
		#endif//ASE Sampling Macros

		#pragma surface surf StandardSpecularCustom keepalpha addshadow fullforwardshadows exclude_path:deferred dithercrossfade vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float4 uv_texcoord;
			half ASEIsFrontFacing : VFACE;
			float vertexToFrag11_g80979;
			float vertexToFrag11_g80968;
			float3 vertexToFrag3890_g80954;
			float3 vertexToFrag4224_g80954;
			float4 vertexColor : COLOR;
			float3 vertexToFrag5058_g80954;
			float3 worldNormal;
			INTERNAL_DATA
			float vertexToFrag11_g81006;
		};

		struct SurfaceOutputStandardSpecularCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half3 Specular;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Translucency;
		};

		uniform half _render_coverage;
		uniform half _render_dst;
		uniform half _render_zw;
		uniform half _render_src;
		uniform half _IsLeafShader;
		uniform half _render_cull;
		uniform half _IsSubsurfaceShader;
		uniform float _SubsurfaceDiffusion;
		uniform half _RenderDecals;
		uniform half _SubsurfaceNormalValue;
		uniform half _CategoryRender;
		uniform half _AlphaFeatherValue;
		uniform half _CategoryNoise;
		uniform half _RenderSSR;
		uniform half _CategoryPerspective;
		uniform float4 _MaxBoundsInfo;
		uniform half _SpaceGlobalPosition;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		SamplerState sampler_MainTex;
		uniform half4 _AlphaMaskRemap;
		uniform half _DetailBlendMode;
		uniform half _RenderQueue;
		uniform half _RenderDirect;
		uniform float4 _GradientMaskRemap;
		uniform half _MessageMotionVariation;
		uniform half4 _DetailBlendRemap;
		uniform half _RenderZWrite;
		uniform half _SubsurfaceScatteringValue;
		uniform float4 _SubsurfaceDiffusion_Asset;
		uniform half _SubsurfaceShadowValue;
		uniform half _RenderClip;
		uniform half4 _VertexOcclusionRemap;
		uniform half _CategoryGlobal;
		uniform half _MessageGlobalsVariation;
		uniform half _HasGradient;
		uniform half4 _ColorsMaskRemap;
		uniform half4 _SubsurfaceMaskRemap;
		uniform half _EmissiveFlagMode;
		uniform half _SpaceRenderFade;
		uniform half _CategoryDetail;
		uniform half _CategoryOcclusion;
		uniform half _RenderPriority;
		uniform half TVE_Enabled;
		uniform half _CategorySubsurface;
		uniform half _IsTVEShader;
		uniform half _RenderAmbient;
		uniform float4 _Color;
		uniform half _HasEmissive;
		uniform half _VertexMasksMode;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		SamplerState sampler_BumpMap;
		uniform half _SpaceMotionGlobals;
		uniform float4 _SubsurfaceDiffusion_asset;
		uniform half4 _OverlayMaskRemap;
		uniform half _RenderShadow;
		uniform float4 _NoiseMaskRemap;
		uniform half _CategoryMotion;
		uniform half _MessageSizeFade;
		uniform half _CategorySizeFade;
		uniform half _CategoryGradient;
		uniform half _DetailTypeMode;
		uniform half _SpaceGlobalLocals;
		uniform half _DetailMode;
		uniform half _RenderCoverage;
		uniform half _HasOcclusion;
		uniform half _RenderCull;
		uniform half _SubsurfaceAmbientValue;
		uniform half _SubsurfaceDirectValue;
		uniform half _SpaceGlobalLayers;
		uniform half _RenderNormals;
		uniform half _CategoryMain;
		uniform half _VertexRollingMode;
		uniform half _RenderMode;
		uniform half _SpaceMotionLocals;
		uniform half _LayerReactValue;
		uniform half _AlphaClipValue;
		uniform half _CategoryEmissive;
		uniform half _SubsurfaceAngleValue;
		uniform half _Cutoff;
		uniform half _VertexVariationMode;
		uniform half _IsVersion;
		uniform half _VertexPivotMode;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_NoiseTex);
		uniform float _MotionScale_10;
		uniform half4 TVE_NoiseParams;
		uniform half4 TVE_MotionParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
		uniform half4 TVE_MotionCoords;
		uniform half _LayerMotionValue;
		SamplerState sampler_Linear_Clamp;
		uniform float TVE_MotionUsage[10];
		uniform float _MotionSpeed_10;
		uniform half _MotionVariation_10;
		uniform half _VertexDynamicMode;
		SamplerState sampler_Linear_Repeat;
		uniform half _MotionAmplitude_10;
		uniform half _InteractionAmplitude;
		uniform half _InteractionMaskValue;
		uniform half _MotionScale_20;
		uniform half _MotionVariation_20;
		uniform half _MotionSpeed_20;
		uniform half _MotionValue_20;
		uniform half _MotionFacingValue;
		uniform half _MotionAmplitude_20;
		uniform half _MotionAmplitude_22;
		uniform float _MotionScale_32;
		uniform float _MotionVariation_32;
		uniform float _MotionSpeed_32;
		uniform half4 TVE_FlutterParams;
		uniform half _MotionAmplitude_32;
		uniform half _MotionValue_30;
		uniform half TVE_MotionFadeEnd;
		uniform half TVE_MotionFadeStart;
		uniform half _VertexDataMode;
		uniform half4 TVE_VertexParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertexTex);
		uniform half4 TVE_VertexCoords;
		uniform half _LayerVertexValue;
		uniform float TVE_VertexUsage[10];
		uniform half _GlobalSize;
		uniform half _DisableSRPBatcher;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
		uniform half4 _MainUVs;
		uniform half _MainNormalValue;
		uniform half3 _render_normals;
		uniform half4 _GradientColorTwo;
		uniform half4 _GradientColorOne;
		uniform half _GradientMinValue;
		uniform half _GradientMaxValue;
		uniform half4 _MainColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
		SamplerState sampler_MainAlbedoTex;
		uniform half4 _VertexOcclusionColor;
		uniform half _VertexOcclusionMinValue;
		uniform half _VertexOcclusionMaxValue;
		uniform half4 TVE_ColorsParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
		uniform half4 TVE_ColorsCoords;
		uniform half _ColorsPositionMode;
		uniform half _LayerColorsValue;
		uniform float TVE_ColorsUsage[10];
		uniform half _GlobalColors;
		uniform half _ColorsVariationValue;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainMaskTex);
		uniform half _ColorsMaskMinValue;
		uniform half _ColorsMaskMaxValue;
		uniform half4 TVE_OverlayColor;
		uniform half _GlobalOverlay;
		uniform half4 TVE_ExtrasParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
		uniform half4 TVE_ExtrasCoords;
		uniform half _ExtrasPositionMode;
		uniform half _LayerExtrasValue;
		uniform float TVE_ExtrasUsage[10];
		uniform half _OverlayVariationValue;
		uniform half _OverlayMaskMinValue;
		uniform half _OverlayMaskMaxValue;
		uniform half4 _EmissiveColor;
		uniform float4 _EmissiveIntensityParams;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissiveTex);
		uniform half4 _EmissiveUVs;
		uniform half _GlobalEmissive;
		uniform half _RenderSpecular;
		uniform half _MainSmoothnessValue;
		uniform half TVE_OverlaySmoothness;
		uniform half _GlobalWetness;
		uniform half _MainOcclusionValue;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;
		uniform half4 _SubsurfaceColor;
		uniform half _SubsurfaceValue;
		uniform half TVE_SubsurfaceValue;
		uniform half _SubsurfaceMaskMinValue;
		uniform half _SubsurfaceMaskMaxValue;
		uniform half _AlphaVariationValue;
		uniform half _GlobalAlpha;
		uniform half _FadeGlancingValue;
		uniform half TVE_CameraFadeStart;
		uniform half TVE_CameraFadeEnd;
		uniform half _FadeCameraValue;
		UNITY_DECLARE_TEX3D_NOSAMPLER(TVE_ScreenTex3D);
		uniform half TVE_ScreenTexCoord;


		float2 DecodeFloatToVector2( float enc )
		{
			float2 result ;
			result.y = enc % 2048;
			result.x = floor(enc / 2048);
			return result / (2048 - 1);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VertexPosition3588_g80954 = ase_vertex3Pos;
			float3 appendResult60_g81017 = (float3(v.texcoord3.x , v.texcoord3.z , v.texcoord3.y));
			half3 Mesh_PivotsData2831_g80954 = ( appendResult60_g81017 * _VertexPivotMode );
			half3 Mesh_PivotsOS2291_g80954 = Mesh_PivotsData2831_g80954;
			float3 temp_output_2283_0_g80954 = ( VertexPosition3588_g80954 - Mesh_PivotsOS2291_g80954 );
			half3 VertexPos40_g80958 = temp_output_2283_0_g80954;
			float3 appendResult74_g80958 = (float3(VertexPos40_g80958.x , 0.0 , 0.0));
			half3 VertexPosRotationAxis50_g80958 = appendResult74_g80958;
			float3 break84_g80958 = VertexPos40_g80958;
			float3 appendResult81_g80958 = (float3(0.0 , break84_g80958.y , break84_g80958.z));
			half3 VertexPosOtherAxis82_g80958 = appendResult81_g80958;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 vertexToFrag3890_g80954 = ase_worldPos;
			float3 WorldPosition3905_g80954 = vertexToFrag3890_g80954;
			half3 Input_Position419_g81046 = WorldPosition3905_g80954;
			float Input_MotionScale287_g81046 = ( _MotionScale_10 + 0.2 );
			half Global_Scale448_g81046 = TVE_NoiseParams.x;
			float2 temp_output_597_0_g81046 = (( Input_Position419_g81046 * Input_MotionScale287_g81046 * Global_Scale448_g81046 * 0.0075 )).xz;
			float4 temp_output_91_19_g80996 = TVE_MotionCoords;
			float4x4 break19_g81011 = unity_ObjectToWorld;
			float3 appendResult20_g81011 = (float3(break19_g81011[ 0 ][ 3 ] , break19_g81011[ 1 ][ 3 ] , break19_g81011[ 2 ][ 3 ]));
			float3 temp_output_122_0_g81011 = Mesh_PivotsData2831_g80954;
			float3 PivotsOnly105_g81011 = (mul( unity_ObjectToWorld, float4( temp_output_122_0_g81011 , 0.0 ) ).xyz).xyz;
			half3 ObjectData20_g81012 = ( appendResult20_g81011 + PivotsOnly105_g81011 );
			half3 WorldData19_g81012 = ase_worldPos;
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g81012 = WorldData19_g81012;
			#else
				float3 staticSwitch14_g81012 = ObjectData20_g81012;
			#endif
			float3 temp_output_114_0_g81011 = staticSwitch14_g81012;
			float3 vertexToFrag4224_g80954 = temp_output_114_0_g81011;
			half3 ObjectData20_g81008 = vertexToFrag4224_g80954;
			half3 WorldData19_g81008 = vertexToFrag3890_g80954;
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g81008 = WorldData19_g81008;
			#else
				float3 staticSwitch14_g81008 = ObjectData20_g81008;
			#endif
			float3 ObjectPosition4223_g80954 = staticSwitch14_g81008;
			half2 UV94_g80996 = ( (temp_output_91_19_g80996).zw + ( (temp_output_91_19_g80996).xy * (ObjectPosition4223_g80954).xz ) );
			float temp_output_84_0_g80996 = _LayerMotionValue;
			float4 lerpResult107_g80996 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g80996,temp_output_84_0_g80996), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g80996]);
			half4 Global_Motion_Params3909_g80954 = lerpResult107_g80996;
			float4 break322_g81030 = Global_Motion_Params3909_g80954;
			float2 appendResult433_g81030 = (float2(break322_g81030.x , break322_g81030.y));
			float2 temp_output_436_0_g81030 = (appendResult433_g81030*2.0 + -1.0);
			half2 Global_Motion_DirectionWS4683_g80954 = temp_output_436_0_g81030;
			half2 Input_DirectionWS423_g81046 = Global_Motion_DirectionWS4683_g80954;
			half Input_MotionSpeed62_g81046 = _MotionSpeed_10;
			half Global_Speed449_g81046 = TVE_NoiseParams.y;
			half Input_MotionVariation284_g81046 = _MotionVariation_10;
			float3 break111_g81018 = ObjectPosition4223_g80954;
			half Global_DynamicMode5112_g80954 = _VertexDynamicMode;
			half Input_DynamicMode120_g81018 = Global_DynamicMode5112_g80954;
			float Mesh_Variation16_g80954 = v.color.r;
			half Input_Variation124_g81018 = Mesh_Variation16_g80954;
			half ObjectData20_g81019 = frac( ( ( ( break111_g81018.x + break111_g81018.y + break111_g81018.z + 0.001275 ) * ( 1.0 - Input_DynamicMode120_g81018 ) ) + Input_Variation124_g81018 ) );
			half WorldData19_g81019 = Input_Variation124_g81018;
			#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g81019 = WorldData19_g81019;
			#else
				float staticSwitch14_g81019 = ObjectData20_g81019;
			#endif
			float clampResult129_g81018 = clamp( staticSwitch14_g81019 , 0.01 , 0.99 );
			half Global_MeshVariation5104_g80954 = clampResult129_g81018;
			half Input_GlobalVariation569_g81046 = Global_MeshVariation5104_g80954;
			float temp_output_630_0_g81046 = ( ( ( _Time.y * Input_MotionSpeed62_g81046 * Global_Speed449_g81046 ) + ( Input_MotionVariation284_g81046 * Input_GlobalVariation569_g81046 ) ) * 0.03 );
			float temp_output_607_0_g81046 = frac( temp_output_630_0_g81046 );
			float4 lerpResult590_g81046 = lerp( SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g81046 + ( -Input_DirectionWS423_g81046 * temp_output_607_0_g81046 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g81046 + ( -Input_DirectionWS423_g81046 * frac( ( temp_output_630_0_g81046 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_607_0_g81046 - 0.5 ) ) / 0.5 ));
			half2 Global_Noise_X5548_g80954 = ((lerpResult590_g81046).rg*2.0 + -1.0);
			half2 Input_NoiseWS487_g81038 = Global_Noise_X5548_g80954;
			float2 break441_g81030 = temp_output_436_0_g81030;
			float3 appendResult440_g81030 = (float3(break441_g81030.x , 0.0 , break441_g81030.y));
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			half2 Global_Motion_DirectionOS39_g80954 = (( mul( unity_WorldToObject, float4( appendResult440_g81030 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
			half2 Input_DirectionOS358_g81038 = Global_Motion_DirectionOS39_g80954;
			half Global_Motion_WindPower2223_g80954 = break322_g81030.z;
			half Input_GlobalWind449_g81038 = Global_Motion_WindPower2223_g80954;
			float temp_output_565_0_g81038 = ( 1.0 - Input_GlobalWind449_g81038 );
			float2 lerpResult516_g81038 = lerp( Input_NoiseWS487_g81038 , Input_DirectionOS358_g81038 , ( ( 1.0 - ( temp_output_565_0_g81038 * temp_output_565_0_g81038 ) ) * 0.6 ));
			half Mesh_Height1524_g80954 = v.color.a;
			half Input_MeshHeight388_g81038 = Mesh_Height1524_g80954;
			half ObjectData20_g81039 = ( Input_MeshHeight388_g81038 * 2.0 );
			float enc62_g81024 = v.texcoord.w;
			float2 localDecodeFloatToVector262_g81024 = DecodeFloatToVector2( enc62_g81024 );
			float2 break63_g81024 = ( localDecodeFloatToVector262_g81024 * 100.0 );
			float Bounds_Height5230_g80954 = break63_g81024.x;
			half Input_BoundsHeight390_g81038 = Bounds_Height5230_g80954;
			half WorldData19_g81039 = ( ( Input_MeshHeight388_g81038 * Input_MeshHeight388_g81038 ) * Input_BoundsHeight390_g81038 * 2.0 );
			#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g81039 = WorldData19_g81039;
			#else
				float staticSwitch14_g81039 = ObjectData20_g81039;
			#endif
			half Final_Motion_10_Amplitude321_g81038 = staticSwitch14_g81039;
			half Motion_10_Amplitude2258_g80954 = _MotionAmplitude_10;
			half Input_BendingAmplitude376_g81038 = Motion_10_Amplitude2258_g80954;
			half Input_InteractionAmplitude58_g81038 = _InteractionAmplitude;
			half Input_InteractionUseMask62_g81038 = _InteractionMaskValue;
			float lerpResult371_g81038 = lerp( 2.0 , Final_Motion_10_Amplitude321_g81038 , Input_InteractionUseMask62_g81038);
			half ObjectData20_g81040 = lerpResult371_g81038;
			half WorldData19_g81040 = Final_Motion_10_Amplitude321_g81038;
			#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g81040 = WorldData19_g81040;
			#else
				float staticSwitch14_g81040 = ObjectData20_g81040;
			#endif
			half Final_InteractionAmplitude373_g81038 = ( Input_InteractionAmplitude58_g81038 * staticSwitch14_g81040 );
			half Global_InteractionMask66_g80954 = ( break322_g81030.w * break322_g81030.w );
			float Input_InteractionGlobalMask330_g81038 = Global_InteractionMask66_g80954;
			half Final_InteractionMask525_g81038 = saturate( ( Input_InteractionAmplitude58_g81038 * Input_InteractionGlobalMask330_g81038 ) );
			float2 lerpResult551_g81038 = lerp( ( lerpResult516_g81038 * ( Final_Motion_10_Amplitude321_g81038 * Input_BendingAmplitude376_g81038 * Input_GlobalWind449_g81038 ) ) , ( Input_DirectionOS358_g81038 * Final_InteractionAmplitude373_g81038 ) , Final_InteractionMask525_g81038);
			float2 break364_g81038 = lerpResult551_g81038;
			half Motion_10_BendingZ190_g80954 = break364_g81038.y;
			half Angle44_g80958 = Motion_10_BendingZ190_g80954;
			half3 VertexPos40_g80972 = ( VertexPosRotationAxis50_g80958 + ( VertexPosOtherAxis82_g80958 * cos( Angle44_g80958 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g80958 ) * sin( Angle44_g80958 ) ) );
			float3 appendResult74_g80972 = (float3(0.0 , 0.0 , VertexPos40_g80972.z));
			half3 VertexPosRotationAxis50_g80972 = appendResult74_g80972;
			float3 break84_g80972 = VertexPos40_g80972;
			float3 appendResult81_g80972 = (float3(break84_g80972.x , break84_g80972.y , 0.0));
			half3 VertexPosOtherAxis82_g80972 = appendResult81_g80972;
			half Motion_10_BendingX216_g80954 = break364_g81038.x;
			half Angle44_g80972 = -Motion_10_BendingX216_g80954;
			float Sum_Position446_g81043 = ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z );
			half Input_MotionScale321_g81043 = ( _MotionScale_20 * 0.1 );
			half Input_MotionVariation330_g81043 = _MotionVariation_20;
			half Input_GlobalVariation400_g81043 = Global_MeshVariation5104_g80954;
			half Input_MotionSpeed62_g81043 = _MotionSpeed_20;
			float temp_output_404_0_g81043 = ( _Time.y * Input_MotionSpeed62_g81043 );
			half Motion_20_SineA450_g81043 = sin( ( ( Sum_Position446_g81043 * Input_MotionScale321_g81043 ) + ( Input_MotionVariation330_g81043 * Input_GlobalVariation400_g81043 ) + temp_output_404_0_g81043 ) );
			half Motion_20_SineB395_g81043 = sin( ( ( temp_output_404_0_g81043 * 0.7562 ) + ( Sum_Position446_g81043 * Input_MotionScale321_g81043 ) ) );
			half3 Input_Position419_g81020 = VertexPosition3588_g80954;
			float3 normalizeResult518_g81020 = normalize( Input_Position419_g81020 );
			half2 Input_DirectionOS423_g81020 = Global_Motion_DirectionOS39_g80954;
			float2 break521_g81020 = -Input_DirectionOS423_g81020;
			float3 appendResult522_g81020 = (float3(break521_g81020.x , 0.0 , break521_g81020.y));
			float dotResult519_g81020 = dot( normalizeResult518_g81020 , appendResult522_g81020 );
			half Input_Mask62_g81020 = _MotionFacingValue;
			float lerpResult524_g81020 = lerp( 1.0 , (dotResult519_g81020*0.5 + 0.5) , Input_Mask62_g81020);
			half ObjectData20_g81021 = max( lerpResult524_g81020 , 0.001 );
			half WorldData19_g81021 = 1.0;
			#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g81021 = WorldData19_g81021;
			#else
				float staticSwitch14_g81021 = ObjectData20_g81021;
			#endif
			half Motion_FacingMask5214_g80954 = staticSwitch14_g81021;
			half Motion_20_Amplitude4381_g80954 = ( _MotionValue_20 * Motion_FacingMask5214_g80954 );
			half Input_MotionAmplitude384_g81043 = Motion_20_Amplitude4381_g80954;
			half Input_GlobalWind407_g81043 = Global_Motion_WindPower2223_g80954;
			float4 break638_g81046 = abs( lerpResult590_g81046 );
			half Global_Noise_B5526_g80954 = break638_g81046.b;
			half Input_GlobalNoise411_g81043 = Global_Noise_B5526_g80954;
			float lerpResult413_g81043 = lerp( 1.4 , 0.4 , Input_GlobalWind407_g81043);
			half Final_MotionAmplitude418_g81043 = ( Input_MotionAmplitude384_g81043 * Input_GlobalWind407_g81043 * pow( Input_GlobalNoise411_g81043 , lerpResult413_g81043 ) );
			half Input_Squash58_g81043 = _MotionAmplitude_20;
			float enc59_g81024 = v.texcoord.z;
			float2 localDecodeFloatToVector259_g81024 = DecodeFloatToVector2( enc59_g81024 );
			float2 break61_g81024 = localDecodeFloatToVector259_g81024;
			half Mesh_Motion_2060_g80954 = break61_g81024.x;
			half Input_MeshMotion_20388_g81043 = Mesh_Motion_2060_g80954;
			float Bounds_Radius5231_g80954 = break63_g81024.y;
			half Input_BoundsRadius390_g81043 = Bounds_Radius5231_g80954;
			half2 Input_DirectionOS366_g81043 = Global_Motion_DirectionOS39_g80954;
			float2 break371_g81043 = Input_DirectionOS366_g81043;
			float3 appendResult372_g81043 = (float3(break371_g81043.x , ( Motion_20_SineA450_g81043 * 0.1 ) , break371_g81043.y));
			half3 Motion_20_Squash4418_g80954 = ( ( (max( Motion_20_SineA450_g81043 , Motion_20_SineB395_g81043 )*0.2 + 1.0) * Final_MotionAmplitude418_g81043 * Input_Squash58_g81043 * Input_MeshMotion_20388_g81043 * Input_BoundsRadius390_g81043 ) * appendResult372_g81043 );
			half3 VertexPos40_g80956 = ( ( VertexPosRotationAxis50_g80972 + ( VertexPosOtherAxis82_g80972 * cos( Angle44_g80972 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g80972 ) * sin( Angle44_g80972 ) ) ) + Motion_20_Squash4418_g80954 );
			float3 appendResult74_g80956 = (float3(0.0 , VertexPos40_g80956.y , 0.0));
			float3 VertexPosRotationAxis50_g80956 = appendResult74_g80956;
			float3 break84_g80956 = VertexPos40_g80956;
			float3 appendResult81_g80956 = (float3(break84_g80956.x , 0.0 , break84_g80956.z));
			float3 VertexPosOtherAxis82_g80956 = appendResult81_g80956;
			half Input_Rolling379_g81043 = _MotionAmplitude_22;
			half Motion_20_Rolling5257_g80954 = ( Motion_20_SineA450_g81043 * Final_MotionAmplitude418_g81043 * Input_Rolling379_g81043 * Input_MeshMotion_20388_g81043 );
			half Angle44_g80956 = Motion_20_Rolling5257_g80954;
			float2 appendResult461_g81031 = (float2(ase_worldPos.x , ase_worldPos.z));
			half Input_MotionScale321_g81031 = _MotionScale_32;
			half Input_MotionVariation330_g81031 = _MotionVariation_32;
			half Input_GlobalVariation372_g81031 = Global_MeshVariation5104_g80954;
			half Input_MotionSpeed62_g81031 = _MotionSpeed_32;
			half Global_Speed350_g81031 = TVE_FlutterParams.y;
			float4 tex2DNode460_g81031 = SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( ( appendResult461_g81031 * Input_MotionScale321_g81031 * 0.03 ) + ( Input_MotionVariation330_g81031 * Input_GlobalVariation372_g81031 ) + ( _Time.y * Input_MotionSpeed62_g81031 * Global_Speed350_g81031 * 0.02 ) ), 0.0 );
			float3 appendResult462_g81031 = (float3(tex2DNode460_g81031.r , tex2DNode460_g81031.g , tex2DNode460_g81031.b));
			float temp_output_7_0_g81010 = TVE_MotionFadeEnd;
			half Motion_FadeOut4005_g80954 = saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g81010 ) / ( TVE_MotionFadeStart - temp_output_7_0_g81010 ) ) );
			half Motion_30_Amplitude4960_g80954 = ( _MotionAmplitude_32 * _MotionValue_30 * Motion_FacingMask5214_g80954 * Motion_FadeOut4005_g80954 );
			half Input_MotionAmplitude58_g81031 = Motion_30_Amplitude4960_g80954;
			half Global_Power354_g81031 = TVE_FlutterParams.x;
			half Mesh_Motion_30144_g80954 = break61_g81024.y;
			half Input_MeshMotion_30374_g81031 = Mesh_Motion_30144_g80954;
			half Input_GlobalWind471_g81031 = Global_Motion_WindPower2223_g80954;
			float temp_output_479_0_g81031 = ( 1.0 - Input_GlobalWind471_g81031 );
			half Input_GlobalNoise472_g81031 = Global_Noise_B5526_g80954;
			float lerpResult466_g81031 = lerp( 2.0 , 0.6 , Input_GlobalWind471_g81031);
			half3 Motion_30_Details263_g80954 = ( (appendResult462_g81031*2.0 + -1.0) * Input_MotionAmplitude58_g81031 * Global_Power354_g81031 * Input_MeshMotion_30374_g81031 * ( 1.0 - ( temp_output_479_0_g81031 * temp_output_479_0_g81031 ) ) * pow( Input_GlobalNoise472_g81031 , lerpResult466_g81031 ) );
			float3 Vertex_Motion_Object833_g80954 = ( ( VertexPosRotationAxis50_g80956 + ( VertexPosOtherAxis82_g80956 * cos( Angle44_g80956 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g80956 ) * sin( Angle44_g80956 ) ) ) + Motion_30_Details263_g80954 );
			float3 temp_output_3474_0_g80954 = ( VertexPosition3588_g80954 - Mesh_PivotsOS2291_g80954 );
			float3 appendResult2043_g80954 = (float3(Motion_10_BendingX216_g80954 , 0.0 , Motion_10_BendingZ190_g80954));
			float3 Vertex_Motion_World1118_g80954 = ( ( ( temp_output_3474_0_g80954 + appendResult2043_g80954 ) + Motion_20_Squash4418_g80954 ) + Motion_30_Details263_g80954 );
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch4976_g80954 = Vertex_Motion_World1118_g80954;
			#else
				float3 staticSwitch4976_g80954 = ( Vertex_Motion_Object833_g80954 + ( _VertexDataMode * 0.0 ) );
			#endif
			half3 Grass_Perspective2661_g80954 = half3(0,0,0);
			float4 temp_output_94_19_g81002 = TVE_VertexCoords;
			half2 UV97_g81002 = ( (temp_output_94_19_g81002).zw + ( (temp_output_94_19_g81002).xy * (ObjectPosition4223_g80954).xz ) );
			float temp_output_84_0_g81002 = _LayerVertexValue;
			float4 lerpResult109_g81002 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g81002,temp_output_84_0_g81002), 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g81002]);
			half4 Global_Vertex_Params4173_g80954 = lerpResult109_g81002;
			half Global_VertexSize174_g80954 = saturate( Global_Vertex_Params4173_g80954.w );
			float lerpResult346_g80954 = lerp( 1.0 , Global_VertexSize174_g80954 , _GlobalSize);
			float3 appendResult3480_g80954 = (float3(lerpResult346_g80954 , lerpResult346_g80954 , lerpResult346_g80954));
			half3 ObjectData20_g80977 = appendResult3480_g80954;
			half3 _Vector11 = half3(1,1,1);
			half3 WorldData19_g80977 = _Vector11;
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g80977 = WorldData19_g80977;
			#else
				float3 staticSwitch14_g80977 = ObjectData20_g80977;
			#endif
			half3 Vertex_Size1741_g80954 = staticSwitch14_g80977;
			half3 _Vector5 = half3(1,1,1);
			float3 Vertex_SizeFade1740_g80954 = _Vector5;
			float3 lerpResult16_g80976 = lerp( VertexPosition3588_g80954 , ( ( ( staticSwitch4976_g80954 + Grass_Perspective2661_g80954 ) * Vertex_Size1741_g80954 * Vertex_SizeFade1740_g80954 ) + Mesh_PivotsOS2291_g80954 ) , TVE_Enabled);
			float3 Final_VertexPosition890_g80954 = ( lerpResult16_g80976 + _DisableSRPBatcher );
			v.vertex.xyz = Final_VertexPosition890_g80954;
			v.vertex.w = 1;
			float temp_output_7_0_g80975 = _GradientMinValue;
			half Gradient_Tint2784_g80954 = saturate( ( ( Mesh_Height1524_g80954 - temp_output_7_0_g80975 ) / ( _GradientMaxValue - temp_output_7_0_g80975 ) ) );
			o.vertexToFrag11_g80979 = Gradient_Tint2784_g80954;
			float Mesh_Occlusion318_g80954 = v.color.g;
			float temp_output_7_0_g80973 = _VertexOcclusionMinValue;
			float temp_output_3377_0_g80954 = saturate( ( ( Mesh_Occlusion318_g80954 - temp_output_7_0_g80973 ) / ( _VertexOcclusionMaxValue - temp_output_7_0_g80973 ) ) );
			o.vertexToFrag11_g80968 = temp_output_3377_0_g80954;
			o.vertexToFrag3890_g80954 = ase_worldPos;
			o.vertexToFrag4224_g80954 = temp_output_114_0_g81011;
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			o.vertexToFrag5058_g80954 = ase_worldNormal;
			float temp_output_7_0_g80986 = TVE_CameraFadeStart;
			float lerpResult4755_g80954 = lerp( 1.0 , saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g80986 ) / ( TVE_CameraFadeEnd - temp_output_7_0_g80986 ) ) ) , _FadeCameraValue);
			o.vertexToFrag11_g81006 = lerpResult4755_g80954;
		}

		inline half4 LightingStandardSpecularCustom(SurfaceOutputStandardSpecularCustom s, half3 viewDir, UnityGI gi )
		{
			#if !defined(DIRECTIONAL)
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			SurfaceOutputStandardSpecular r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Specular = s.Specular;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandardSpecular (r, viewDir, gi) + c;
		}

		inline void LightingStandardSpecularCustom_GI(SurfaceOutputStandardSpecularCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardSpecularCustom o )
		{
			half2 Main_UVs15_g80954 = ( ( i.uv_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
			half3 Main_Normal137_g80954 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _MainNormalTex, sampler_Linear_Repeat, Main_UVs15_g80954 ), _MainNormalValue );
			float3 temp_output_13_0_g80955 = Main_Normal137_g80954;
			float3 switchResult12_g80955 = (((i.ASEIsFrontFacing>0)?(temp_output_13_0_g80955):(( temp_output_13_0_g80955 * _render_normals ))));
			half3 Blend_Normal312_g80954 = switchResult12_g80955;
			half3 Final_Normal366_g80954 = Blend_Normal312_g80954;
			o.Normal = Final_Normal366_g80954;
			float3 lerpResult2779_g80954 = lerp( (_GradientColorTwo).rgb , (_GradientColorOne).rgb , i.vertexToFrag11_g80979);
			float4 tex2DNode29_g80954 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g80954 );
			half3 Main_Albedo99_g80954 = ( (_MainColor).rgb * (tex2DNode29_g80954).rgb );
			half3 Blend_Albedo265_g80954 = Main_Albedo99_g80954;
			float3 temp_cast_1 = (1.0).xxx;
			float3 lerpResult2945_g80954 = lerp( (_VertexOcclusionColor).rgb , temp_cast_1 , i.vertexToFrag11_g80968);
			float3 Vertex_Occlusion648_g80954 = lerpResult2945_g80954;
			half3 Blend_AlbedoTinted2808_g80954 = ( ( lerpResult2779_g80954 * float3(1,1,1) * float3(1,1,1) ) * Blend_Albedo265_g80954 * Vertex_Occlusion648_g80954 );
			float dotResult3616_g80954 = dot( Blend_AlbedoTinted2808_g80954 , float3(0.2126,0.7152,0.0722) );
			float3 temp_cast_2 = (dotResult3616_g80954).xxx;
			float4 temp_output_91_19_g80992 = TVE_ColorsCoords;
			float3 WorldPosition3905_g80954 = i.vertexToFrag3890_g80954;
			half3 ObjectData20_g81008 = i.vertexToFrag4224_g80954;
			half3 WorldData19_g81008 = i.vertexToFrag3890_g80954;
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g81008 = WorldData19_g81008;
			#else
				float3 staticSwitch14_g81008 = ObjectData20_g81008;
			#endif
			float3 ObjectPosition4223_g80954 = staticSwitch14_g81008;
			float3 lerpResult4822_g80954 = lerp( WorldPosition3905_g80954 , ObjectPosition4223_g80954 , _ColorsPositionMode);
			half2 UV94_g80992 = ( (temp_output_91_19_g80992).zw + ( (temp_output_91_19_g80992).xy * (lerpResult4822_g80954).xz ) );
			float temp_output_82_0_g80992 = _LayerColorsValue;
			float4 lerpResult108_g80992 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g80992,temp_output_82_0_g80992), 0.0 ) , TVE_ColorsUsage[(int)temp_output_82_0_g80992]);
			half4 Global_Colors_Params5434_g80954 = lerpResult108_g80992;
			float4 temp_output_346_0_g80966 = Global_Colors_Params5434_g80954;
			half Global_Colors_A1701_g80954 = saturate( (temp_output_346_0_g80966).w );
			half Global_Colors_Influence3668_g80954 = Global_Colors_A1701_g80954;
			float3 lerpResult3618_g80954 = lerp( Blend_AlbedoTinted2808_g80954 , temp_cast_2 , Global_Colors_Influence3668_g80954);
			half3 Global_Colors_RGB1700_g80954 = (temp_output_346_0_g80966).xyz;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g80967 = 2.0;
			#else
				float staticSwitch1_g80967 = 4.594794;
			#endif
			half3 Global_Colors1954_g80954 = ( Global_Colors_RGB1700_g80954 * staticSwitch1_g80967 );
			float3 break111_g81018 = ObjectPosition4223_g80954;
			half Global_DynamicMode5112_g80954 = _VertexDynamicMode;
			half Input_DynamicMode120_g81018 = Global_DynamicMode5112_g80954;
			float Mesh_Variation16_g80954 = i.vertexColor.r;
			half Input_Variation124_g81018 = Mesh_Variation16_g80954;
			half ObjectData20_g81019 = frac( ( ( ( break111_g81018.x + break111_g81018.y + break111_g81018.z + 0.001275 ) * ( 1.0 - Input_DynamicMode120_g81018 ) ) + Input_Variation124_g81018 ) );
			half WorldData19_g81019 = Input_Variation124_g81018;
			#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g81019 = WorldData19_g81019;
			#else
				float staticSwitch14_g81019 = ObjectData20_g81019;
			#endif
			float clampResult129_g81018 = clamp( staticSwitch14_g81019 , 0.01 , 0.99 );
			half Global_MeshVariation5104_g80954 = clampResult129_g81018;
			float lerpResult3870_g80954 = lerp( 1.0 , ( Global_MeshVariation5104_g80954 * Global_MeshVariation5104_g80954 ) , _ColorsVariationValue);
			half Global_Colors_Value3650_g80954 = ( _GlobalColors * lerpResult3870_g80954 );
			float4 tex2DNode35_g80954 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_Linear_Repeat, Main_UVs15_g80954 );
			half Main_Mask57_g80954 = tex2DNode35_g80954.b;
			float clampResult5405_g80954 = clamp( Main_Mask57_g80954 , 0.01 , 0.99 );
			float temp_output_7_0_g80985 = _ColorsMaskMinValue;
			half Global_Colors_Mask3692_g80954 = saturate( ( ( clampResult5405_g80954 - temp_output_7_0_g80985 ) / ( _ColorsMaskMaxValue - temp_output_7_0_g80985 ) ) );
			float lerpResult16_g80982 = lerp( 0.0 , ( Global_Colors_Value3650_g80954 * Global_Colors_Mask3692_g80954 ) , TVE_Enabled);
			float3 lerpResult3628_g80954 = lerp( Blend_AlbedoTinted2808_g80954 , ( lerpResult3618_g80954 * Global_Colors1954_g80954 ) , lerpResult16_g80982);
			half3 Blend_AlbedoColored863_g80954 = lerpResult3628_g80954;
			half3 Blend_AlbedoAndSubsurface149_g80954 = Blend_AlbedoColored863_g80954;
			half3 Global_OverlayColor1758_g80954 = (TVE_OverlayColor).rgb;
			half3 World_Normal4101_g80954 = i.vertexToFrag5058_g80954;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			float lerpResult4801_g80954 = lerp( World_Normal4101_g80954.y , ase_vertexNormal.y , Global_DynamicMode5112_g80954);
			float lerpResult3567_g80954 = lerp( 0.5 , 1.0 , lerpResult4801_g80954);
			float4 temp_output_93_19_g80988 = TVE_ExtrasCoords;
			float3 lerpResult4827_g80954 = lerp( WorldPosition3905_g80954 , ObjectPosition4223_g80954 , _ExtrasPositionMode);
			half2 UV96_g80988 = ( (temp_output_93_19_g80988).zw + ( (temp_output_93_19_g80988).xy * (lerpResult4827_g80954).xz ) );
			float temp_output_84_0_g80988 = _LayerExtrasValue;
			float4 lerpResult109_g80988 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g80988,temp_output_84_0_g80988), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g80988]);
			half4 Global_Extras_Params5440_g80954 = lerpResult109_g80988;
			float4 break456_g80965 = Global_Extras_Params5440_g80954;
			half Global_Extras_Overlay156_g80954 = break456_g80965.z;
			float lerpResult1065_g80954 = lerp( 1.0 , Global_MeshVariation5104_g80954 , _OverlayVariationValue);
			half Overlay_Variation4560_g80954 = lerpResult1065_g80954;
			half Overlay_Commons1365_g80954 = ( _GlobalOverlay * Global_Extras_Overlay156_g80954 * Overlay_Variation4560_g80954 );
			half Overlay_Mask_3D5122_g80954 = ( ( ( lerpResult3567_g80954 * 0.5 ) + Blend_Albedo265_g80954.y ) * Overlay_Commons1365_g80954 );
			float temp_output_7_0_g80978 = _OverlayMaskMinValue;
			half Overlay_Mask269_g80954 = saturate( ( ( Overlay_Mask_3D5122_g80954 - temp_output_7_0_g80978 ) / ( _OverlayMaskMaxValue - temp_output_7_0_g80978 ) ) );
			float3 lerpResult336_g80954 = lerp( Blend_AlbedoAndSubsurface149_g80954 , Global_OverlayColor1758_g80954 , Overlay_Mask269_g80954);
			half3 Final_Albedo359_g80954 = lerpResult336_g80954;
			o.Albedo = Final_Albedo359_g80954;
			float4 temp_output_4214_0_g80954 = ( _EmissiveColor * _EmissiveIntensityParams.x );
			half2 Emissive_UVs2468_g80954 = ( ( i.uv_texcoord.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
			half Global_Extras_Emissive4203_g80954 = break456_g80965.x;
			float lerpResult4206_g80954 = lerp( 1.0 , Global_Extras_Emissive4203_g80954 , _GlobalEmissive);
			half3 Final_Emissive2476_g80954 = ( (( temp_output_4214_0_g80954 * SAMPLE_TEXTURE2D( _EmissiveTex, sampler_Linear_Repeat, Emissive_UVs2468_g80954 ) )).rgb * lerpResult4206_g80954 );
			o.Emission = Final_Emissive2476_g80954;
			half Render_Specular4861_g80954 = _RenderSpecular;
			float3 temp_cast_9 = (( 0.04 * Render_Specular4861_g80954 )).xxx;
			o.Specular = temp_cast_9;
			half Main_Smoothness227_g80954 = ( tex2DNode35_g80954.a * _MainSmoothnessValue );
			half Blend_Smoothness314_g80954 = Main_Smoothness227_g80954;
			half Global_OverlaySmoothness311_g80954 = TVE_OverlaySmoothness;
			float lerpResult343_g80954 = lerp( Blend_Smoothness314_g80954 , Global_OverlaySmoothness311_g80954 , Overlay_Mask269_g80954);
			half Final_Smoothness371_g80954 = lerpResult343_g80954;
			half Global_Extras_Wetness305_g80954 = break456_g80965.y;
			float lerpResult3673_g80954 = lerp( 0.0 , Global_Extras_Wetness305_g80954 , _GlobalWetness);
			half Final_SmoothnessAndWetness4130_g80954 = saturate( ( Final_Smoothness371_g80954 + lerpResult3673_g80954 ) );
			o.Smoothness = Final_SmoothnessAndWetness4130_g80954;
			float lerpResult240_g80954 = lerp( 1.0 , tex2DNode35_g80954.g , _MainOcclusionValue);
			half Main_Occlusion247_g80954 = lerpResult240_g80954;
			half Blend_Occlusion323_g80954 = Main_Occlusion247_g80954;
			o.Occlusion = Blend_Occlusion323_g80954;
			half3 Subsurface_Color1722_g80954 = ( (_SubsurfaceColor).rgb * Blend_AlbedoColored863_g80954 );
			half Global_Subsurface4041_g80954 = TVE_SubsurfaceValue;
			half Subsurface_Intensity1752_g80954 = ( _SubsurfaceValue * Global_Subsurface4041_g80954 );
			float temp_output_7_0_g80984 = _SubsurfaceMaskMinValue;
			half Subsurface_Mask1557_g80954 = saturate( ( ( Main_Mask57_g80954 - temp_output_7_0_g80984 ) / ( _SubsurfaceMaskMaxValue - temp_output_7_0_g80984 ) ) );
			half3 Subsurface_Translucency884_g80954 = ( Subsurface_Color1722_g80954 * Subsurface_Intensity1752_g80954 * Subsurface_Mask1557_g80954 * 10.0 );
			o.Translucency = Subsurface_Translucency884_g80954;
			float localCustomAlphaClip19_g81029 = ( 0.0 );
			float Main_Alpha316_g80954 = ( _MainColor.a * tex2DNode29_g80954.a );
			half Global_Extras_Alpha1033_g80954 = saturate( break456_g80965.w );
			float lerpResult5154_g80954 = lerp( 0.1 , Global_MeshVariation5104_g80954 , _AlphaVariationValue);
			half Global_Alpha_Variation5158_g80954 = lerpResult5154_g80954;
			half Global_Alpha_Mask4546_g80954 = 1.0;
			float lerpResult5203_g80954 = lerp( 1.0 , ( ( Global_Extras_Alpha1033_g80954 - Global_Alpha_Variation5158_g80954 ) + ( Global_Extras_Alpha1033_g80954 * 0.5 ) ) , ( Global_Alpha_Mask4546_g80954 * _GlobalAlpha ));
			half AlphaTreshold2132_g80954 = _AlphaClipValue;
			float lerpResult16_g81027 = lerp( 1.0 , saturate( ( lerpResult5203_g80954 + AlphaTreshold2132_g80954 ) ) , TVE_Enabled);
			half Global_Alpha315_g80954 = lerpResult16_g81027;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult2169_g80954 = normalize( ase_worldViewDir );
			float3 ViewDir_Normalized3963_g80954 = normalizeResult2169_g80954;
			float3 normalizeResult3971_g80954 = normalize( cross( ddy( ase_worldPos ) , ddx( ase_worldPos ) ) );
			float3 NormalsWS_Derivates3972_g80954 = normalizeResult3971_g80954;
			float dotResult3851_g80954 = dot( ViewDir_Normalized3963_g80954 , NormalsWS_Derivates3972_g80954 );
			float lerpResult3993_g80954 = lerp( 1.0 , saturate( abs( dotResult3851_g80954 ) ) , _FadeGlancingValue);
			half Fade_Glancing3853_g80954 = lerpResult3993_g80954;
			half Fade_Camera3743_g80954 = i.vertexToFrag11_g81006;
			half Fade_Mask5149_g80954 = 1.0;
			float lerpResult5141_g80954 = lerp( 1.0 , ( Fade_Glancing3853_g80954 * Fade_Camera3743_g80954 ) , Fade_Mask5149_g80954);
			half Fade_Effects5360_g80954 = lerpResult5141_g80954;
			float temp_output_41_0_g81025 = Fade_Effects5360_g80954;
			float temp_output_5361_0_g80954 = ( saturate( ( temp_output_41_0_g81025 + ( temp_output_41_0_g81025 * SAMPLE_TEXTURE3D( TVE_ScreenTex3D, sampler_Linear_Repeat, ( TVE_ScreenTexCoord * WorldPosition3905_g80954 ) ).r ) ) ) + -0.5 + AlphaTreshold2132_g80954 );
			half Fade_Alpha3727_g80954 = temp_output_5361_0_g80954;
			float temp_output_661_0_g80954 = ( Main_Alpha316_g80954 * Global_Alpha315_g80954 * Fade_Alpha3727_g80954 );
			half Alpha34_g81028 = temp_output_661_0_g80954;
			half Offest27_g81028 = AlphaTreshold2132_g80954;
			half AlphaFeather5305_g80954 = _AlphaFeatherValue;
			half Feather30_g81028 = AlphaFeather5305_g80954;
			float temp_output_25_0_g81028 = ( ( ( Alpha34_g81028 - Offest27_g81028 ) / ( max( fwidth( Alpha34_g81028 ) , 0.001 ) + Feather30_g81028 ) ) + Offest27_g81028 );
			float temp_output_3_0_g81029 = temp_output_25_0_g81028;
			float Alpha19_g81029 = temp_output_3_0_g81029;
			float temp_output_15_0_g81029 = AlphaTreshold2132_g80954;
			float Treshold19_g81029 = temp_output_15_0_g81029;
			{
			#if defined (TVE_FEATURE_CLIP)
			#if defined (TVE_IS_HD_PIPELINE)
				#if !defined (SHADERPASS_FORWARD_BYPASS_ALPHA_TEST)
					clip(Alpha19_g81029 - Treshold19_g81029);
				#endif
				#if !defined (SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
					clip(Alpha19_g81029 - Treshold19_g81029);
				#endif
			#else
				clip(Alpha19_g81029 - Treshold19_g81029);
			#endif
			#endif
			}
			half Final_Alpha914_g80954 = saturate( Alpha19_g81029 );
			o.Alpha = Final_Alpha914_g80954;
		}

		ENDCG
	}
	Fallback "Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=19100
Node;AmplifyShaderEditor.RangedFloatNode;1355;-1408,-640;Half;False;Property;_render_coverage;_render_coverage;212;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1808,-640;Half;False;Property;_render_dst;_render_dst;210;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1632,-640;Half;False;Property;_render_zw;_render_zw;211;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1081;-1856,512;Inherit;False;Define Pipeline Standard;-1;;67546;9af03ae8defe78d448ef2a4ef3601e12;0;0;1;FLOAT;529
Node;AmplifyShaderEditor.RangedFloatNode;20;-2000,-640;Half;False;Property;_render_src;_render_src;209;1;[HideInInspector];Create;True;0;0;0;True;0;False;5;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;168;-2176,-768;Half;False;Property;_IsLeafShader;_IsLeafShader;206;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1088;-1536,-768;Inherit;False;Compile Core;-1;;67548;634b02fd1f32e6a4c875d8fc2c450956;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2176,-640;Half;False;Property;_render_cull;_render_cull;208;1;[HideInInspector];Create;True;0;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;471;-2176,512;Inherit;False;Define Shader Vegetation;-1;;67549;b458122dd75182d488380bd0f592b9e6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;822;-1984,-768;Half;False;Property;_IsSubsurfaceShader;_IsSubsurfaceShader;207;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1087;-1344,-768;Inherit;False;Compile All Shaders;-1;;67550;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1032;-1376,-256;Float;False;True;-1;5;TVEShaderCoreGUI;0;0;StandardSpecular;BOXOPHOBIC/The Vegetation Engine/Default/Leaf Subsurface Lit;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;Back;0;True;_render_zw;0;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;True;0;True;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;1;0;True;_render_src;0;True;_render_dst;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback;213;199;-1;-1;0;True;0;0;True;_render_cull;-1;0;False;;0;0;0;False;0.1;False;;0;True;_render_coverage;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;449;-2176,384;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-896;Inherit;False;1024.392;100;Internal;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2194,-384;Inherit;False;1042.392;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.FunctionNode;1529;-2176,-258;Inherit;False;Base Shader;0;;80954;856f7164d1c579d43a5cf4968a75ca43;79,3880,1,4028,1,3900,1,3908,1,4172,1,1300,1,1298,1,4995,1,4179,1,3586,0,4499,1,1708,1,3509,1,5151,1,3873,1,893,1,5196,0,5128,1,5156,1,5345,0,5075,1,1717,1,1715,1,1718,1,1714,1,916,1,1763,0,1762,0,3568,1,5118,1,1776,1,3475,1,4210,1,1745,1,3479,0,3501,1,5152,1,1646,0,1271,1,3889,0,2807,1,3886,0,4999,0,3887,0,3957,1,5357,0,2172,1,3883,0,3728,1,3949,0,5147,0,5146,1,5350,0,2658,0,1742,0,3484,0,5079,0,1736,0,1733,0,4837,0,1737,0,1734,0,1735,0,1550,0,878,0,860,1,2260,1,2261,1,2032,1,2054,1,5258,1,2062,1,2039,1,3243,0,5220,1,4217,1,5090,1,4242,1,5339,0;6;5115;FLOAT;1;False;5127;FLOAT;1;False;5143;FLOAT;1;False;5119;FLOAT;1;False;5117;FLOAT;1;False;5340;FLOAT3;0,0,0;False;23;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;531;FLOAT;4842;FLOAT;529;FLOAT;3678;FLOAT;530;FLOAT;4122;FLOAT;4134;FLOAT;1235;FLOAT;532;FLOAT;5389;FLOAT;721;FLOAT3;1230;FLOAT;5296;FLOAT;1461;FLOAT;1290;FLOAT;629;FLOAT3;534;FLOAT;4867;FLOAT4;5246;FLOAT4;4841
WireConnection;1032;0;1529;0
WireConnection;1032;1;1529;528
WireConnection;1032;2;1529;2489
WireConnection;1032;3;1529;3678
WireConnection;1032;4;1529;530
WireConnection;1032;5;1529;531
WireConnection;1032;7;1529;1230
WireConnection;1032;9;1529;532
WireConnection;1032;11;1529;534
ASEEND*/
//CHKSM=91E1D16F13D28D355526E29A79DFD0BE66A1E319
