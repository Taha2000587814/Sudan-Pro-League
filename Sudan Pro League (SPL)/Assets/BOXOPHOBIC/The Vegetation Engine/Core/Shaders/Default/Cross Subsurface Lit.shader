// Made with Amplify Shader Editor v1.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Default/Cross Subsurface Lit"
{
	Properties
	{
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
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
		_FadeVerticalValue("Fade by Vertical Angle", Range( 0 , 1)) = 0
		_FadeHorizontalValue("Fade by Horizontal Angle", Range( 0 , 1)) = 0
		[StyledCategory(Global Settings)]_CategoryGlobal("[ Category Global ]", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerColorsValue("Layer Colors", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerExtrasValue("Layer Extras", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerMotionValue("Layer Motion", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerVertexValue("Layer Vertex", Float) = 0
		[StyledSpace(10)]_SpaceGlobalLayers("# Space Global Layers", Float) = 0
		[StyledMessage(Info, Procedural Variation in use. The Variation might not work as expected when switching from one LOD to another., _VertexVariationMode, 1 , 0, 10)]_MessageGlobalsVariation("# Message Globals Variation", Float) = 0
		_GlobalOverlay("Global Overlay", Range( 0 , 1)) = 1
		_GlobalWetness("Global Wetness", Range( 0 , 1)) = 1
		_GlobalEmissive("Global Emissive", Range( 0 , 1)) = 1
		_GlobalSize("Global Size Fade", Range( 0 , 1)) = 1
		[StyledSpace(10)]_SpaceGlobalLocals("# Space Global Locals", Float) = 0
		[StyledRemapSlider(_ColorsMaskMinValue, _ColorsMaskMaxValue, 0, 1)]_ColorsMaskRemap("Color Mask", Vector) = (0,0,0,0)
		[HideInInspector]_ColorsMaskMinValue("Color Mask Min Value", Range( 0 , 1)) = 0
		[HideInInspector]_ColorsMaskMaxValue("Color Mask Max Value", Range( 0 , 1)) = 0
		[StyledRemapSlider(_AlphaMaskMinValue, _AlphaMaskMaxValue, 0, 1, 10, 0)]_AlphaMaskRemap("Alpha Mask", Vector) = (0,0,0,0)
		[StyledRemapSlider(_OverlayMaskMinValue, _OverlayMaskMaxValue, 0, 1)]_OverlayMaskRemap("Overlay Mask", Vector) = (0,0,0,0)
		[HideInInspector]_OverlayMaskMinValue("Overlay Mask Min Value", Range( 0 , 1)) = 0.45
		[HideInInspector]_OverlayMaskMaxValue("Overlay Mask Max Value", Range( 0 , 1)) = 0.55
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
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[StyledRemapSlider(_VertexOcclusionMinValue, _VertexOcclusionMaxValue, 0, 1)]_VertexOcclusionRemap("Vertex Occlusion Mask", Vector) = (0,0,0,0)
		[StyledCategory(Subsurface Settings)]_CategorySubsurface("[ Category Subsurface ]", Float) = 0
		_SubsurfaceValue("Subsurface Intensity", Range( 0 , 1)) = 1
		[HDR]_SubsurfaceColor("Subsurface Color", Color) = (0.4,0.4,0.1,1)
		[StyledRemapSlider(_SubsurfaceMaskMinValue, _SubsurfaceMaskMaxValue,0,1)]_SubsurfaceMaskRemap("Subsurface Mask", Vector) = (0,0,0,0)
		[HideInInspector]_SubsurfaceMaskMinValue("Subsurface Mask Min Value", Range( 0 , 1)) = 0
		[HideInInspector]_SubsurfaceMaskMaxValue("Subsurface Mask Max Value", Range( 0 , 1)) = 1
		[Space(10)][DiffusionProfile]_SubsurfaceDiffusion("Subsurface Diffusion", Float) = 0
		[HideInInspector]_SubsurfaceDiffusion_Asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[HideInInspector][Space(10)][ASEDiffusionProfile(_SubsurfaceDiffusion)]_SubsurfaceDiffusion_asset("Subsurface Diffusion", Vector) = (0,0,0,0)
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
		[StyledSpace(10)]_SpaceMotionGlobals("# SpaceMotionGlobals", Float) = 0
		_MotionAmplitude_10("Motion Bending", Range( 0 , 2)) = 0.2
		[IntRange]_MotionSpeed_10("Motion Speed", Range( 0 , 40)) = 2
		_MotionScale_10("Motion Scale", Range( 0 , 20)) = 0
		_MotionVariation_10("Motion Variation", Range( 0 , 20)) = 0
		[Space(10)]_InteractionAmplitude("Interaction Amplitude", Range( 0 , 2)) = 1
		_InteractionMaskValue("Interaction Use Mask", Range( 0 , 1)) = 1
		[StyledSpace(10)]_SpaceMotionLocals("# SpaceMotionLocals", Float) = 0
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
		[HideInInspector]_IsSubsurfaceShader("_IsSubsurfaceShader", Float) = 1
		[HideInInspector]_IsCrossShader("_IsCrossShader", Float) = 1
		[HideInInspector]_render_cull("_render_cull", Float) = 0
		[HideInInspector]_render_src("_render_src", Float) = 1
		[HideInInspector]_render_dst("_render_dst", Float) = 0
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
		//TVE Shader Type Defines
		#define TVE_IS_VEGETATION_SHADER
		//TVE Pipeline Defines
		#define THE_VEGETATION_ENGINE
		#define TVE_IS_STANDARD_PIPELINE
		//TVE Injection Defines
		//SHADER INJECTION POINT BEGIN
		//SHADER INJECTION POINT END
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
			float vertexToFrag11_g74594;
			float3 vertexToFrag3890_g49638;
			float3 vertexToFrag4224_g49638;
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

		uniform half _render_src;
		uniform half _render_zw;
		uniform half _render_dst;
		uniform half _render_cull;
		uniform half _IsCrossShader;
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
		uniform half _render_coverage;
		UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_NoiseTex);
		uniform float _MotionScale_10;
		uniform half4 TVE_NoiseParams;
		uniform half4 TVE_MotionParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
		uniform half4 TVE_MotionCoords;
		uniform half _VertexPivotMode;
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
		uniform half4 TVE_ColorsParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
		uniform half4 TVE_ColorsCoords;
		uniform half _ColorsPositionMode;
		uniform half _LayerColorsValue;
		uniform float TVE_ColorsUsage[10];
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
		uniform half _FadeHorizontalValue;
		uniform half _FadeVerticalValue;
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
			float3 VertexPosition3588_g49638 = ase_vertex3Pos;
			half3 Mesh_PivotsOS2291_g49638 = half3(0,0,0);
			float3 temp_output_2283_0_g49638 = ( VertexPosition3588_g49638 - Mesh_PivotsOS2291_g49638 );
			half3 VertexPos40_g74554 = temp_output_2283_0_g49638;
			float3 appendResult74_g74554 = (float3(VertexPos40_g74554.x , 0.0 , 0.0));
			half3 VertexPosRotationAxis50_g74554 = appendResult74_g74554;
			float3 break84_g74554 = VertexPos40_g74554;
			float3 appendResult81_g74554 = (float3(0.0 , break84_g74554.y , break84_g74554.z));
			half3 VertexPosOtherAxis82_g74554 = appendResult81_g74554;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 vertexToFrag3890_g49638 = ase_worldPos;
			float3 WorldPosition3905_g49638 = vertexToFrag3890_g49638;
			half3 Input_Position419_g75124 = WorldPosition3905_g49638;
			float Input_MotionScale287_g75124 = ( _MotionScale_10 + 0.2 );
			half Global_Scale448_g75124 = TVE_NoiseParams.x;
			float2 temp_output_597_0_g75124 = (( Input_Position419_g75124 * Input_MotionScale287_g75124 * Global_Scale448_g75124 * 0.0075 )).xz;
			float4 temp_output_91_19_g74616 = TVE_MotionCoords;
			float4x4 break19_g74703 = unity_ObjectToWorld;
			float3 appendResult20_g74703 = (float3(break19_g74703[ 0 ][ 3 ] , break19_g74703[ 1 ][ 3 ] , break19_g74703[ 2 ][ 3 ]));
			float3 appendResult60_g74709 = (float3(v.texcoord3.x , v.texcoord3.z , v.texcoord3.y));
			half3 Mesh_PivotsData2831_g49638 = ( appendResult60_g74709 * _VertexPivotMode );
			float3 temp_output_122_0_g74703 = Mesh_PivotsData2831_g49638;
			float3 PivotsOnly105_g74703 = (mul( unity_ObjectToWorld, float4( temp_output_122_0_g74703 , 0.0 ) ).xyz).xyz;
			half3 ObjectData20_g74704 = ( appendResult20_g74703 + PivotsOnly105_g74703 );
			half3 WorldData19_g74704 = ase_worldPos;
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74704 = WorldData19_g74704;
			#else
				float3 staticSwitch14_g74704 = ObjectData20_g74704;
			#endif
			float3 temp_output_114_0_g74703 = staticSwitch14_g74704;
			float3 vertexToFrag4224_g49638 = temp_output_114_0_g74703;
			half3 ObjectData20_g74630 = vertexToFrag4224_g49638;
			half3 WorldData19_g74630 = vertexToFrag3890_g49638;
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
			#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
			#endif
			float3 ObjectPosition4223_g49638 = staticSwitch14_g74630;
			half2 UV94_g74616 = ( (temp_output_91_19_g74616).zw + ( (temp_output_91_19_g74616).xy * (ObjectPosition4223_g49638).xz ) );
			float temp_output_84_0_g74616 = _LayerMotionValue;
			float4 lerpResult107_g74616 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g74616,temp_output_84_0_g74616), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g74616]);
			half4 Global_Motion_Params3909_g49638 = lerpResult107_g74616;
			float4 break322_g75190 = Global_Motion_Params3909_g49638;
			float2 appendResult433_g75190 = (float2(break322_g75190.x , break322_g75190.y));
			float2 temp_output_436_0_g75190 = (appendResult433_g75190*2.0 + -1.0);
			half2 Global_Motion_DirectionWS4683_g49638 = temp_output_436_0_g75190;
			half2 Input_DirectionWS423_g75124 = Global_Motion_DirectionWS4683_g49638;
			half Input_MotionSpeed62_g75124 = _MotionSpeed_10;
			half Global_Speed449_g75124 = TVE_NoiseParams.y;
			half Input_MotionVariation284_g75124 = _MotionVariation_10;
			float3 break111_g74710 = ObjectPosition4223_g49638;
			half Global_DynamicMode5112_g49638 = _VertexDynamicMode;
			half Input_DynamicMode120_g74710 = Global_DynamicMode5112_g49638;
			float Mesh_Variation16_g49638 = v.color.r;
			half Input_Variation124_g74710 = Mesh_Variation16_g49638;
			half ObjectData20_g74711 = frac( ( ( ( break111_g74710.x + break111_g74710.y + break111_g74710.z + 0.001275 ) * ( 1.0 - Input_DynamicMode120_g74710 ) ) + Input_Variation124_g74710 ) );
			half WorldData19_g74711 = Input_Variation124_g74710;
			#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g74711 = WorldData19_g74711;
			#else
				float staticSwitch14_g74711 = ObjectData20_g74711;
			#endif
			float clampResult129_g74710 = clamp( staticSwitch14_g74711 , 0.01 , 0.99 );
			half Global_MeshVariation5104_g49638 = clampResult129_g74710;
			half Input_GlobalVariation569_g75124 = Global_MeshVariation5104_g49638;
			float temp_output_630_0_g75124 = ( ( ( _Time.y * Input_MotionSpeed62_g75124 * Global_Speed449_g75124 ) + ( Input_MotionVariation284_g75124 * Input_GlobalVariation569_g75124 ) ) * 0.03 );
			float temp_output_607_0_g75124 = frac( temp_output_630_0_g75124 );
			float4 lerpResult590_g75124 = lerp( SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75124 + ( -Input_DirectionWS423_g75124 * temp_output_607_0_g75124 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75124 + ( -Input_DirectionWS423_g75124 * frac( ( temp_output_630_0_g75124 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_607_0_g75124 - 0.5 ) ) / 0.5 ));
			half2 Global_Noise_X5548_g49638 = ((lerpResult590_g75124).rg*2.0 + -1.0);
			half2 Input_NoiseWS487_g75201 = Global_Noise_X5548_g49638;
			float2 break441_g75190 = temp_output_436_0_g75190;
			float3 appendResult440_g75190 = (float3(break441_g75190.x , 0.0 , break441_g75190.y));
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			half2 Global_Motion_DirectionOS39_g49638 = (( mul( unity_WorldToObject, float4( appendResult440_g75190 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
			half2 Input_DirectionOS358_g75201 = Global_Motion_DirectionOS39_g49638;
			half Global_Motion_WindPower2223_g49638 = break322_g75190.z;
			half Input_GlobalWind449_g75201 = Global_Motion_WindPower2223_g49638;
			float temp_output_565_0_g75201 = ( 1.0 - Input_GlobalWind449_g75201 );
			float2 lerpResult516_g75201 = lerp( Input_NoiseWS487_g75201 , Input_DirectionOS358_g75201 , ( ( 1.0 - ( temp_output_565_0_g75201 * temp_output_565_0_g75201 ) ) * 0.6 ));
			half Mesh_Height1524_g49638 = v.color.a;
			half Input_MeshHeight388_g75201 = Mesh_Height1524_g49638;
			half ObjectData20_g75202 = ( Input_MeshHeight388_g75201 * 2.0 );
			float enc62_g74968 = v.texcoord.w;
			float2 localDecodeFloatToVector262_g74968 = DecodeFloatToVector2( enc62_g74968 );
			float2 break63_g74968 = ( localDecodeFloatToVector262_g74968 * 100.0 );
			float Bounds_Height5230_g49638 = break63_g74968.x;
			half Input_BoundsHeight390_g75201 = Bounds_Height5230_g49638;
			half WorldData19_g75202 = ( ( Input_MeshHeight388_g75201 * Input_MeshHeight388_g75201 ) * Input_BoundsHeight390_g75201 * 2.0 );
			#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75202 = WorldData19_g75202;
			#else
				float staticSwitch14_g75202 = ObjectData20_g75202;
			#endif
			half Final_Motion_10_Amplitude321_g75201 = staticSwitch14_g75202;
			half Motion_10_Amplitude2258_g49638 = _MotionAmplitude_10;
			half Input_BendingAmplitude376_g75201 = Motion_10_Amplitude2258_g49638;
			half Input_InteractionAmplitude58_g75201 = _InteractionAmplitude;
			half Input_InteractionUseMask62_g75201 = _InteractionMaskValue;
			float lerpResult371_g75201 = lerp( 2.0 , Final_Motion_10_Amplitude321_g75201 , Input_InteractionUseMask62_g75201);
			half ObjectData20_g75203 = lerpResult371_g75201;
			half WorldData19_g75203 = Final_Motion_10_Amplitude321_g75201;
			#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75203 = WorldData19_g75203;
			#else
				float staticSwitch14_g75203 = ObjectData20_g75203;
			#endif
			half Final_InteractionAmplitude373_g75201 = ( Input_InteractionAmplitude58_g75201 * staticSwitch14_g75203 );
			half Global_InteractionMask66_g49638 = ( break322_g75190.w * break322_g75190.w );
			float Input_InteractionGlobalMask330_g75201 = Global_InteractionMask66_g49638;
			half Final_InteractionMask525_g75201 = saturate( ( Input_InteractionAmplitude58_g75201 * Input_InteractionGlobalMask330_g75201 ) );
			float2 lerpResult551_g75201 = lerp( ( lerpResult516_g75201 * ( Final_Motion_10_Amplitude321_g75201 * Input_BendingAmplitude376_g75201 * Input_GlobalWind449_g75201 ) ) , ( Input_DirectionOS358_g75201 * Final_InteractionAmplitude373_g75201 ) , Final_InteractionMask525_g75201);
			float2 break364_g75201 = lerpResult551_g75201;
			half Motion_10_BendingZ190_g49638 = break364_g75201.y;
			half Angle44_g74554 = Motion_10_BendingZ190_g49638;
			half3 VertexPos40_g74583 = ( VertexPosRotationAxis50_g74554 + ( VertexPosOtherAxis82_g74554 * cos( Angle44_g74554 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g74554 ) * sin( Angle44_g74554 ) ) );
			float3 appendResult74_g74583 = (float3(0.0 , 0.0 , VertexPos40_g74583.z));
			half3 VertexPosRotationAxis50_g74583 = appendResult74_g74583;
			float3 break84_g74583 = VertexPos40_g74583;
			float3 appendResult81_g74583 = (float3(break84_g74583.x , break84_g74583.y , 0.0));
			half3 VertexPosOtherAxis82_g74583 = appendResult81_g74583;
			half Motion_10_BendingX216_g49638 = break364_g75201.x;
			half Angle44_g74583 = -Motion_10_BendingX216_g49638;
			float3 Vertex_Motion_Object833_g49638 = ( VertexPosRotationAxis50_g74583 + ( VertexPosOtherAxis82_g74583 * cos( Angle44_g74583 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g74583 ) * sin( Angle44_g74583 ) ) );
			float3 temp_output_3474_0_g49638 = ( VertexPosition3588_g49638 - Mesh_PivotsOS2291_g49638 );
			float3 appendResult2043_g49638 = (float3(Motion_10_BendingX216_g49638 , 0.0 , Motion_10_BendingZ190_g49638));
			float3 Vertex_Motion_World1118_g49638 = ( temp_output_3474_0_g49638 + appendResult2043_g49638 );
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch4976_g49638 = Vertex_Motion_World1118_g49638;
			#else
				float3 staticSwitch4976_g49638 = ( Vertex_Motion_Object833_g49638 + ( _VertexDataMode * 0.0 ) );
			#endif
			half3 Grass_Perspective2661_g49638 = half3(0,0,0);
			float4 temp_output_94_19_g74622 = TVE_VertexCoords;
			half2 UV97_g74622 = ( (temp_output_94_19_g74622).zw + ( (temp_output_94_19_g74622).xy * (ObjectPosition4223_g49638).xz ) );
			float temp_output_84_0_g74622 = _LayerVertexValue;
			float4 lerpResult109_g74622 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g74622,temp_output_84_0_g74622), 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g74622]);
			half4 Global_Vertex_Params4173_g49638 = lerpResult109_g74622;
			half Global_VertexSize174_g49638 = saturate( Global_Vertex_Params4173_g49638.w );
			float lerpResult346_g49638 = lerp( 1.0 , Global_VertexSize174_g49638 , _GlobalSize);
			float3 appendResult3480_g49638 = (float3(lerpResult346_g49638 , lerpResult346_g49638 , lerpResult346_g49638));
			half3 ObjectData20_g74589 = appendResult3480_g49638;
			half3 _Vector11 = half3(1,1,1);
			half3 WorldData19_g74589 = _Vector11;
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74589 = WorldData19_g74589;
			#else
				float3 staticSwitch14_g74589 = ObjectData20_g74589;
			#endif
			half3 Vertex_Size1741_g49638 = staticSwitch14_g74589;
			half3 _Vector5 = half3(1,1,1);
			float3 Vertex_SizeFade1740_g49638 = _Vector5;
			float3 lerpResult16_g74588 = lerp( VertexPosition3588_g49638 , ( ( ( staticSwitch4976_g49638 + Grass_Perspective2661_g49638 ) * Vertex_Size1741_g49638 * Vertex_SizeFade1740_g49638 ) + Mesh_PivotsOS2291_g49638 ) , TVE_Enabled);
			float3 Final_VertexPosition890_g49638 = ( lerpResult16_g74588 + _DisableSRPBatcher );
			v.vertex.xyz = Final_VertexPosition890_g49638;
			v.vertex.w = 1;
			float temp_output_7_0_g74586 = _GradientMinValue;
			half Gradient_Tint2784_g49638 = saturate( ( ( Mesh_Height1524_g49638 - temp_output_7_0_g74586 ) / ( _GradientMaxValue - temp_output_7_0_g74586 ) ) );
			o.vertexToFrag11_g74594 = Gradient_Tint2784_g49638;
			o.vertexToFrag3890_g49638 = ase_worldPos;
			o.vertexToFrag4224_g49638 = temp_output_114_0_g74703;
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
			half2 Main_UVs15_g49638 = ( ( i.uv_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
			half3 Main_Normal137_g49638 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _MainNormalTex, sampler_Linear_Repeat, Main_UVs15_g49638 ), _MainNormalValue );
			float3 temp_output_13_0_g74515 = Main_Normal137_g49638;
			float3 switchResult12_g74515 = (((i.ASEIsFrontFacing>0)?(temp_output_13_0_g74515):(( temp_output_13_0_g74515 * _render_normals ))));
			half3 Blend_Normal312_g49638 = switchResult12_g74515;
			half3 Final_Normal366_g49638 = Blend_Normal312_g49638;
			o.Normal = Final_Normal366_g49638;
			float3 lerpResult2779_g49638 = lerp( (_GradientColorTwo).rgb , (_GradientColorOne).rgb , i.vertexToFrag11_g74594);
			float4 tex2DNode29_g49638 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g49638 );
			half3 Main_Albedo99_g49638 = ( (_MainColor).rgb * (tex2DNode29_g49638).rgb );
			half3 Blend_Albedo265_g49638 = Main_Albedo99_g49638;
			float Vertex_Occlusion648_g49638 = 1.0;
			half3 Blend_AlbedoTinted2808_g49638 = ( ( lerpResult2779_g49638 * float3(1,1,1) * float3(1,1,1) ) * Blend_Albedo265_g49638 * Vertex_Occlusion648_g49638 );
			float dotResult3616_g49638 = dot( Blend_AlbedoTinted2808_g49638 , float3(0.2126,0.7152,0.0722) );
			float3 temp_cast_1 = (dotResult3616_g49638).xxx;
			float4 temp_output_91_19_g74612 = TVE_ColorsCoords;
			float3 WorldPosition3905_g49638 = i.vertexToFrag3890_g49638;
			half3 ObjectData20_g74630 = i.vertexToFrag4224_g49638;
			half3 WorldData19_g74630 = i.vertexToFrag3890_g49638;
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
			#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
			#endif
			float3 ObjectPosition4223_g49638 = staticSwitch14_g74630;
			float3 lerpResult4822_g49638 = lerp( WorldPosition3905_g49638 , ObjectPosition4223_g49638 , _ColorsPositionMode);
			half2 UV94_g74612 = ( (temp_output_91_19_g74612).zw + ( (temp_output_91_19_g74612).xy * (lerpResult4822_g49638).xz ) );
			float temp_output_82_0_g74612 = _LayerColorsValue;
			float4 lerpResult108_g74612 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g74612,temp_output_82_0_g74612), 0.0 ) , TVE_ColorsUsage[(int)temp_output_82_0_g74612]);
			half4 Global_Colors_Params5434_g49638 = lerpResult108_g74612;
			float4 temp_output_346_0_g74569 = Global_Colors_Params5434_g49638;
			half Global_Colors_A1701_g49638 = saturate( (temp_output_346_0_g74569).w );
			half Global_Colors_Influence3668_g49638 = Global_Colors_A1701_g49638;
			float3 lerpResult3618_g49638 = lerp( Blend_AlbedoTinted2808_g49638 , temp_cast_1 , Global_Colors_Influence3668_g49638);
			half3 Global_Colors_RGB1700_g49638 = (temp_output_346_0_g74569).xyz;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g74570 = 2.0;
			#else
				float staticSwitch1_g74570 = 4.594794;
			#endif
			half3 Global_Colors1954_g49638 = ( Global_Colors_RGB1700_g49638 * staticSwitch1_g74570 );
			half Global_Colors_Value3650_g49638 = 1.0;
			float4 tex2DNode35_g49638 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_Linear_Repeat, Main_UVs15_g49638 );
			half Main_Mask57_g49638 = tex2DNode35_g49638.b;
			float clampResult5405_g49638 = clamp( Main_Mask57_g49638 , 0.01 , 0.99 );
			float temp_output_7_0_g74605 = _ColorsMaskMinValue;
			half Global_Colors_Mask3692_g49638 = saturate( ( ( clampResult5405_g49638 - temp_output_7_0_g74605 ) / ( _ColorsMaskMaxValue - temp_output_7_0_g74605 ) ) );
			float lerpResult16_g74598 = lerp( 0.0 , ( Global_Colors_Value3650_g49638 * Global_Colors_Mask3692_g49638 ) , TVE_Enabled);
			float3 lerpResult3628_g49638 = lerp( Blend_AlbedoTinted2808_g49638 , ( lerpResult3618_g49638 * Global_Colors1954_g49638 ) , lerpResult16_g74598);
			half3 Blend_AlbedoColored863_g49638 = lerpResult3628_g49638;
			half3 Blend_AlbedoAndSubsurface149_g49638 = Blend_AlbedoColored863_g49638;
			half3 Global_OverlayColor1758_g49638 = (TVE_OverlayColor).rgb;
			half Main_Albedo_G3526_g49638 = tex2DNode29_g49638.g;
			float4 temp_output_93_19_g74608 = TVE_ExtrasCoords;
			float3 lerpResult4827_g49638 = lerp( WorldPosition3905_g49638 , ObjectPosition4223_g49638 , _ExtrasPositionMode);
			half2 UV96_g74608 = ( (temp_output_93_19_g74608).zw + ( (temp_output_93_19_g74608).xy * (lerpResult4827_g49638).xz ) );
			float temp_output_84_0_g74608 = _LayerExtrasValue;
			float4 lerpResult109_g74608 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g74608,temp_output_84_0_g74608), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g74608]);
			half4 Global_Extras_Params5440_g49638 = lerpResult109_g74608;
			float4 break456_g74568 = Global_Extras_Params5440_g49638;
			half Global_Extras_Overlay156_g49638 = break456_g74568.z;
			half Overlay_Variation4560_g49638 = 1.0;
			half Overlay_Commons1365_g49638 = ( _GlobalOverlay * Global_Extras_Overlay156_g49638 * Overlay_Variation4560_g49638 );
			half Overlay_Mask_2D5121_g49638 = ( ( 0.5 + Main_Albedo_G3526_g49638 ) * Overlay_Commons1365_g49638 );
			float temp_output_7_0_g74590 = _OverlayMaskMinValue;
			half Overlay_Mask269_g49638 = saturate( ( ( Overlay_Mask_2D5121_g49638 - temp_output_7_0_g74590 ) / ( _OverlayMaskMaxValue - temp_output_7_0_g74590 ) ) );
			float3 lerpResult336_g49638 = lerp( Blend_AlbedoAndSubsurface149_g49638 , Global_OverlayColor1758_g49638 , Overlay_Mask269_g49638);
			half3 Final_Albedo359_g49638 = lerpResult336_g49638;
			o.Albedo = Final_Albedo359_g49638;
			float4 temp_output_4214_0_g49638 = ( _EmissiveColor * _EmissiveIntensityParams.x );
			half2 Emissive_UVs2468_g49638 = ( ( i.uv_texcoord.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
			half Global_Extras_Emissive4203_g49638 = break456_g74568.x;
			float lerpResult4206_g49638 = lerp( 1.0 , Global_Extras_Emissive4203_g49638 , _GlobalEmissive);
			half3 Final_Emissive2476_g49638 = ( (( temp_output_4214_0_g49638 * SAMPLE_TEXTURE2D( _EmissiveTex, sampler_Linear_Repeat, Emissive_UVs2468_g49638 ) )).rgb * lerpResult4206_g49638 );
			o.Emission = Final_Emissive2476_g49638;
			half Render_Specular4861_g49638 = _RenderSpecular;
			float3 temp_cast_8 = (( 0.04 * Render_Specular4861_g49638 )).xxx;
			o.Specular = temp_cast_8;
			half Main_Smoothness227_g49638 = ( tex2DNode35_g49638.a * _MainSmoothnessValue );
			half Blend_Smoothness314_g49638 = Main_Smoothness227_g49638;
			half Global_OverlaySmoothness311_g49638 = TVE_OverlaySmoothness;
			float lerpResult343_g49638 = lerp( Blend_Smoothness314_g49638 , Global_OverlaySmoothness311_g49638 , Overlay_Mask269_g49638);
			half Final_Smoothness371_g49638 = lerpResult343_g49638;
			half Global_Extras_Wetness305_g49638 = break456_g74568.y;
			float lerpResult3673_g49638 = lerp( 0.0 , Global_Extras_Wetness305_g49638 , _GlobalWetness);
			half Final_SmoothnessAndWetness4130_g49638 = saturate( ( Final_Smoothness371_g49638 + lerpResult3673_g49638 ) );
			o.Smoothness = Final_SmoothnessAndWetness4130_g49638;
			float lerpResult240_g49638 = lerp( 1.0 , tex2DNode35_g49638.g , _MainOcclusionValue);
			half Main_Occlusion247_g49638 = lerpResult240_g49638;
			half Blend_Occlusion323_g49638 = Main_Occlusion247_g49638;
			o.Occlusion = Blend_Occlusion323_g49638;
			half3 Subsurface_Color1722_g49638 = ( (_SubsurfaceColor).rgb * Blend_AlbedoColored863_g49638 );
			half Global_Subsurface4041_g49638 = TVE_SubsurfaceValue;
			half Subsurface_Intensity1752_g49638 = ( _SubsurfaceValue * Global_Subsurface4041_g49638 );
			float temp_output_7_0_g74604 = _SubsurfaceMaskMinValue;
			half Subsurface_Mask1557_g49638 = saturate( ( ( Main_Mask57_g49638 - temp_output_7_0_g74604 ) / ( _SubsurfaceMaskMaxValue - temp_output_7_0_g74604 ) ) );
			half3 Subsurface_Translucency884_g49638 = ( Subsurface_Color1722_g49638 * Subsurface_Intensity1752_g49638 * Subsurface_Mask1557_g49638 * 10.0 );
			o.Translucency = Subsurface_Translucency884_g49638;
			float localCustomAlphaClip19_g75158 = ( 0.0 );
			float Main_Alpha316_g49638 = ( _MainColor.a * tex2DNode29_g49638.a );
			half Global_Alpha315_g49638 = 1.0;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult2169_g49638 = normalize( ase_worldViewDir );
			float3 ViewDir_Normalized3963_g49638 = normalizeResult2169_g49638;
			float3 normalizeResult3971_g49638 = normalize( cross( ddy( ase_worldPos ) , ddx( ase_worldPos ) ) );
			float3 NormalsWS_Derivates3972_g49638 = normalizeResult3971_g49638;
			float dotResult2161_g49638 = dot( ViewDir_Normalized3963_g49638 , NormalsWS_Derivates3972_g49638 );
			float dotResult2212_g49638 = dot( ViewDir_Normalized3963_g49638 , float3(0,1,0) );
			half Mask_HView2656_g49638 = dotResult2212_g49638;
			float lerpResult2221_g49638 = lerp( _FadeHorizontalValue , _FadeVerticalValue , Mask_HView2656_g49638);
			float lerpResult3992_g49638 = lerp( 1.0 , saturate( abs( dotResult2161_g49638 ) ) , lerpResult2221_g49638);
			half Fade_Billboard2175_g49638 = lerpResult3992_g49638;
			half Fade_Mask5149_g49638 = 1.0;
			float lerpResult5141_g49638 = lerp( 1.0 , ( 1.0 * Fade_Billboard2175_g49638 ) , Fade_Mask5149_g49638);
			half Fade_Effects5360_g49638 = lerpResult5141_g49638;
			float temp_output_41_0_g75151 = Fade_Effects5360_g49638;
			half AlphaTreshold2132_g49638 = _AlphaClipValue;
			float temp_output_5361_0_g49638 = ( saturate( ( temp_output_41_0_g75151 + ( temp_output_41_0_g75151 * SAMPLE_TEXTURE3D( TVE_ScreenTex3D, sampler_Linear_Repeat, ( TVE_ScreenTexCoord * WorldPosition3905_g49638 ) ).r ) ) ) + -0.5 + AlphaTreshold2132_g49638 );
			half Fade_Alpha3727_g49638 = temp_output_5361_0_g49638;
			float temp_output_661_0_g49638 = ( Main_Alpha316_g49638 * Global_Alpha315_g49638 * Fade_Alpha3727_g49638 );
			half Alpha34_g75157 = temp_output_661_0_g49638;
			half Offest27_g75157 = AlphaTreshold2132_g49638;
			half AlphaFeather5305_g49638 = _AlphaFeatherValue;
			half Feather30_g75157 = AlphaFeather5305_g49638;
			float temp_output_25_0_g75157 = ( ( ( Alpha34_g75157 - Offest27_g75157 ) / ( max( fwidth( Alpha34_g75157 ) , 0.001 ) + Feather30_g75157 ) ) + Offest27_g75157 );
			float temp_output_3_0_g75158 = temp_output_25_0_g75157;
			float Alpha19_g75158 = temp_output_3_0_g75158;
			float temp_output_15_0_g75158 = AlphaTreshold2132_g49638;
			float Treshold19_g75158 = temp_output_15_0_g75158;
			{
			#if defined (TVE_FEATURE_CLIP)
			#if defined (TVE_IS_HD_PIPELINE)
				#if !defined (SHADERPASS_FORWARD_BYPASS_ALPHA_TEST)
					clip(Alpha19_g75158 - Treshold19_g75158);
				#endif
				#if !defined (SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
					clip(Alpha19_g75158 - Treshold19_g75158);
				#endif
			#else
				clip(Alpha19_g75158 - Treshold19_g75158);
			#endif
			#endif
			}
			half Final_Alpha914_g49638 = saturate( Alpha19_g75158 );
			o.Alpha = Final_Alpha914_g49638;
		}

		ENDCG
	}
	Fallback "Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=19100
Node;AmplifyShaderEditor.RangedFloatNode;20;-1984,-768;Half;False;Property;_render_src;_render_src;209;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1600,-768;Half;False;Property;_render_zw;_render_zw;211;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1792,-768;Half;False;Property;_render_dst;_render_dst;210;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2176,-768;Half;False;Property;_render_cull;_render_cull;208;1;[HideInInspector];Create;True;0;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-2176,-896;Half;False;Property;_IsCrossShader;_IsCrossShader;207;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;371;-1984,-896;Half;False;Property;_IsSubsurfaceShader;_IsSubsurfaceShader;206;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;354;-2176,384;Inherit;False;Define Shader Vegetation;-1;;49634;b458122dd75182d488380bd0f592b9e6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;384;-1856,384;Inherit;False;Define Pipeline Standard;-1;;49635;9af03ae8defe78d448ef2a4ef3601e12;0;0;1;FLOAT;529
Node;AmplifyShaderEditor.FunctionNode;385;-1344,-896;Inherit;False;Compile All Shaders;-1;;49636;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;386;-1536,-896;Inherit;False;Compile Core;-1;;49637;634b02fd1f32e6a4c875d8fc2c450956;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;382;-2176,-384;Inherit;False;Base Shader;7;;49638;856f7164d1c579d43a5cf4968a75ca43;79,3880,1,4028,1,3900,1,3908,1,4172,1,1300,1,1298,1,4995,1,4179,1,3586,0,4499,1,1708,1,3509,1,5151,1,3873,0,893,0,5196,0,5128,1,5156,1,5345,0,5075,1,1717,1,1715,1,1718,1,1714,1,916,0,1763,0,1762,0,3568,0,5118,1,1776,0,3475,1,4210,1,1745,1,3479,0,3501,1,5152,1,1646,0,1271,0,3889,1,2807,1,3886,0,4999,0,3887,0,3957,1,5357,0,2172,0,3883,1,3728,0,3949,0,5147,0,5146,1,5350,0,2658,0,1742,0,3484,0,5079,0,1736,0,1733,0,4837,0,1737,0,1734,0,1735,0,1550,0,878,0,860,1,2260,1,2261,1,2032,0,2054,0,5258,0,2062,0,2039,0,3243,0,5220,0,4217,1,5090,1,4242,0,5339,0;6;5115;FLOAT;1;False;5127;FLOAT;1;False;5143;FLOAT;1;False;5119;FLOAT;1;False;5117;FLOAT;1;False;5340;FLOAT3;0,0,0;False;23;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;531;FLOAT;4842;FLOAT;529;FLOAT;3678;FLOAT;530;FLOAT;4122;FLOAT;4134;FLOAT;1235;FLOAT;532;FLOAT;5389;FLOAT;721;FLOAT3;1230;FLOAT;5296;FLOAT;1461;FLOAT;1290;FLOAT;629;FLOAT3;534;FLOAT;4867;FLOAT4;5246;FLOAT4;4841
Node;AmplifyShaderEditor.RangedFloatNode;387;-1408,-768;Half;False;Property;_render_coverage;_render_coverage;212;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;383;-1376,-384;Float;False;True;-1;5;TVEShaderCoreGUI;0;0;StandardSpecular;BOXOPHOBIC/The Vegetation Engine/Default/Cross Subsurface Lit;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;Back;0;True;_render_zw;0;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;True;0;True;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;1;0;True;_render_src;0;True;_render_dst;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback;213;0;-1;-1;0;False;0;0;True;_render_cull;-1;0;False;;0;0;0;False;0.1;False;;0;True;_render_coverage;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-1024;Inherit;False;1023.392;100;Internal;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-512;Inherit;False;1024.392;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;266;-2176,256;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
WireConnection;383;0;382;0
WireConnection;383;1;382;528
WireConnection;383;2;382;2489
WireConnection;383;3;382;3678
WireConnection;383;4;382;530
WireConnection;383;5;382;531
WireConnection;383;7;382;1230
WireConnection;383;9;382;532
WireConnection;383;11;382;534
ASEEND*/
//CHKSM=DD55D337B9A3DC9AFCAD50B8F149305BDDD27105
