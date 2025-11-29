// Made with Amplify Shader Editor v1.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Default/Prop Standard Lit"
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
		_FadeCameraValue("Fade by Camera Distance", Range( 0 , 1)) = 1
		[StyledCategory(Global Settings)]_CategoryGlobal("[ Category Global ]", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerExtrasValue("Layer Extras", Float) = 0
		[StyledSpace(10)]_SpaceGlobalLayers("# Space Global Layers", Float) = 0
		[StyledMessage(Info, Procedural Variation in use. The Variation might not work as expected when switching from one LOD to another., _VertexVariationMode, 1 , 0, 10)]_MessageGlobalsVariation("# Message Globals Variation", Float) = 0
		_GlobalOverlay("Global Overlay", Range( 0 , 1)) = 1
		_GlobalWetness("Global Wetness", Range( 0 , 1)) = 1
		_GlobalEmissive("Global Emissive", Range( 0 , 1)) = 1
		[StyledSpace(10)]_SpaceGlobalLocals("# Space Global Locals", Float) = 0
		[StyledRemapSlider(_ColorsMaskMinValue, _ColorsMaskMaxValue, 0, 1)]_ColorsMaskRemap("Color Mask", Vector) = (0,0,0,0)
		[StyledRemapSlider(_AlphaMaskMinValue, _AlphaMaskMaxValue, 0, 1, 10, 0)]_AlphaMaskRemap("Alpha Mask", Vector) = (0,0,0,0)
		[StyledRemapSlider(_OverlayMaskMinValue, _OverlayMaskMaxValue, 0, 1)]_OverlayMaskRemap("Overlay Mask", Vector) = (0,0,0,0)
		[HideInInspector]_OverlayMaskMinValue("Overlay Mask Min Value", Range( 0 , 1)) = 0.45
		[HideInInspector]_OverlayMaskMaxValue("Overlay Mask Max Value", Range( 0 , 1)) = 0.55
		[StyledSpace(10)]_SpaceGlobalPosition("# Space Global Position", Float) = 0
		[StyledToggle]_ExtrasPositionMode("Use Pivot Position for Extras", Float) = 0
		[StyledCategory(Main Settings)]_CategoryMain("[Category Main ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainAlbedoTex("Main Albedo", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainNormalTex("Main Normal", 2D) = "bump" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainMaskTex("Main Mask", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[HDR]_MainColor("Main Color", Color) = (1,1,1,1)
		_MainNormalValue("Main Normal", Range( -8 , 8)) = 1
		_MainMetallicValue("Main Metallic", Range( 0 , 1)) = 0
		_MainOcclusionValue("Main Occlusion", Range( 0 , 1)) = 0
		_MainSmoothnessValue("Main Smoothness", Range( 0 , 1)) = 0
		[StyledCategory(Detail Settings)]_CategoryDetail("[ Category Detail ]", Float) = 0
		[Enum(Off,0,On,1)]_DetailMode("Detail Mode", Float) = 0
		[Enum(Overlay,0,Replace,1)]_DetailBlendMode("Detail Blend", Float) = 1
		[Enum(Vertex Blue,0,Projection,1)]_DetailTypeMode("Detail Type", Float) = 0
		[Enum(UV 0,0,Baked,1)]_DetailCoordMode("Detail Coord", Float) = 0
		[Enum(Top,0,Bottom,1)]_DetailProjectionMode("Detail Projection", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_SecondAlbedoTex("Detail Albedo", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_SecondNormalTex("Detail Normal", 2D) = "bump" {}
		[NoScaleOffset][StyledTextureSingleLine]_SecondMaskTex("Detail Mask", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_SecondUVs("Detail UVs", Vector) = (1,1,0,0)
		[HDR]_SecondColor("Detail Color", Color) = (1,1,1,1)
		_SecondNormalValue("Detail Normal", Range( -8 , 8)) = 1
		_SecondMetallicValue("Detail Metallic", Range( 0 , 1)) = 0
		_SecondOcclusionValue("Detail Occlusion", Range( 0 , 1)) = 0
		_SecondSmoothnessValue("Detail Smoothness", Range( 0 , 1)) = 0
		[Space(10)]_DetailNormalValue("Detail Use Main Normal", Range( 0 , 1)) = 0.5
		[Enum(Main Mask,0,Detail Mask,1)][Space(10)]_DetailMaskMode("Detail Mask Source", Float) = 0
		[Enum(Off,0,On,1)]_DetailMaskInvertMode("Detail Mask Invert", Float) = 0
		_DetailMeshValue("Detail Mask Offset", Range( -1 , 1)) = 0
		[StyledRemapSlider(_DetailBlendMinValue, _DetailBlendMaxValue,0,1)]_DetailBlendRemap("Detail Blending", Vector) = (0,0,0,0)
		[HideInInspector]_DetailBlendMinValue("Detail Blend Min Value", Range( 0 , 1)) = 0.2
		[HideInInspector]_DetailBlendMaxValue("Detail Blend Max Value", Range( 0 , 1)) = 0.3
		[StyledCategory(Occlusion Settings)]_CategoryOcclusion("[ Category Occlusion ]", Float) = 0
		[StyledRemapSlider(_VertexOcclusionMinValue, _VertexOcclusionMaxValue, 0, 1)]_VertexOcclusionRemap("Vertex Occlusion Mask", Vector) = (0,0,0,0)
		[StyledCategory(Subsurface Settings)]_CategorySubsurface("[ Category Subsurface ]", Float) = 0
		[StyledRemapSlider(_SubsurfaceMaskMinValue, _SubsurfaceMaskMaxValue,0,1)]_SubsurfaceMaskRemap("Subsurface Mask", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
		[StyledRemapSlider(_GradientMinValue, _GradientMaxValue, 0, 1)]_GradientMaskRemap("Gradient Mask", Vector) = (0,0,0,0)
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
		[StyledSpace(10)]_SpaceMotionLocals("# SpaceMotionLocals", Float) = 0
		[HideInInspector][StyledToggle]_VertexPivotMode("Enable Pre Baked Pivots", Float) = 0
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
		[HideInInspector]_IsPropShader("_IsPropShader", Float) = 1
		[HideInInspector]_IsStandardShader("_IsStandardShader", Float) = 1
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
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 4.5
		#pragma shader_feature_local TVE_FEATURE_CLIP
		#pragma shader_feature_local TVE_FEATURE_DETAIL
		//TVE Pipeline Defines
		#define THE_VEGETATION_ENGINE
		#define TVE_IS_STANDARD_PIPELINE
		//TVE Shader Type Defines
		#define TVE_IS_OBJECT_SHADER
		//TVE Injection Defines
		//SHADER INJECTION POINT BEGIN
		//SHADER INJECTION POINT END
		#define ASE_USING_SAMPLING_MACROS 1
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURE3D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#define SAMPLE_TEXTURE3D(tex,samplerTex,coord) tex3D(tex,coord)
		#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
		#endif//ASE Sampling Macros

		#pragma surface surf Standard keepalpha addshadow fullforwardshadows dithercrossfade vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_texcoord;
			float2 vertexToFrag11_g74581;
			float3 worldPos;
			float vertexToFrag11_g74580;
			half ASEIsFrontFacing : VFACE;
			float3 vertexToFrag5058_g68152;
			float3 worldNormal;
			INTERNAL_DATA
			float3 vertexToFrag3890_g68152;
			float3 vertexToFrag4224_g68152;
			float vertexToFrag11_g74628;
		};

		uniform half _render_cull;
		uniform half _IsPropShader;
		uniform half _IsStandardShader;
		uniform half _render_src;
		uniform half _render_dst;
		uniform half _render_zw;
		uniform half _render_coverage;
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
		uniform half _DisableSRPBatcher;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
		uniform half4 _MainUVs;
		SamplerState sampler_Linear_Repeat;
		uniform half _MainNormalValue;
		uniform half _DetailNormalValue;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondNormalTex);
		uniform half _DetailCoordMode;
		uniform half4 _SecondUVs;
		uniform half _SecondNormalValue;
		uniform half _DetailProjectionMode;
		uniform half _DetailMeshValue;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainMaskTex);
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
		uniform half _DetailMaskMode;
		uniform half _DetailMaskInvertMode;
		uniform half _DetailBlendMinValue;
		uniform half _DetailBlendMaxValue;
		uniform half3 _render_normals;
		uniform half4 _MainColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
		SamplerState sampler_MainAlbedoTex;
		uniform half4 _SecondColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondAlbedoTex);
		SamplerState sampler_SecondAlbedoTex;
		uniform half4 TVE_OverlayColor;
		uniform half _VertexDynamicMode;
		uniform half _GlobalOverlay;
		uniform half4 TVE_ExtrasParams;
		UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
		uniform half4 TVE_ExtrasCoords;
		uniform half _VertexPivotMode;
		uniform half _ExtrasPositionMode;
		uniform half _LayerExtrasValue;
		SamplerState sampler_Linear_Clamp;
		uniform float TVE_ExtrasUsage[10];
		uniform half _OverlayMaskMinValue;
		uniform half _OverlayMaskMaxValue;
		uniform half4 _EmissiveColor;
		uniform float4 _EmissiveIntensityParams;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissiveTex);
		uniform half4 _EmissiveUVs;
		uniform half _GlobalEmissive;
		uniform half _MainMetallicValue;
		uniform half _SecondMetallicValue;
		uniform half _MainSmoothnessValue;
		uniform half _SecondSmoothnessValue;
		uniform half TVE_OverlaySmoothness;
		uniform half _GlobalWetness;
		uniform half _MainOcclusionValue;
		uniform half _SecondOcclusionValue;
		uniform half TVE_CameraFadeStart;
		uniform half TVE_CameraFadeEnd;
		uniform half _FadeCameraValue;
		UNITY_DECLARE_TEX3D_NOSAMPLER(TVE_ScreenTex3D);
		uniform half TVE_ScreenTexCoord;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VertexPosition3588_g68152 = ase_vertex3Pos;
			float3 Final_VertexPosition890_g68152 = ( VertexPosition3588_g68152 + _DisableSRPBatcher );
			v.vertex.xyz = Final_VertexPosition890_g68152;
			v.vertex.w = 1;
			float2 appendResult21_g74968 = (float2(v.texcoord1.z , v.texcoord1.w));
			float2 Mesh_DetailCoord3_g68152 = appendResult21_g74968;
			float2 lerpResult1545_g68152 = lerp( v.texcoord.xy , Mesh_DetailCoord3_g68152 , _DetailCoordMode);
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half Detail_Type5060_g68152 = _DetailTypeMode;
			float2 lerpResult5059_g68152 = lerp( lerpResult1545_g68152 , (ase_worldPos).xz , Detail_Type5060_g68152);
			o.vertexToFrag11_g74581 = ( ( lerpResult5059_g68152 * (_SecondUVs).xy ) + (_SecondUVs).zw );
			half Mesh_DetailMask90_g68152 = v.color.b;
			float temp_output_990_0_g68152 = ( Mesh_DetailMask90_g68152 - 0.5 );
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float3 vertexToFrag5058_g68152 = ase_worldNormal;
			half3 World_Normal4101_g68152 = vertexToFrag5058_g68152;
			float lerpResult1537_g68152 = lerp( World_Normal4101_g68152.y , -World_Normal4101_g68152.y , _DetailProjectionMode);
			float lerpResult5062_g68152 = lerp( temp_output_990_0_g68152 , ( lerpResult1537_g68152 * 0.5 ) , Detail_Type5060_g68152);
			o.vertexToFrag11_g74580 = ( lerpResult5062_g68152 + _DetailMeshValue );
			o.vertexToFrag5058_g68152 = ase_worldNormal;
			o.vertexToFrag3890_g68152 = ase_worldPos;
			float4x4 break19_g74703 = unity_ObjectToWorld;
			float3 appendResult20_g74703 = (float3(break19_g74703[ 0 ][ 3 ] , break19_g74703[ 1 ][ 3 ] , break19_g74703[ 2 ][ 3 ]));
			float3 appendResult60_g74709 = (float3(v.texcoord3.x , v.texcoord3.z , v.texcoord3.y));
			half3 Mesh_PivotsData2831_g68152 = ( appendResult60_g74709 * _VertexPivotMode );
			float3 temp_output_122_0_g74703 = Mesh_PivotsData2831_g68152;
			float3 PivotsOnly105_g74703 = (mul( unity_ObjectToWorld, float4( temp_output_122_0_g74703 , 0.0 ) ).xyz).xyz;
			half3 ObjectData20_g74704 = ( appendResult20_g74703 + PivotsOnly105_g74703 );
			half3 WorldData19_g74704 = ase_worldPos;
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74704 = WorldData19_g74704;
			#else
				float3 staticSwitch14_g74704 = ObjectData20_g74704;
			#endif
			float3 temp_output_114_0_g74703 = staticSwitch14_g74704;
			o.vertexToFrag4224_g68152 = temp_output_114_0_g74703;
			float temp_output_7_0_g74606 = TVE_CameraFadeStart;
			float lerpResult4755_g68152 = lerp( 1.0 , saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g74606 ) / ( TVE_CameraFadeEnd - temp_output_7_0_g74606 ) ) ) , _FadeCameraValue);
			o.vertexToFrag11_g74628 = lerpResult4755_g68152;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			half2 Main_UVs15_g68152 = ( ( i.uv_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
			half3 Main_Normal137_g68152 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _MainNormalTex, sampler_Linear_Repeat, Main_UVs15_g68152 ), _MainNormalValue );
			float3 lerpResult3372_g68152 = lerp( float3( 0,0,1 ) , Main_Normal137_g68152 , _DetailNormalValue);
			half2 Second_UVs17_g68152 = i.vertexToFrag11_g74581;
			half3 Second_Normal179_g68152 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_Linear_Repeat, Second_UVs17_g68152 ), _SecondNormalValue );
			half Blend_Source1540_g68152 = i.vertexToFrag11_g74580;
			float4 tex2DNode35_g68152 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_Linear_Repeat, Main_UVs15_g68152 );
			half Main_Mask57_g68152 = tex2DNode35_g68152.b;
			float4 tex2DNode33_g68152 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_Linear_Repeat, Second_UVs17_g68152 );
			half Second_Mask81_g68152 = tex2DNode33_g68152.b;
			float lerpResult1327_g68152 = lerp( Main_Mask57_g68152 , Second_Mask81_g68152 , _DetailMaskMode);
			float lerpResult4058_g68152 = lerp( lerpResult1327_g68152 , ( 1.0 - lerpResult1327_g68152 ) , _DetailMaskInvertMode);
			float temp_output_7_0_g74553 = _DetailBlendMinValue;
			#ifdef TVE_FEATURE_DETAIL
				float staticSwitch4838_g68152 = saturate( ( ( saturate( ( Blend_Source1540_g68152 + ( Blend_Source1540_g68152 * lerpResult4058_g68152 ) ) ) - temp_output_7_0_g74553 ) / ( _DetailBlendMaxValue - temp_output_7_0_g74553 ) ) );
			#else
				float staticSwitch4838_g68152 = 0.0;
			#endif
			half Mask_Detail147_g68152 = staticSwitch4838_g68152;
			float3 lerpResult3376_g68152 = lerp( Main_Normal137_g68152 , BlendNormals( lerpResult3372_g68152 , Second_Normal179_g68152 ) , Mask_Detail147_g68152);
			#ifdef TVE_FEATURE_DETAIL
				float3 staticSwitch267_g68152 = lerpResult3376_g68152;
			#else
				float3 staticSwitch267_g68152 = Main_Normal137_g68152;
			#endif
			float3 temp_output_13_0_g74515 = staticSwitch267_g68152;
			float3 switchResult12_g74515 = (((i.ASEIsFrontFacing>0)?(temp_output_13_0_g74515):(( temp_output_13_0_g74515 * _render_normals ))));
			half3 Blend_Normal312_g68152 = switchResult12_g74515;
			half3 Final_Normal366_g68152 = Blend_Normal312_g68152;
			o.Normal = Final_Normal366_g68152;
			float4 tex2DNode29_g68152 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g68152 );
			half3 Main_Albedo99_g68152 = ( (_MainColor).rgb * (tex2DNode29_g68152).rgb );
			float4 tex2DNode89_g68152 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs17_g68152 );
			half3 Second_Albedo153_g68152 = (( _SecondColor * tex2DNode89_g68152 )).rgb;
			#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g74602 = 2.0;
			#else
				float staticSwitch1_g74602 = 4.594794;
			#endif
			float3 lerpResult4834_g68152 = lerp( ( Main_Albedo99_g68152 * Second_Albedo153_g68152 * staticSwitch1_g74602 ) , Second_Albedo153_g68152 , _DetailBlendMode);
			float3 lerpResult235_g68152 = lerp( Main_Albedo99_g68152 , lerpResult4834_g68152 , Mask_Detail147_g68152);
			#ifdef TVE_FEATURE_DETAIL
				float3 staticSwitch255_g68152 = lerpResult235_g68152;
			#else
				float3 staticSwitch255_g68152 = Main_Albedo99_g68152;
			#endif
			half3 Blend_Albedo265_g68152 = staticSwitch255_g68152;
			float Vertex_Occlusion648_g68152 = 1.0;
			half3 Blend_AlbedoTinted2808_g68152 = ( ( float3(1,1,1) * float3(1,1,1) * float3(1,1,1) ) * Blend_Albedo265_g68152 * Vertex_Occlusion648_g68152 );
			half3 Blend_AlbedoColored863_g68152 = Blend_AlbedoTinted2808_g68152;
			half3 Blend_AlbedoAndSubsurface149_g68152 = Blend_AlbedoColored863_g68152;
			half3 Global_OverlayColor1758_g68152 = (TVE_OverlayColor).rgb;
			half3 World_Normal4101_g68152 = i.vertexToFrag5058_g68152;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			half Global_DynamicMode5112_g68152 = _VertexDynamicMode;
			float lerpResult4801_g68152 = lerp( World_Normal4101_g68152.y , ase_vertexNormal.y , Global_DynamicMode5112_g68152);
			float lerpResult3567_g68152 = lerp( 0.5 , 1.0 , lerpResult4801_g68152);
			float4 temp_output_93_19_g74608 = TVE_ExtrasCoords;
			float3 WorldPosition3905_g68152 = i.vertexToFrag3890_g68152;
			half3 ObjectData20_g74630 = i.vertexToFrag4224_g68152;
			half3 WorldData19_g74630 = i.vertexToFrag3890_g68152;
			#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
			#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
			#endif
			float3 ObjectPosition4223_g68152 = staticSwitch14_g74630;
			float3 lerpResult4827_g68152 = lerp( WorldPosition3905_g68152 , ObjectPosition4223_g68152 , _ExtrasPositionMode);
			half2 UV96_g74608 = ( (temp_output_93_19_g74608).zw + ( (temp_output_93_19_g74608).xy * (lerpResult4827_g68152).xz ) );
			float temp_output_84_0_g74608 = _LayerExtrasValue;
			float4 lerpResult109_g74608 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g74608,temp_output_84_0_g74608), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g74608]);
			half4 Global_Extras_Params5440_g68152 = lerpResult109_g74608;
			float4 break456_g74568 = Global_Extras_Params5440_g68152;
			half Global_Extras_Overlay156_g68152 = break456_g74568.z;
			half Overlay_Variation4560_g68152 = 1.0;
			half Overlay_Commons1365_g68152 = ( _GlobalOverlay * Global_Extras_Overlay156_g68152 * Overlay_Variation4560_g68152 );
			half Overlay_Mask_3D5122_g68152 = ( ( ( lerpResult3567_g68152 * 0.5 ) + Blend_Albedo265_g68152.y ) * Overlay_Commons1365_g68152 );
			float temp_output_7_0_g74590 = _OverlayMaskMinValue;
			half Overlay_Mask269_g68152 = saturate( ( ( Overlay_Mask_3D5122_g68152 - temp_output_7_0_g74590 ) / ( _OverlayMaskMaxValue - temp_output_7_0_g74590 ) ) );
			float3 lerpResult336_g68152 = lerp( Blend_AlbedoAndSubsurface149_g68152 , Global_OverlayColor1758_g68152 , Overlay_Mask269_g68152);
			half3 Final_Albedo359_g68152 = lerpResult336_g68152;
			o.Albedo = Final_Albedo359_g68152;
			float4 temp_output_4214_0_g68152 = ( _EmissiveColor * _EmissiveIntensityParams.x );
			half2 Emissive_UVs2468_g68152 = ( ( i.uv_texcoord.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
			half Global_Extras_Emissive4203_g68152 = break456_g74568.x;
			float lerpResult4206_g68152 = lerp( 1.0 , Global_Extras_Emissive4203_g68152 , _GlobalEmissive);
			half3 Final_Emissive2476_g68152 = ( (( temp_output_4214_0_g68152 * SAMPLE_TEXTURE2D( _EmissiveTex, sampler_Linear_Repeat, Emissive_UVs2468_g68152 ) )).rgb * lerpResult4206_g68152 );
			o.Emission = Final_Emissive2476_g68152;
			half Main_Metallic237_g68152 = ( tex2DNode35_g68152.r * _MainMetallicValue );
			half Second_Metallic226_g68152 = ( tex2DNode33_g68152.r * _SecondMetallicValue );
			float lerpResult278_g68152 = lerp( Main_Metallic237_g68152 , Second_Metallic226_g68152 , Mask_Detail147_g68152);
			#ifdef TVE_FEATURE_DETAIL
				float staticSwitch299_g68152 = lerpResult278_g68152;
			#else
				float staticSwitch299_g68152 = Main_Metallic237_g68152;
			#endif
			half Blend_Metallic306_g68152 = staticSwitch299_g68152;
			float lerpResult342_g68152 = lerp( Blend_Metallic306_g68152 , 0.0 , Overlay_Mask269_g68152);
			half Final_Metallic367_g68152 = lerpResult342_g68152;
			o.Metallic = Final_Metallic367_g68152;
			half Main_Smoothness227_g68152 = ( tex2DNode35_g68152.a * _MainSmoothnessValue );
			half Second_Smoothness236_g68152 = ( tex2DNode33_g68152.a * _SecondSmoothnessValue );
			float lerpResult266_g68152 = lerp( Main_Smoothness227_g68152 , Second_Smoothness236_g68152 , Mask_Detail147_g68152);
			#ifdef TVE_FEATURE_DETAIL
				float staticSwitch297_g68152 = lerpResult266_g68152;
			#else
				float staticSwitch297_g68152 = Main_Smoothness227_g68152;
			#endif
			half Blend_Smoothness314_g68152 = staticSwitch297_g68152;
			half Global_OverlaySmoothness311_g68152 = TVE_OverlaySmoothness;
			float lerpResult343_g68152 = lerp( Blend_Smoothness314_g68152 , Global_OverlaySmoothness311_g68152 , Overlay_Mask269_g68152);
			half Final_Smoothness371_g68152 = lerpResult343_g68152;
			half Global_Extras_Wetness305_g68152 = break456_g74568.y;
			float lerpResult3673_g68152 = lerp( 0.0 , Global_Extras_Wetness305_g68152 , _GlobalWetness);
			half Final_SmoothnessAndWetness4130_g68152 = saturate( ( Final_Smoothness371_g68152 + lerpResult3673_g68152 ) );
			o.Smoothness = Final_SmoothnessAndWetness4130_g68152;
			float lerpResult240_g68152 = lerp( 1.0 , tex2DNode35_g68152.g , _MainOcclusionValue);
			half Main_Occlusion247_g68152 = lerpResult240_g68152;
			float lerpResult239_g68152 = lerp( 1.0 , tex2DNode33_g68152.g , _SecondOcclusionValue);
			half Second_Occlusion251_g68152 = lerpResult239_g68152;
			float lerpResult294_g68152 = lerp( Main_Occlusion247_g68152 , Second_Occlusion251_g68152 , Mask_Detail147_g68152);
			#ifdef TVE_FEATURE_DETAIL
				float staticSwitch310_g68152 = lerpResult294_g68152;
			#else
				float staticSwitch310_g68152 = Main_Occlusion247_g68152;
			#endif
			half Blend_Occlusion323_g68152 = staticSwitch310_g68152;
			o.Occlusion = Blend_Occlusion323_g68152;
			float localCustomAlphaClip19_g75158 = ( 0.0 );
			float Main_Alpha316_g68152 = ( _MainColor.a * tex2DNode29_g68152.a );
			half Global_Alpha315_g68152 = 1.0;
			half Fade_Camera3743_g68152 = i.vertexToFrag11_g74628;
			half Fade_Mask5149_g68152 = 1.0;
			float lerpResult5141_g68152 = lerp( 1.0 , ( 1.0 * Fade_Camera3743_g68152 ) , Fade_Mask5149_g68152);
			half Fade_Effects5360_g68152 = lerpResult5141_g68152;
			float temp_output_41_0_g75151 = Fade_Effects5360_g68152;
			half AlphaTreshold2132_g68152 = _AlphaClipValue;
			float temp_output_5361_0_g68152 = ( saturate( ( temp_output_41_0_g75151 + ( temp_output_41_0_g75151 * SAMPLE_TEXTURE3D( TVE_ScreenTex3D, sampler_Linear_Repeat, ( TVE_ScreenTexCoord * WorldPosition3905_g68152 ) ).r ) ) ) + -0.5 + AlphaTreshold2132_g68152 );
			half Fade_Alpha3727_g68152 = temp_output_5361_0_g68152;
			float temp_output_661_0_g68152 = ( Main_Alpha316_g68152 * Global_Alpha315_g68152 * Fade_Alpha3727_g68152 );
			half Alpha34_g75157 = temp_output_661_0_g68152;
			half Offest27_g75157 = AlphaTreshold2132_g68152;
			half AlphaFeather5305_g68152 = _AlphaFeatherValue;
			half Feather30_g75157 = AlphaFeather5305_g68152;
			float temp_output_25_0_g75157 = ( ( ( Alpha34_g75157 - Offest27_g75157 ) / ( max( fwidth( Alpha34_g75157 ) , 0.001 ) + Feather30_g75157 ) ) + Offest27_g75157 );
			float temp_output_3_0_g75158 = temp_output_25_0_g75157;
			float Alpha19_g75158 = temp_output_3_0_g75158;
			float temp_output_15_0_g75158 = AlphaTreshold2132_g68152;
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
			half Final_Alpha914_g68152 = saturate( Alpha19_g75158 );
			o.Alpha = Final_Alpha914_g68152;
		}

		ENDCG
	}
	Fallback "Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback"
	CustomEditor "TVEShaderCoreGUI"
}
/*ASEBEGIN
Version=19100
Node;AmplifyShaderEditor.RangedFloatNode;10;-2176,-768;Half;False;Property;_render_cull;_render_cull;201;1;[HideInInspector];Create;True;0;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-2176,-896;Half;False;Property;_IsPropShader;_IsPropShader;199;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-1984,-896;Half;False;Property;_IsStandardShader;_IsStandardShader;200;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1984,-768;Half;False;Property;_render_src;_render_src;202;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1792,-768;Half;False;Property;_render_dst;_render_dst;203;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1600,-768;Half;False;Property;_render_zw;_render_zw;204;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;386;-1344,-896;Inherit;False;Compile All Shaders;-1;;51076;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;387;-1536,-896;Inherit;False;Compile Core;-1;;51077;634b02fd1f32e6a4c875d8fc2c450956;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;384;-1888,384;Inherit;False;Define Pipeline Standard;-1;;56086;9af03ae8defe78d448ef2a4ef3601e12;0;0;1;FLOAT;529
Node;AmplifyShaderEditor.FunctionNode;343;-2176,384;Inherit;False;Define Shader Object;-1;;56087;1237b3cc9fbfe714d8343c91216dc9b4;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;397;-1408,-768;Half;False;Property;_render_coverage;_render_coverage;206;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;405;-2176,-384;Inherit;False;Base Shader;0;;68152;856f7164d1c579d43a5cf4968a75ca43;79,3880,1,4028,1,3900,1,3908,1,4172,1,1300,1,1298,1,4995,1,4179,1,3586,0,4499,0,1708,0,3509,1,5151,1,3873,1,893,0,5196,0,5128,1,5156,1,5345,0,5075,1,1717,1,1715,1,1718,1,1714,1,916,1,1763,0,1762,0,3568,1,5118,1,1776,0,3475,1,4210,1,1745,0,3479,0,3501,0,5152,1,1646,0,1271,0,3889,1,2807,0,3886,0,4999,0,3887,0,3957,1,5357,0,2172,0,3883,0,3728,1,3949,0,5147,0,5146,1,5350,0,2658,0,1742,0,3484,0,5079,1,1736,1,1733,1,4837,1,1737,1,1734,1,1735,1,1550,1,878,1,860,0,2260,1,2261,1,2032,1,2054,1,5258,0,2062,1,2039,1,3243,0,5220,0,4217,1,5090,1,4242,0,5339,0;6;5115;FLOAT;1;False;5127;FLOAT;1;False;5143;FLOAT;1;False;5119;FLOAT;1;False;5117;FLOAT;1;False;5340;FLOAT3;0,0,0;False;23;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;531;FLOAT;4842;FLOAT;529;FLOAT;3678;FLOAT;530;FLOAT;4122;FLOAT;4134;FLOAT;1235;FLOAT;532;FLOAT;5389;FLOAT;721;FLOAT3;1230;FLOAT;5296;FLOAT;1461;FLOAT;1290;FLOAT;629;FLOAT3;534;FLOAT;4867;FLOAT4;5246;FLOAT4;4841
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;383;-1376,-384;Float;False;True;-1;5;TVEShaderCoreGUI;0;0;Standard;BOXOPHOBIC/The Vegetation Engine/Default/Prop Standard Lit;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;Back;0;True;_render_zw;0;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;True;0;True;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;1;0;True;_render_src;0;True;_render_dst;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback;205;-1;-1;-1;0;False;0;0;True;_render_cull;-1;0;False;;0;0;0;False;0.1;False;;0;True;_render_coverage;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;340;-2176,256;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-1024;Inherit;False;1026.438;100;Internal;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-512;Inherit;False;1022.896;100;Final;0;;0,1,0.5,1;0;0
WireConnection;383;0;405;0
WireConnection;383;1;405;528
WireConnection;383;2;405;2489
WireConnection;383;3;405;529
WireConnection;383;4;405;530
WireConnection;383;5;405;531
WireConnection;383;9;405;532
WireConnection;383;11;405;534
ASEEND*/
//CHKSM=4F7CF1FCABB7B495A17B441CA4C2B6E942980FB4
