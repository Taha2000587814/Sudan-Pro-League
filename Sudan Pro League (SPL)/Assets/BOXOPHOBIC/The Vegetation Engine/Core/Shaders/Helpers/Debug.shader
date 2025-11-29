// Made with Amplify Shader Editor v1.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Debug"
{
	Properties
	{
		[StyledBanner(Debug)]_Banner("Banner", Float) = 0
		_IsVertexShader("_IsVertexShader", Float) = 0
		_IsSimpleShader("_IsSimpleShader", Float) = 0
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 0
		_IsStandardShader("_IsStandardShader", Float) = 0
		_IsSubsurfaceShader("_IsSubsurfaceShader", Float) = 0
		_IsPropShader("_IsPropShader", Float) = 0
		_IsBarkShader("_IsBarkShader", Float) = 0
		_IsImpostorShader("_IsImpostorShader", Float) = 0
		_IsVegetationShader("_IsVegetationShader", Float) = 0
		_IsGrassShader("_IsGrassShader", Float) = 0
		_IsLeafShader("_IsLeafShader", Float) = 0
		_IsCrossShader("_IsCrossShader", Float) = 0
		[NoScaleOffset]_MainNormalTex("_MainNormalTex", 2D) = "black" {}
		[NoScaleOffset]_EmissiveTex("_EmissiveTex", 2D) = "black" {}
		[NoScaleOffset]_SecondMaskTex("_SecondMaskTex", 2D) = "black" {}
		[NoScaleOffset]_SecondNormalTex("_SecondNormalTex", 2D) = "black" {}
		[NoScaleOffset]_SecondAlbedoTex("_SecondAlbedoTex", 2D) = "black" {}
		[NoScaleOffset]_MainAlbedoTex("_MainAlbedoTex", 2D) = "black" {}
		[NoScaleOffset]_MainMaskTex("_MainMaskTex", 2D) = "black" {}
		_RenderClip("_RenderClip", Float) = 0
		_IsElementShader("_IsElementShader", Float) = 0
		_IsHelperShader("_IsHelperShader", Float) = 0
		_Cutoff("_Cutoff", Float) = 0
		_DetailMode("_DetailMode", Float) = 0
		_EmissiveCat("_EmissiveCat", Float) = 0
		[HDR]_EmissiveColor("_EmissiveColor", Color) = (0,0,0,0)
		[HDR][Space(10)]_MainColor("Main Color", Color) = (1,1,1,1)
		[Space(10)][StyledToggle]_VertexColorMode("Use Vertex Colors as Albedo", Range( 0 , 1)) = 0
		[HideInInspector][Enum(Single Pivot,0,Baked Pivots,1)]_VertexPivotMode("_VertexPivotMode", Float) = 0
		[StyledToggle]_LeavesFilterMode("Use Color Filter for Leaves", Float) = 0
		[Space(10)]_LeavesFilterColor("Leaves Color Filter", Color) = (0,0,0,1)
		_LeavesFilterRange("Leaves Color Range", Range( 0 , 1)) = 0
		_IsPolygonalShader("_IsPolygonalShader", Float) = 0
		[IntRange]_MotionSpeed_10("Primary Speed", Range( 0 , 40)) = 40
		[IntRange]_MotionVariation_10("Primary Speed", Range( 0 , 40)) = 40
		_MotionScale_10("Primary Scale", Range( 0 , 20)) = 0
		[HideInInspector][StyledToggle]_VertexDynamicMode("Enable Dynamic Support", Float) = 0
		[Space(10)][StyledVector(9)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[Enum(UV 0,0,Baked,1)]_DetailCoordMode("Detail Coord", Float) = 0
		[Space(10)][StyledVector(9)]_SecondUVs("Detail UVs", Vector) = (1,1,0,0)
		[Space(10)][StyledVector(9)]_EmissiveUVs("Emissive UVs", Vector) = (1,1,0,0)
		[ASEEnd][StyledMessage(Info, Use this shader to debug the original mesh or the converted mesh attributes., 0,0)]_Message("Message", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
		//[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		//[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}
	
	SubShader
	{
		
		Tags { "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="True" }
	LOD 0

		Cull Off
		AlphaToMask Off
		ZWrite On
		ZTest LEqual
		ColorMask RGBA
		
		Blend Off
		

		CGINCLUDE
		#pragma target 5.0

		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}
		
		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		ENDCG

		
		Pass
		{
			
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }
			
			Blend One Zero

			CGPROGRAM
			#define ASE_NO_AMBIENT 1

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			#ifndef UNITY_PASS_FORWARDBASE
				#define UNITY_PASS_FORWARDBASE
			#endif
			#include "HLSLSupport.cginc"
			#ifndef UNITY_INSTANCED_LOD_FADE
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#ifndef UNITY_INSTANCED_SH
				#define UNITY_INSTANCED_SH
			#endif
			#ifndef UNITY_INSTANCED_LIGHTMAPSTS
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "AutoLight.cginc"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
			#endif//ASE Sampling Macros
			

			struct appdata {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f {
				#if UNITY_VERSION >= 201810
					UNITY_POSITION(pos);
				#else
					float4 pos : SV_POSITION;
				#endif
				#if defined(LIGHTMAP_ON) || (!defined(LIGHTMAP_ON) && SHADER_TARGET >= 30)
					float4 lmap : TEXCOORD0;
				#endif
				#if !defined(LIGHTMAP_ON) && UNITY_SHOULD_SAMPLE_SH
					half3 sh : TEXCOORD1;
				#endif
				#if defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS) && UNITY_VERSION >= 201810 && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_LIGHTING_COORDS(2,3)
				#elif defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if UNITY_VERSION >= 201710
						UNITY_SHADOW_COORDS(2)
					#else
						SHADOW_COORDS(2)
					#endif
				#endif
				#ifdef ASE_FOG
					UNITY_FOG_COORDS(4)
				#endif
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 screenPos : TEXCOORD8;
				#endif
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
				float4 ase_texcoord12 : TEXCOORD12;
				float4 ase_color : COLOR;
				float4 ase_texcoord13 : TEXCOORD13;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			uniform half _Banner;
			uniform half _Message;
			uniform float _IsSimpleShader;
			uniform float _IsVertexShader;
			uniform half _IsTVEShader;
			uniform half TVE_DEBUG_Type;
			uniform float _IsBarkShader;
			uniform float _IsCrossShader;
			uniform float _IsGrassShader;
			uniform float _IsLeafShader;
			uniform float _IsPropShader;
			uniform float _IsImpostorShader;
			uniform float _IsPolygonalShader;
			uniform float _IsStandardShader;
			uniform float _IsSubsurfaceShader;
			uniform half TVE_DEBUG_Index;
			uniform sampler2D _MainAlbedoTex;
			uniform half4 _MainUVs;
			uniform sampler2D _MainNormalTex;
			uniform sampler2D _MainMaskTex;
			uniform sampler2D _SecondAlbedoTex;
			uniform half _DetailCoordMode;
			uniform half4 _SecondUVs;
			uniform sampler2D _SecondNormalTex;
			uniform sampler2D _SecondMaskTex;
			uniform float _DetailMode;
			uniform sampler2D _EmissiveTex;
			uniform half4 _EmissiveUVs;
			uniform float4 _EmissiveColor;
			uniform float _EmissiveCat;
			uniform half TVE_DEBUG_Min;
			uniform half TVE_DEBUG_Max;
			float4 _MainAlbedoTex_TexelSize;
			float4 _MainNormalTex_TexelSize;
			float4 _MainMaskTex_TexelSize;
			float4 _SecondAlbedoTex_TexelSize;
			float4 _SecondMaskTex_TexelSize;
			float4 _EmissiveTex_TexelSize;
			uniform float4 _MainAlbedoTex_ST;
			uniform sampler2D TVE_DEBUG_MipTex;
			uniform float4 _MainNormalTex_ST;
			uniform float4 _MainMaskTex_ST;
			uniform float4 _SecondAlbedoTex_ST;
			uniform float4 _SecondMaskTex_ST;
			uniform float4 _EmissiveTex_ST;
			uniform sampler2D TVE_NoiseTex;
			uniform float _MotionScale_10;
			uniform half4 TVE_NoiseParams;
			uniform half4 TVE_MotionParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
			uniform half4 TVE_MotionCoords;
			uniform half _VertexPivotMode;
			uniform half TVE_DEBUG_Layer;
			SamplerState sampler_Linear_Clamp;
			uniform float TVE_MotionUsage[10];
			uniform float _MotionSpeed_10;
			uniform float _MotionVariation_10;
			uniform half _VertexDynamicMode;
			uniform half4 TVE_ColorsParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
			uniform half4 TVE_ColorsCoords;
			uniform float TVE_ColorsUsage[10];
			uniform half4 TVE_ExtrasParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
			uniform half4 TVE_ExtrasCoords;
			uniform float TVE_ExtrasUsage[10];
			uniform half4 TVE_VertexParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertexTex);
			uniform half4 TVE_VertexCoords;
			uniform float TVE_VertexUsage[10];
			uniform half4 _LeavesFilterColor;
			uniform half4 _MainColor;
			uniform half _VertexColorMode;
			uniform float _LeavesFilterRange;
			uniform half _LeavesFilterMode;
			uniform float _IsVegetationShader;
			uniform half TVE_DEBUG_Filter;
			uniform half TVE_DEBUG_Clip;
			uniform float _RenderClip;
			uniform float _Cutoff;
			uniform float _IsElementShader;
			uniform float _IsHelperShader;

	
			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			

			v2f VertexFunction (appdata v  ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 customSurfaceDepth676_g73574 = v.vertex.xyz;
				float customEye676_g73574 = -UnityObjectToViewPos( customSurfaceDepth676_g73574 ).z;
				o.ase_texcoord9.x = customEye676_g73574;
				float4 color1097_g73574 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 color1096_g73574 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float2 uv_MainMaskTex1077_g73574 = v.ase_texcoord.xy;
				float3 linearToGamma1066_g73574 = LinearToGammaSpace( _LeavesFilterColor.rgb );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch1060_g73574 = (_LeavesFilterColor).rgb;
				#else
				float3 staticSwitch1060_g73574 = linearToGamma1066_g73574;
				#endif
				float2 uv_MainAlbedoTex1045_g73574 = v.ase_texcoord.xy;
				float4 tex2DNode1045_g73574 = tex2Dlod( _MainAlbedoTex, float4( uv_MainAlbedoTex1045_g73574, 0, 0.0) );
				float3 lerpResult1043_g73574 = lerp( (tex2DNode1045_g73574).rgb , (v.ase_color).rgb , _VertexColorMode);
				half3 Main_Albedo1078_g73574 = ( (_MainColor).rgb * lerpResult1043_g73574 );
				float3 linearToGamma1058_g73574 = LinearToGammaSpace( Main_Albedo1078_g73574 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch1068_g73574 = (Main_Albedo1078_g73574).xyz;
				#else
				float3 staticSwitch1068_g73574 = linearToGamma1058_g73574;
				#endif
				float lerpResult1071_g73574 = lerp( 1.0 , saturate( ( 1.0 - ceil( ( distance( staticSwitch1060_g73574 , staticSwitch1068_g73574 ) - _LeavesFilterRange ) ) ) ) , _LeavesFilterMode);
				half Main_ColorFilter1061_g73574 = lerpResult1071_g73574;
				float4 lerpResult1095_g73574 = lerp( color1097_g73574 , color1096_g73574 , ( tex2Dlod( _MainMaskTex, float4( uv_MainMaskTex1077_g73574, 0, 0.0) ).b * Main_ColorFilter1061_g73574 ));
				float4 vertexToFrag11_g73576 = lerpResult1095_g73574;
				o.ase_texcoord13 = vertexToFrag11_g73576;
				float Debug_Index464_g73574 = TVE_DEBUG_Index;
				float3 ifLocalVar40_g73581 = 0;
				if( Debug_Index464_g73574 == 0.0 )
				ifLocalVar40_g73581 = saturate( v.vertex.xyz );
				float3 ifLocalVar40_g73605 = 0;
				if( Debug_Index464_g73574 == 1.0 )
				ifLocalVar40_g73605 = v.normal;
				float3 ifLocalVar40_g73622 = 0;
				if( Debug_Index464_g73574 == 2.0 )
				ifLocalVar40_g73622 = v.tangent.xyz;
				float ifLocalVar40_g73598 = 0;
				if( Debug_Index464_g73574 == 3.0 )
				ifLocalVar40_g73598 = saturate( v.tangent.w );
				float3 temp_cast_2 = (v.ase_color.r).xxx;
				float3 hsvTorgb260_g73574 = HSVToRGB( float3(v.ase_color.r,1.0,1.0) );
				float3 gammaToLinear266_g73574 = GammaToLinearSpace( hsvTorgb260_g73574 );
				float _IsBarkShader347_g73574 = _IsBarkShader;
				float _IsLeafShader360_g73574 = _IsLeafShader;
				float _IsCrossShader342_g73574 = _IsCrossShader;
				float _IsGrassShader341_g73574 = _IsGrassShader;
				float _IsVegetationShader1101_g73574 = _IsVegetationShader;
				float _IsAnyVegetationShader362_g73574 = saturate( ( _IsBarkShader347_g73574 + _IsLeafShader360_g73574 + _IsCrossShader342_g73574 + _IsGrassShader341_g73574 + _IsVegetationShader1101_g73574 ) );
				float3 lerpResult290_g73574 = lerp( temp_cast_2 , gammaToLinear266_g73574 , _IsAnyVegetationShader362_g73574);
				float3 ifLocalVar40_g73620 = 0;
				if( Debug_Index464_g73574 == 5.0 )
				ifLocalVar40_g73620 = lerpResult290_g73574;
				float ifLocalVar40_g73659 = 0;
				if( Debug_Index464_g73574 == 6.0 )
				ifLocalVar40_g73659 = v.ase_color.g;
				float ifLocalVar40_g73589 = 0;
				if( Debug_Index464_g73574 == 7.0 )
				ifLocalVar40_g73589 = v.ase_color.b;
				float ifLocalVar40_g73601 = 0;
				if( Debug_Index464_g73574 == 8.0 )
				ifLocalVar40_g73601 = v.ase_color.a;
				float ifLocalVar40_g73587 = 0;
				if( Debug_Index464_g73574 == 9.0 )
				ifLocalVar40_g73587 = v.ase_color.a;
				float enc1154_g73574 = v.ase_texcoord.z;
				float2 localDecodeFloatToVector21154_g73574 = DecodeFloatToVector2( enc1154_g73574 );
				float2 break1155_g73574 = localDecodeFloatToVector21154_g73574;
				float ifLocalVar40_g73604 = 0;
				if( Debug_Index464_g73574 == 10.0 )
				ifLocalVar40_g73604 = break1155_g73574.x;
				float ifLocalVar40_g73603 = 0;
				if( Debug_Index464_g73574 == 11.0 )
				ifLocalVar40_g73603 = break1155_g73574.y;
				float3 appendResult1147_g73574 = (float3(v.ase_texcoord.x , v.ase_texcoord.y , 0.0));
				float3 ifLocalVar40_g73584 = 0;
				if( Debug_Index464_g73574 == 12.0 )
				ifLocalVar40_g73584 = appendResult1147_g73574;
				float3 appendResult1148_g73574 = (float3(v.texcoord1.xyzw.x , v.texcoord1.xyzw.y , 0.0));
				float3 ifLocalVar40_g73608 = 0;
				if( Debug_Index464_g73574 == 13.0 )
				ifLocalVar40_g73608 = appendResult1148_g73574;
				float3 appendResult1149_g73574 = (float3(v.texcoord1.xyzw.z , v.texcoord1.xyzw.w , 0.0));
				float3 ifLocalVar40_g73610 = 0;
				if( Debug_Index464_g73574 == 14.0 )
				ifLocalVar40_g73610 = appendResult1149_g73574;
				float3 appendResult60_g73660 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
				float3 ifLocalVar40_g73575 = 0;
				if( Debug_Index464_g73574 == 15.0 )
				ifLocalVar40_g73575 = appendResult60_g73660;
				float3 vertexToFrag328_g73574 = ( ( ifLocalVar40_g73581 + ifLocalVar40_g73605 + ifLocalVar40_g73622 + ifLocalVar40_g73598 ) + ( ifLocalVar40_g73620 + ifLocalVar40_g73659 + ifLocalVar40_g73589 + ifLocalVar40_g73601 ) + ( ifLocalVar40_g73587 + ifLocalVar40_g73604 + ifLocalVar40_g73603 ) + ( ifLocalVar40_g73584 + ifLocalVar40_g73608 + ifLocalVar40_g73610 + ifLocalVar40_g73575 ) );
				o.ase_texcoord9.yzw = vertexToFrag328_g73574;
				
				o.ase_texcoord10 = v.ase_texcoord;
				o.ase_texcoord11 = v.texcoord1.xyzw;
				o.ase_texcoord12 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.vertex.w = 1;
				v.normal = v.normal;
				v.tangent = v.tangent;

				o.pos = UnityObjectToClipPos(v.vertex);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
				o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
				o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
				o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);

				#ifdef DYNAMICLIGHTMAP_ON
				o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif
				#ifdef LIGHTMAP_ON
				o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				#ifndef LIGHTMAP_ON
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						o.sh = 0;
						#ifdef VERTEXLIGHT_ON
						o.sh += Shade4PointLights (
							unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
							unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
							unity_4LightAtten0, worldPos, worldNormal);
						#endif
						o.sh = ShadeSHPerVertex (worldNormal, o.sh);
					#endif
				#endif

				#if UNITY_VERSION >= 201810 && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
				#elif defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if UNITY_VERSION >= 201710
						UNITY_TRANSFER_SHADOW(o, v.texcoord1.xy);
					#else
						TRANSFER_SHADOW(o);
					#endif
				#endif

				#ifdef ASE_FOG
					UNITY_TRANSFER_FOG(o,o.pos);
				#endif
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
					o.screenPos = ComputeScreenPos(o.pos);
				#endif
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( appdata v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.tangent = v.tangent;
				o.normal = v.normal;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				appdata o = (appdata) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
				o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			v2f vert ( appdata v )
			{
				return VertexFunction( v );
			}
			#endif
			
			fixed4 frag (v2f IN , bool ase_vface : SV_IsFrontFace
				#ifdef _DEPTHOFFSET_ON
				, out float outputDepth : SV_Depth
				#endif
				) : SV_Target 
			{
				UNITY_SETUP_INSTANCE_ID(IN);

				#ifdef LOD_FADE_CROSSFADE
					UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				#endif

				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif
				float3 WorldTangent = float3(IN.tSpace0.x,IN.tSpace1.x,IN.tSpace2.x);
				float3 WorldBiTangent = float3(IN.tSpace0.y,IN.tSpace1.y,IN.tSpace2.y);
				float3 WorldNormal = float3(IN.tSpace0.z,IN.tSpace1.z,IN.tSpace2.z);
				float3 worldPos = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
				#else
					half atten = 1;
				#endif
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 ScreenPos = IN.screenPos;
				#endif

				float Debug_Type367_g73574 = TVE_DEBUG_Type;
				float4 color646_g73574 = IsGammaSpace() ? float4(0.9245283,0.7969696,0.4142933,1) : float4(0.8368256,0.5987038,0.1431069,1);
				float customEye676_g73574 = IN.ase_texcoord9.x;
				float saferPower688_g73574 = abs( (0.0 + (customEye676_g73574 - 300.0) * (1.0 - 0.0) / (0.0 - 300.0)) );
				float clampResult702_g73574 = clamp( pow( saferPower688_g73574 , 1.25 ) , 0.75 , 1.0 );
				float Shading655_g73574 = clampResult702_g73574;
				float4 Output_Converted717_g73574 = ( color646_g73574 * Shading655_g73574 );
				float4 ifLocalVar40_g73600 = 0;
				if( Debug_Type367_g73574 == 0.0 )
				ifLocalVar40_g73600 = Output_Converted717_g73574;
				float4 color466_g73574 = IsGammaSpace() ? float4(0.8113208,0.4952317,0.264062,0) : float4(0.6231937,0.2096542,0.05668841,0);
				float _IsBarkShader347_g73574 = _IsBarkShader;
				float4 color469_g73574 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsCrossShader342_g73574 = _IsCrossShader;
				float4 color472_g73574 = IsGammaSpace() ? float4(0.7100264,0.8018868,0.2231666,0) : float4(0.4623997,0.6070304,0.0407874,0);
				float _IsGrassShader341_g73574 = _IsGrassShader;
				float4 color475_g73574 = IsGammaSpace() ? float4(0.3267961,0.7264151,0.3118103,0) : float4(0.08721471,0.4865309,0.07922345,0);
				float _IsLeafShader360_g73574 = _IsLeafShader;
				float4 color478_g73574 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsPropShader346_g73574 = _IsPropShader;
				float4 color1114_g73574 = IsGammaSpace() ? float4(0.9716981,0.3162602,0.4816265,0) : float4(0.9368213,0.08154967,0.1974273,0);
				float _IsImpostorShader1110_g73574 = _IsImpostorShader;
				float4 color1117_g73574 = IsGammaSpace() ? float4(0.257921,0.8679245,0.8361252,0) : float4(0.05410501,0.7254258,0.6668791,0);
				float _IsPolygonalShader1112_g73574 = _IsPolygonalShader;
				float4 Output_Shader445_g73574 = ( ( ( color466_g73574 * _IsBarkShader347_g73574 ) + ( color469_g73574 * _IsCrossShader342_g73574 ) + ( color472_g73574 * _IsGrassShader341_g73574 ) + ( color475_g73574 * _IsLeafShader360_g73574 ) + ( color478_g73574 * _IsPropShader346_g73574 ) + ( color1114_g73574 * _IsImpostorShader1110_g73574 ) + ( color1117_g73574 * _IsPolygonalShader1112_g73574 ) ) * Shading655_g73574 );
				float4 ifLocalVar40_g73677 = 0;
				if( Debug_Type367_g73574 == 1.0 )
				ifLocalVar40_g73677 = Output_Shader445_g73574;
				float4 color529_g73574 = IsGammaSpace() ? float4(0.62,0.77,0.15,0) : float4(0.3423916,0.5542217,0.01960665,0);
				float _IsVertexShader1158_g73574 = _IsVertexShader;
				float4 color544_g73574 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsSimpleShader359_g73574 = _IsSimpleShader;
				float4 color521_g73574 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsStandardShader344_g73574 = _IsStandardShader;
				float4 color1121_g73574 = IsGammaSpace() ? float4(0.9245283,0.8421515,0.1788003,0) : float4(0.8368256,0.677754,0.02687956,0);
				float _IsSubsurfaceShader548_g73574 = _IsSubsurfaceShader;
				float4 Output_Lighting525_g73574 = ( ( ( color529_g73574 * _IsVertexShader1158_g73574 ) + ( color544_g73574 * _IsSimpleShader359_g73574 ) + ( color521_g73574 * _IsStandardShader344_g73574 ) + ( color1121_g73574 * _IsSubsurfaceShader548_g73574 ) ) * Shading655_g73574 );
				float4 ifLocalVar40_g73658 = 0;
				if( Debug_Type367_g73574 == 2.0 )
				ifLocalVar40_g73658 = Output_Lighting525_g73574;
				float Debug_Index464_g73574 = TVE_DEBUG_Index;
				half2 Main_UVs1219_g73574 = ( ( IN.ase_texcoord10.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode586_g73574 = tex2D( _MainAlbedoTex, Main_UVs1219_g73574 );
				float3 appendResult637_g73574 = (float3(tex2DNode586_g73574.r , tex2DNode586_g73574.g , tex2DNode586_g73574.b));
				float3 ifLocalVar40_g73602 = 0;
				if( Debug_Index464_g73574 == 0.0 )
				ifLocalVar40_g73602 = appendResult637_g73574;
				float ifLocalVar40_g73612 = 0;
				if( Debug_Index464_g73574 == 1.0 )
				ifLocalVar40_g73612 = tex2D( _MainAlbedoTex, Main_UVs1219_g73574 ).a;
				float4 tex2DNode604_g73574 = tex2D( _MainNormalTex, Main_UVs1219_g73574 );
				float3 appendResult876_g73574 = (float3(tex2DNode604_g73574.a , tex2DNode604_g73574.g , 1.0));
				float3 gammaToLinear878_g73574 = GammaToLinearSpace( appendResult876_g73574 );
				float3 ifLocalVar40_g73639 = 0;
				if( Debug_Index464_g73574 == 2.0 )
				ifLocalVar40_g73639 = gammaToLinear878_g73574;
				float ifLocalVar40_g73585 = 0;
				if( Debug_Index464_g73574 == 3.0 )
				ifLocalVar40_g73585 = tex2D( _MainMaskTex, Main_UVs1219_g73574 ).r;
				float ifLocalVar40_g73679 = 0;
				if( Debug_Index464_g73574 == 4.0 )
				ifLocalVar40_g73679 = tex2D( _MainMaskTex, Main_UVs1219_g73574 ).g;
				float ifLocalVar40_g73614 = 0;
				if( Debug_Index464_g73574 == 5.0 )
				ifLocalVar40_g73614 = tex2D( _MainMaskTex, Main_UVs1219_g73574 ).b;
				float ifLocalVar40_g73582 = 0;
				if( Debug_Index464_g73574 == 6.0 )
				ifLocalVar40_g73582 = tex2D( _MainMaskTex, Main_UVs1219_g73574 ).a;
				float2 appendResult1251_g73574 = (float2(IN.ase_texcoord11.z , IN.ase_texcoord11.w));
				float2 Mesh_DetailCoord1254_g73574 = appendResult1251_g73574;
				float2 lerpResult1231_g73574 = lerp( IN.ase_texcoord10.xy , Mesh_DetailCoord1254_g73574 , _DetailCoordMode);
				half2 Second_UVs1234_g73574 = ( ( lerpResult1231_g73574 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				float4 tex2DNode854_g73574 = tex2D( _SecondAlbedoTex, Second_UVs1234_g73574 );
				float3 appendResult839_g73574 = (float3(tex2DNode854_g73574.r , tex2DNode854_g73574.g , tex2DNode854_g73574.b));
				float3 ifLocalVar40_g73597 = 0;
				if( Debug_Index464_g73574 == 7.0 )
				ifLocalVar40_g73597 = appendResult839_g73574;
				float ifLocalVar40_g73621 = 0;
				if( Debug_Index464_g73574 == 8.0 )
				ifLocalVar40_g73621 = tex2D( _SecondAlbedoTex, Second_UVs1234_g73574 ).a;
				float4 tex2DNode841_g73574 = tex2D( _SecondNormalTex, Second_UVs1234_g73574 );
				float3 appendResult880_g73574 = (float3(tex2DNode841_g73574.a , tex2DNode841_g73574.g , 1.0));
				float3 gammaToLinear879_g73574 = GammaToLinearSpace( appendResult880_g73574 );
				float3 ifLocalVar40_g73667 = 0;
				if( Debug_Index464_g73574 == 8.0 )
				ifLocalVar40_g73667 = gammaToLinear879_g73574;
				float ifLocalVar40_g73640 = 0;
				if( Debug_Index464_g73574 == 10.0 )
				ifLocalVar40_g73640 = tex2D( _SecondMaskTex, Second_UVs1234_g73574 ).r;
				float ifLocalVar40_g73611 = 0;
				if( Debug_Index464_g73574 == 11.0 )
				ifLocalVar40_g73611 = tex2D( _SecondMaskTex, Second_UVs1234_g73574 ).g;
				float ifLocalVar40_g73657 = 0;
				if( Debug_Index464_g73574 == 12.0 )
				ifLocalVar40_g73657 = tex2D( _SecondMaskTex, Second_UVs1234_g73574 ).b;
				float ifLocalVar40_g73666 = 0;
				if( Debug_Index464_g73574 == 13.0 )
				ifLocalVar40_g73666 = tex2D( _SecondMaskTex, Second_UVs1234_g73574 ).a;
				half2 Emissive_UVs1245_g73574 = ( ( IN.ase_texcoord10.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				float4 tex2DNode858_g73574 = tex2D( _EmissiveTex, Emissive_UVs1245_g73574 );
				float3 appendResult867_g73574 = (float3(tex2DNode858_g73574.r , tex2DNode858_g73574.g , tex2DNode858_g73574.b));
				float3 ifLocalVar40_g73609 = 0;
				if( Debug_Index464_g73574 == 14.0 )
				ifLocalVar40_g73609 = appendResult867_g73574;
				float Debug_Min721_g73574 = TVE_DEBUG_Min;
				float temp_output_7_0_g73652 = Debug_Min721_g73574;
				float4 temp_cast_3 = (temp_output_7_0_g73652).xxxx;
				float Debug_Max723_g73574 = TVE_DEBUG_Max;
				float4 Output_Maps561_g73574 = ( ( ( float4( ( ( ifLocalVar40_g73602 + ifLocalVar40_g73612 + ifLocalVar40_g73639 ) + ( ifLocalVar40_g73585 + ifLocalVar40_g73679 + ifLocalVar40_g73614 + ifLocalVar40_g73582 ) ) , 0.0 ) + float4( ( ( ( ifLocalVar40_g73597 + ifLocalVar40_g73621 + ifLocalVar40_g73667 ) + ( ifLocalVar40_g73640 + ifLocalVar40_g73611 + ifLocalVar40_g73657 + ifLocalVar40_g73666 ) ) * _DetailMode ) , 0.0 ) + ( ( float4( ifLocalVar40_g73609 , 0.0 ) * _EmissiveColor ) * _EmissiveCat ) ) - temp_cast_3 ) / ( Debug_Max723_g73574 - temp_output_7_0_g73652 ) );
				float4 ifLocalVar40_g73651 = 0;
				if( Debug_Type367_g73574 == 3.0 )
				ifLocalVar40_g73651 = Output_Maps561_g73574;
				float Resolution44_g74628 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 color62_g74628 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74628 = 0;
				if( Resolution44_g74628 <= 256.0 )
				ifLocalVar61_g74628 = color62_g74628;
				float4 color55_g74628 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74628 = 0;
				if( Resolution44_g74628 == 512.0 )
				ifLocalVar56_g74628 = color55_g74628;
				float4 color42_g74628 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74628 = 0;
				if( Resolution44_g74628 == 1024.0 )
				ifLocalVar40_g74628 = color42_g74628;
				float4 color48_g74628 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74628 = 0;
				if( Resolution44_g74628 == 2048.0 )
				ifLocalVar47_g74628 = color48_g74628;
				float4 color51_g74628 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74628 = 0;
				if( Resolution44_g74628 >= 4096.0 )
				ifLocalVar52_g74628 = color51_g74628;
				float4 ifLocalVar40_g73695 = 0;
				if( Debug_Index464_g73574 == 0.0 )
				ifLocalVar40_g73695 = ( ifLocalVar61_g74628 + ifLocalVar56_g74628 + ifLocalVar40_g74628 + ifLocalVar47_g74628 + ifLocalVar52_g74628 );
				float Resolution44_g74627 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 color62_g74627 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74627 = 0;
				if( Resolution44_g74627 <= 256.0 )
				ifLocalVar61_g74627 = color62_g74627;
				float4 color55_g74627 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74627 = 0;
				if( Resolution44_g74627 == 512.0 )
				ifLocalVar56_g74627 = color55_g74627;
				float4 color42_g74627 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74627 = 0;
				if( Resolution44_g74627 == 1024.0 )
				ifLocalVar40_g74627 = color42_g74627;
				float4 color48_g74627 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74627 = 0;
				if( Resolution44_g74627 == 2048.0 )
				ifLocalVar47_g74627 = color48_g74627;
				float4 color51_g74627 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74627 = 0;
				if( Resolution44_g74627 >= 4096.0 )
				ifLocalVar52_g74627 = color51_g74627;
				float4 ifLocalVar40_g73693 = 0;
				if( Debug_Index464_g73574 == 1.0 )
				ifLocalVar40_g73693 = ( ifLocalVar61_g74627 + ifLocalVar56_g74627 + ifLocalVar40_g74627 + ifLocalVar47_g74627 + ifLocalVar52_g74627 );
				float Resolution44_g74626 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 color62_g74626 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74626 = 0;
				if( Resolution44_g74626 <= 256.0 )
				ifLocalVar61_g74626 = color62_g74626;
				float4 color55_g74626 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74626 = 0;
				if( Resolution44_g74626 == 512.0 )
				ifLocalVar56_g74626 = color55_g74626;
				float4 color42_g74626 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74626 = 0;
				if( Resolution44_g74626 == 1024.0 )
				ifLocalVar40_g74626 = color42_g74626;
				float4 color48_g74626 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74626 = 0;
				if( Resolution44_g74626 == 2048.0 )
				ifLocalVar47_g74626 = color48_g74626;
				float4 color51_g74626 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74626 = 0;
				if( Resolution44_g74626 >= 4096.0 )
				ifLocalVar52_g74626 = color51_g74626;
				float4 ifLocalVar40_g73694 = 0;
				if( Debug_Index464_g73574 == 2.0 )
				ifLocalVar40_g73694 = ( ifLocalVar61_g74626 + ifLocalVar56_g74626 + ifLocalVar40_g74626 + ifLocalVar47_g74626 + ifLocalVar52_g74626 );
				float Resolution44_g74633 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g74633 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74633 = 0;
				if( Resolution44_g74633 <= 256.0 )
				ifLocalVar61_g74633 = color62_g74633;
				float4 color55_g74633 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74633 = 0;
				if( Resolution44_g74633 == 512.0 )
				ifLocalVar56_g74633 = color55_g74633;
				float4 color42_g74633 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74633 = 0;
				if( Resolution44_g74633 == 1024.0 )
				ifLocalVar40_g74633 = color42_g74633;
				float4 color48_g74633 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74633 = 0;
				if( Resolution44_g74633 == 2048.0 )
				ifLocalVar47_g74633 = color48_g74633;
				float4 color51_g74633 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74633 = 0;
				if( Resolution44_g74633 >= 4096.0 )
				ifLocalVar52_g74633 = color51_g74633;
				float4 ifLocalVar40_g74612 = 0;
				if( Debug_Index464_g73574 == 3.0 )
				ifLocalVar40_g74612 = ( ifLocalVar61_g74633 + ifLocalVar56_g74633 + ifLocalVar40_g74633 + ifLocalVar47_g74633 + ifLocalVar52_g74633 );
				float Resolution44_g74632 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 color62_g74632 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74632 = 0;
				if( Resolution44_g74632 <= 256.0 )
				ifLocalVar61_g74632 = color62_g74632;
				float4 color55_g74632 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74632 = 0;
				if( Resolution44_g74632 == 512.0 )
				ifLocalVar56_g74632 = color55_g74632;
				float4 color42_g74632 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74632 = 0;
				if( Resolution44_g74632 == 1024.0 )
				ifLocalVar40_g74632 = color42_g74632;
				float4 color48_g74632 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74632 = 0;
				if( Resolution44_g74632 == 2048.0 )
				ifLocalVar47_g74632 = color48_g74632;
				float4 color51_g74632 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74632 = 0;
				if( Resolution44_g74632 >= 4096.0 )
				ifLocalVar52_g74632 = color51_g74632;
				float4 ifLocalVar40_g74610 = 0;
				if( Debug_Index464_g73574 == 4.0 )
				ifLocalVar40_g74610 = ( ifLocalVar61_g74632 + ifLocalVar56_g74632 + ifLocalVar40_g74632 + ifLocalVar47_g74632 + ifLocalVar52_g74632 );
				float Resolution44_g74634 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g74634 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74634 = 0;
				if( Resolution44_g74634 <= 256.0 )
				ifLocalVar61_g74634 = color62_g74634;
				float4 color55_g74634 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74634 = 0;
				if( Resolution44_g74634 == 512.0 )
				ifLocalVar56_g74634 = color55_g74634;
				float4 color42_g74634 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74634 = 0;
				if( Resolution44_g74634 == 1024.0 )
				ifLocalVar40_g74634 = color42_g74634;
				float4 color48_g74634 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74634 = 0;
				if( Resolution44_g74634 == 2048.0 )
				ifLocalVar47_g74634 = color48_g74634;
				float4 color51_g74634 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74634 = 0;
				if( Resolution44_g74634 >= 4096.0 )
				ifLocalVar52_g74634 = color51_g74634;
				float4 ifLocalVar40_g74611 = 0;
				if( Debug_Index464_g73574 == 5.0 )
				ifLocalVar40_g74611 = ( ifLocalVar61_g74634 + ifLocalVar56_g74634 + ifLocalVar40_g74634 + ifLocalVar47_g74634 + ifLocalVar52_g74634 );
				float Resolution44_g74631 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 color62_g74631 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74631 = 0;
				if( Resolution44_g74631 <= 256.0 )
				ifLocalVar61_g74631 = color62_g74631;
				float4 color55_g74631 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74631 = 0;
				if( Resolution44_g74631 == 512.0 )
				ifLocalVar56_g74631 = color55_g74631;
				float4 color42_g74631 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74631 = 0;
				if( Resolution44_g74631 == 1024.0 )
				ifLocalVar40_g74631 = color42_g74631;
				float4 color48_g74631 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74631 = 0;
				if( Resolution44_g74631 == 2048.0 )
				ifLocalVar47_g74631 = color48_g74631;
				float4 color51_g74631 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74631 = 0;
				if( Resolution44_g74631 >= 4096.0 )
				ifLocalVar52_g74631 = color51_g74631;
				float4 ifLocalVar40_g74613 = 0;
				if( Debug_Index464_g73574 == 6.0 )
				ifLocalVar40_g74613 = ( ifLocalVar61_g74631 + ifLocalVar56_g74631 + ifLocalVar40_g74631 + ifLocalVar47_g74631 + ifLocalVar52_g74631 );
				float4 Output_Resolution737_g73574 = ( ( ifLocalVar40_g73695 + ifLocalVar40_g73693 + ifLocalVar40_g73694 ) + ( ifLocalVar40_g74612 + ifLocalVar40_g74610 + ifLocalVar40_g74611 ) + ifLocalVar40_g74613 );
				float4 ifLocalVar40_g74586 = 0;
				if( Debug_Type367_g73574 == 4.0 )
				ifLocalVar40_g74586 = Output_Resolution737_g73574;
				float2 uv_MainAlbedoTex = IN.ase_texcoord10.xy * _MainAlbedoTex_ST.xy + _MainAlbedoTex_ST.zw;
				float2 UVs72_g74639 = Main_UVs1219_g73574;
				float Resolution44_g74639 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g74639 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74639 * ( Resolution44_g74639 / 8.0 ) ) );
				float4 lerpResult78_g74639 = lerp( tex2D( _MainAlbedoTex, uv_MainAlbedoTex ) , tex2DNode77_g74639 , tex2DNode77_g74639.a);
				float4 ifLocalVar40_g74585 = 0;
				if( Debug_Index464_g73574 == 0.0 )
				ifLocalVar40_g74585 = lerpResult78_g74639;
				float2 uv_MainNormalTex = IN.ase_texcoord10.xy * _MainNormalTex_ST.xy + _MainNormalTex_ST.zw;
				float2 UVs72_g74630 = Main_UVs1219_g73574;
				float Resolution44_g74630 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 tex2DNode77_g74630 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74630 * ( Resolution44_g74630 / 8.0 ) ) );
				float4 lerpResult78_g74630 = lerp( tex2D( _MainNormalTex, uv_MainNormalTex ) , tex2DNode77_g74630 , tex2DNode77_g74630.a);
				float4 ifLocalVar40_g74583 = 0;
				if( Debug_Index464_g73574 == 1.0 )
				ifLocalVar40_g74583 = lerpResult78_g74630;
				float2 uv_MainMaskTex = IN.ase_texcoord10.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
				float2 UVs72_g74629 = Main_UVs1219_g73574;
				float Resolution44_g74629 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 tex2DNode77_g74629 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74629 * ( Resolution44_g74629 / 8.0 ) ) );
				float4 lerpResult78_g74629 = lerp( tex2D( _MainMaskTex, uv_MainMaskTex ) , tex2DNode77_g74629 , tex2DNode77_g74629.a);
				float4 ifLocalVar40_g74584 = 0;
				if( Debug_Index464_g73574 == 2.0 )
				ifLocalVar40_g74584 = lerpResult78_g74629;
				float2 uv_SecondAlbedoTex = IN.ase_texcoord10.xy * _SecondAlbedoTex_ST.xy + _SecondAlbedoTex_ST.zw;
				float2 UVs72_g74637 = Second_UVs1234_g73574;
				float Resolution44_g74637 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g74637 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74637 * ( Resolution44_g74637 / 8.0 ) ) );
				float4 lerpResult78_g74637 = lerp( tex2D( _SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g74637 , tex2DNode77_g74637.a);
				float4 ifLocalVar40_g74620 = 0;
				if( Debug_Index464_g73574 == 3.0 )
				ifLocalVar40_g74620 = lerpResult78_g74637;
				float2 uv_SecondMaskTex = IN.ase_texcoord10.xy * _SecondMaskTex_ST.xy + _SecondMaskTex_ST.zw;
				float2 UVs72_g74636 = Second_UVs1234_g73574;
				float Resolution44_g74636 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 tex2DNode77_g74636 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74636 * ( Resolution44_g74636 / 8.0 ) ) );
				float4 lerpResult78_g74636 = lerp( tex2D( _SecondMaskTex, uv_SecondMaskTex ) , tex2DNode77_g74636 , tex2DNode77_g74636.a);
				float4 ifLocalVar40_g74618 = 0;
				if( Debug_Index464_g73574 == 4.0 )
				ifLocalVar40_g74618 = lerpResult78_g74636;
				float2 UVs72_g74638 = Second_UVs1234_g73574;
				float Resolution44_g74638 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g74638 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74638 * ( Resolution44_g74638 / 8.0 ) ) );
				float4 lerpResult78_g74638 = lerp( tex2D( _SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g74638 , tex2DNode77_g74638.a);
				float4 ifLocalVar40_g74619 = 0;
				if( Debug_Index464_g73574 == 5.0 )
				ifLocalVar40_g74619 = lerpResult78_g74638;
				float2 uv_EmissiveTex = IN.ase_texcoord10.xy * _EmissiveTex_ST.xy + _EmissiveTex_ST.zw;
				float2 UVs72_g74635 = Emissive_UVs1245_g73574;
				float Resolution44_g74635 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 tex2DNode77_g74635 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74635 * ( Resolution44_g74635 / 8.0 ) ) );
				float4 lerpResult78_g74635 = lerp( tex2D( _EmissiveTex, uv_EmissiveTex ) , tex2DNode77_g74635 , tex2DNode77_g74635.a);
				float4 ifLocalVar40_g74621 = 0;
				if( Debug_Index464_g73574 == 6.0 )
				ifLocalVar40_g74621 = lerpResult78_g74635;
				float4 Output_MipLevel1284_g73574 = ( ( ifLocalVar40_g74585 + ifLocalVar40_g74583 + ifLocalVar40_g74584 ) + ( ifLocalVar40_g74620 + ifLocalVar40_g74618 + ifLocalVar40_g74619 ) + ifLocalVar40_g74621 );
				float4 ifLocalVar40_g74589 = 0;
				if( Debug_Type367_g73574 == 5.0 )
				ifLocalVar40_g74589 = Output_MipLevel1284_g73574;
				float3 WorldPosition893_g73574 = worldPos;
				half3 Input_Position419_g73645 = WorldPosition893_g73574;
				float Input_MotionScale287_g73645 = ( _MotionScale_10 + 0.2 );
				half Global_Scale448_g73645 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g73645 = (( Input_Position419_g73645 * Input_MotionScale287_g73645 * Global_Scale448_g73645 * 0.0075 )).xz;
				float4 temp_output_91_19_g73685 = TVE_MotionCoords;
				float4x4 break19_g73682 = unity_ObjectToWorld;
				float3 appendResult20_g73682 = (float3(break19_g73682[ 0 ][ 3 ] , break19_g73682[ 1 ][ 3 ] , break19_g73682[ 2 ][ 3 ]));
				float3 appendResult60_g73681 = (float3(IN.ase_texcoord12.x , IN.ase_texcoord12.z , IN.ase_texcoord12.y));
				float3 temp_output_122_0_g73682 = ( appendResult60_g73681 * _VertexPivotMode );
				float3 PivotsOnly105_g73682 = (mul( unity_ObjectToWorld, float4( temp_output_122_0_g73682 , 0.0 ) ).xyz).xyz;
				half3 ObjectData20_g73683 = ( appendResult20_g73682 + PivotsOnly105_g73682 );
				half3 WorldData19_g73683 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g73683 = WorldData19_g73683;
				#else
				float3 staticSwitch14_g73683 = ObjectData20_g73683;
				#endif
				float3 temp_output_114_0_g73682 = staticSwitch14_g73683;
				half3 ObjectData20_g73607 = temp_output_114_0_g73682;
				half3 WorldData19_g73607 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g73607 = WorldData19_g73607;
				#else
				float3 staticSwitch14_g73607 = ObjectData20_g73607;
				#endif
				float3 ObjectPosition890_g73574 = staticSwitch14_g73607;
				half2 UV94_g73685 = ( (temp_output_91_19_g73685).zw + ( (temp_output_91_19_g73685).xy * (ObjectPosition890_g73574).xz ) );
				float Debug_Layer885_g73574 = TVE_DEBUG_Layer;
				float temp_output_84_0_g73685 = Debug_Layer885_g73574;
				float4 lerpResult107_g73685 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g73685,temp_output_84_0_g73685), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g73685]);
				float4 break322_g73680 = lerpResult107_g73685;
				float2 appendResult433_g73680 = (float2(break322_g73680.x , break322_g73680.y));
				float2 temp_output_436_0_g73680 = (appendResult433_g73680*2.0 + -1.0);
				half2 Wind_DirectionWS1031_g73574 = temp_output_436_0_g73680;
				half2 Input_DirectionWS423_g73645 = Wind_DirectionWS1031_g73574;
				half Input_MotionSpeed62_g73645 = _MotionSpeed_10;
				half Global_Speed449_g73645 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g73645 = _MotionVariation_10;
				float3 break111_g73689 = ObjectPosition890_g73574;
				half Input_DynamicMode120_g73689 = _VertexDynamicMode;
				half Input_Variation124_g73689 = IN.ase_color.r;
				half ObjectData20_g73690 = frac( ( ( ( break111_g73689.x + break111_g73689.y + break111_g73689.z + 0.001275 ) * ( 1.0 - Input_DynamicMode120_g73689 ) ) + Input_Variation124_g73689 ) );
				half WorldData19_g73690 = Input_Variation124_g73689;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g73690 = WorldData19_g73690;
				#else
				float staticSwitch14_g73690 = ObjectData20_g73690;
				#endif
				float clampResult129_g73689 = clamp( staticSwitch14_g73690 , 0.01 , 0.99 );
				half Global_MeshVariation1176_g73574 = clampResult129_g73689;
				half Input_GlobalVariation569_g73645 = Global_MeshVariation1176_g73574;
				float temp_output_630_0_g73645 = ( ( ( _Time.y * Input_MotionSpeed62_g73645 * Global_Speed449_g73645 ) + ( Input_MotionVariation284_g73645 * Input_GlobalVariation569_g73645 ) ) * 0.03 );
				float temp_output_607_0_g73645 = frac( temp_output_630_0_g73645 );
				float4 lerpResult590_g73645 = lerp( tex2D( TVE_NoiseTex, ( temp_output_597_0_g73645 + ( -Input_DirectionWS423_g73645 * temp_output_607_0_g73645 ) ) ) , tex2D( TVE_NoiseTex, ( temp_output_597_0_g73645 + ( -Input_DirectionWS423_g73645 * frac( ( temp_output_630_0_g73645 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_607_0_g73645 - 0.5 ) ) / 0.5 ));
				half2 Motion_Noise915_g73574 = ((lerpResult590_g73645).rg*2.0 + -1.0);
				float3 appendResult1180_g73574 = (float3(Motion_Noise915_g73574 , 0.0));
				float3 ifLocalVar40_g73586 = 0;
				if( Debug_Index464_g73574 == 0.0 )
				ifLocalVar40_g73586 = appendResult1180_g73574;
				float4 temp_output_91_19_g73635 = TVE_ColorsCoords;
				half2 UV94_g73635 = ( (temp_output_91_19_g73635).zw + ( (temp_output_91_19_g73635).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_82_0_g73635 = Debug_Layer885_g73574;
				float4 lerpResult108_g73635 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g73635,temp_output_82_0_g73635), 0.0 ) , TVE_ColorsUsage[(int)temp_output_82_0_g73635]);
				float3 ifLocalVar40_g73606 = 0;
				if( Debug_Index464_g73574 == 1.0 )
				ifLocalVar40_g73606 = (lerpResult108_g73635).rgb;
				float4 temp_output_91_19_g73623 = TVE_ColorsCoords;
				half2 UV94_g73623 = ( (temp_output_91_19_g73623).zw + ( (temp_output_91_19_g73623).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_82_0_g73623 = Debug_Layer885_g73574;
				float4 lerpResult108_g73623 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g73623,temp_output_82_0_g73623), 0.0 ) , TVE_ColorsUsage[(int)temp_output_82_0_g73623]);
				float ifLocalVar40_g73619 = 0;
				if( Debug_Index464_g73574 == 2.0 )
				ifLocalVar40_g73619 = saturate( (lerpResult108_g73623).a );
				float4 temp_output_93_19_g73631 = TVE_ExtrasCoords;
				half2 UV96_g73631 = ( (temp_output_93_19_g73631).zw + ( (temp_output_93_19_g73631).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73631 = Debug_Layer885_g73574;
				float4 lerpResult109_g73631 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g73631,temp_output_84_0_g73631), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g73631]);
				float ifLocalVar40_g73595 = 0;
				if( Debug_Index464_g73574 == 3.0 )
				ifLocalVar40_g73595 = (lerpResult109_g73631).r;
				float4 temp_output_93_19_g73577 = TVE_ExtrasCoords;
				half2 UV96_g73577 = ( (temp_output_93_19_g73577).zw + ( (temp_output_93_19_g73577).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73577 = Debug_Layer885_g73574;
				float4 lerpResult109_g73577 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g73577,temp_output_84_0_g73577), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g73577]);
				float ifLocalVar40_g73678 = 0;
				if( Debug_Index464_g73574 == 4.0 )
				ifLocalVar40_g73678 = (lerpResult109_g73577).g;
				float4 temp_output_93_19_g73641 = TVE_ExtrasCoords;
				half2 UV96_g73641 = ( (temp_output_93_19_g73641).zw + ( (temp_output_93_19_g73641).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73641 = Debug_Layer885_g73574;
				float4 lerpResult109_g73641 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g73641,temp_output_84_0_g73641), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g73641]);
				float ifLocalVar40_g73596 = 0;
				if( Debug_Index464_g73574 == 5.0 )
				ifLocalVar40_g73596 = (lerpResult109_g73641).b;
				float4 temp_output_93_19_g73668 = TVE_ExtrasCoords;
				half2 UV96_g73668 = ( (temp_output_93_19_g73668).zw + ( (temp_output_93_19_g73668).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73668 = Debug_Layer885_g73574;
				float4 lerpResult109_g73668 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g73668,temp_output_84_0_g73668), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g73668]);
				float ifLocalVar40_g73590 = 0;
				if( Debug_Index464_g73574 == 6.0 )
				ifLocalVar40_g73590 = saturate( (lerpResult109_g73668).a );
				float4 temp_output_91_19_g73627 = TVE_MotionCoords;
				half2 UV94_g73627 = ( (temp_output_91_19_g73627).zw + ( (temp_output_91_19_g73627).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73627 = Debug_Layer885_g73574;
				float4 lerpResult107_g73627 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g73627,temp_output_84_0_g73627), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g73627]);
				float3 appendResult1012_g73574 = (float3((lerpResult107_g73627).rg , 0.0));
				float3 ifLocalVar40_g73583 = 0;
				if( Debug_Index464_g73574 == 7.0 )
				ifLocalVar40_g73583 = appendResult1012_g73574;
				float4 temp_output_91_19_g73653 = TVE_MotionCoords;
				half2 UV94_g73653 = ( (temp_output_91_19_g73653).zw + ( (temp_output_91_19_g73653).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73653 = Debug_Layer885_g73574;
				float4 lerpResult107_g73653 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g73653,temp_output_84_0_g73653), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g73653]);
				float ifLocalVar40_g73599 = 0;
				if( Debug_Index464_g73574 == 8.0 )
				ifLocalVar40_g73599 = (lerpResult107_g73653).b;
				float4 temp_output_91_19_g73661 = TVE_MotionCoords;
				half2 UV94_g73661 = ( (temp_output_91_19_g73661).zw + ( (temp_output_91_19_g73661).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73661 = Debug_Layer885_g73574;
				float4 lerpResult107_g73661 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g73661,temp_output_84_0_g73661), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g73661]);
				float ifLocalVar40_g73665 = 0;
				if( Debug_Index464_g73574 == 9.0 )
				ifLocalVar40_g73665 = saturate( (lerpResult107_g73661).a );
				float4 temp_output_94_19_g73673 = TVE_VertexCoords;
				half2 UV97_g73673 = ( (temp_output_94_19_g73673).zw + ( (temp_output_94_19_g73673).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73673 = Debug_Layer885_g73574;
				float4 lerpResult109_g73673 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g73673,temp_output_84_0_g73673), 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g73673]);
				float ifLocalVar40_g73613 = 0;
				if( Debug_Index464_g73574 == 10.0 )
				ifLocalVar40_g73613 = saturate( (lerpResult109_g73673).a );
				float temp_output_7_0_g73692 = Debug_Min721_g73574;
				float3 temp_cast_29 = (temp_output_7_0_g73692).xxx;
				float3 Output_Globals888_g73574 = saturate( ( ( ( ifLocalVar40_g73586 + ( ifLocalVar40_g73606 + ifLocalVar40_g73619 ) + ( ifLocalVar40_g73595 + ifLocalVar40_g73678 + ifLocalVar40_g73596 + ifLocalVar40_g73590 ) + ( ifLocalVar40_g73583 + ifLocalVar40_g73599 + ifLocalVar40_g73665 ) + ( ifLocalVar40_g73613 + 0.0 ) ) - temp_cast_29 ) / ( Debug_Max723_g73574 - temp_output_7_0_g73692 ) ) );
				float3 ifLocalVar40_g74590 = 0;
				if( Debug_Type367_g73574 == 8.0 )
				ifLocalVar40_g74590 = Output_Globals888_g73574;
				float4 color1086_g73574 = IsGammaSpace() ? float4(0.1226415,0.1226415,0.1226415,0) : float4(0.01390275,0.01390275,0.01390275,0);
				float4 vertexToFrag11_g73576 = IN.ase_texcoord13;
				float _IsVegetationShader1101_g73574 = _IsVegetationShader;
				float4 lerpResult1089_g73574 = lerp( color1086_g73574 , vertexToFrag11_g73576 , ( _IsPolygonalShader1112_g73574 * _IsVegetationShader1101_g73574 ));
				float3 Output_Misc1080_g73574 = (lerpResult1089_g73574).rgb;
				float3 ifLocalVar40_g74591 = 0;
				if( Debug_Type367_g73574 == 9.0 )
				ifLocalVar40_g74591 = Output_Misc1080_g73574;
				float3 vertexToFrag328_g73574 = IN.ase_texcoord9.yzw;
				float4 color1016_g73574 = IsGammaSpace() ? float4(0.5831653,0.6037736,0.2135992,0) : float4(0.2992498,0.3229691,0.03750122,0);
				float4 color1017_g73574 = IsGammaSpace() ? float4(0.8117647,0.3488252,0.2627451,0) : float4(0.6239604,0.0997834,0.05612849,0);
				float4 switchResult1015_g73574 = (((ase_vface>0)?(color1016_g73574):(color1017_g73574)));
				float3 ifLocalVar40_g73588 = 0;
				if( Debug_Index464_g73574 == 4.0 )
				ifLocalVar40_g73588 = (switchResult1015_g73574).rgb;
				float temp_output_7_0_g73691 = Debug_Min721_g73574;
				float3 temp_cast_32 = (temp_output_7_0_g73691).xxx;
				float3 Output_Mesh316_g73574 = saturate( ( ( ( vertexToFrag328_g73574 + ifLocalVar40_g73588 ) - temp_cast_32 ) / ( Debug_Max723_g73574 - temp_output_7_0_g73691 ) ) );
				float3 ifLocalVar40_g74592 = 0;
				if( Debug_Type367_g73574 == 10.0 )
				ifLocalVar40_g74592 = Output_Mesh316_g73574;
				float4 temp_output_459_0_g73574 = ( ifLocalVar40_g73600 + ifLocalVar40_g73677 + ifLocalVar40_g73658 + ifLocalVar40_g73651 + ifLocalVar40_g74586 + ifLocalVar40_g74589 + float4( ifLocalVar40_g74590 , 0.0 ) + float4( ifLocalVar40_g74591 , 0.0 ) + float4( ifLocalVar40_g74592 , 0.0 ) );
				float4 color690_g73574 = IsGammaSpace() ? float4(0.1226415,0.1226415,0.1226415,0) : float4(0.01390275,0.01390275,0.01390275,0);
				float _IsTVEShader647_g73574 = _IsTVEShader;
				float4 lerpResult689_g73574 = lerp( color690_g73574 , temp_output_459_0_g73574 , _IsTVEShader647_g73574);
				float Debug_Filter322_g73574 = TVE_DEBUG_Filter;
				float4 lerpResult326_g73574 = lerp( temp_output_459_0_g73574 , lerpResult689_g73574 , Debug_Filter322_g73574);
				float Debug_Clip623_g73574 = TVE_DEBUG_Clip;
				float lerpResult622_g73574 = lerp( 1.0 , tex2D( _MainAlbedoTex, uv_MainAlbedoTex ).a , ( Debug_Clip623_g73574 * _RenderClip ));
				clip( lerpResult622_g73574 - _Cutoff);
				clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
				
				o.Albedo = fixed3( 0.5, 0.5, 0.5 );
				o.Normal = fixed3( 0, 0, 1 );
				o.Emission = lerpResult326_g73574.rgb;
				#if defined(_SPECULAR_SETUP)
					o.Specular = fixed3( 0, 0, 0 );
				#else
					o.Metallic = 0;
				#endif
				o.Smoothness = 0;
				o.Occlusion = 1;
				o.Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;				

				#ifdef _ALPHATEST_ON
					clip( o.Alpha - AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
					outputDepth = IN.pos.z;
				#endif

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				fixed4 c = 0;
				float3 worldN;
				worldN.x = dot(IN.tSpace0.xyz, o.Normal);
				worldN.y = dot(IN.tSpace1.xyz, o.Normal);
				worldN.z = dot(IN.tSpace2.xyz, o.Normal);
				worldN = normalize(worldN);
				o.Normal = worldN;

				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
				gi.indirect.diffuse = 0;
				gi.indirect.specular = 0;
				gi.light.color = _LightColor0.rgb;
				gi.light.dir = lightDir;

				UnityGIInput giInput;
				UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
				giInput.light = gi.light;
				giInput.worldPos = worldPos;
				giInput.worldViewDir = worldViewDir;
				giInput.atten = atten;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					giInput.lightmapUV = IN.lmap;
				#else
					giInput.lightmapUV = 0.0;
				#endif
				#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					giInput.ambient = IN.sh;
				#else
					giInput.ambient.rgb = 0.0;
				#endif
				giInput.probeHDR[0] = unity_SpecCube0_HDR;
				giInput.probeHDR[1] = unity_SpecCube1_HDR;
				#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
					giInput.boxMin[0] = unity_SpecCube0_BoxMin;
				#endif
				#ifdef UNITY_SPECCUBE_BOX_PROJECTION
					giInput.boxMax[0] = unity_SpecCube0_BoxMax;
					giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
					giInput.boxMax[1] = unity_SpecCube1_BoxMax;
					giInput.boxMin[1] = unity_SpecCube1_BoxMin;
					giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
				#endif
				
				#if defined(_SPECULAR_SETUP)
					LightingStandardSpecular_GI(o, giInput, gi);
				#else
					LightingStandard_GI( o, giInput, gi );
				#endif

				#ifdef ASE_BAKEDGI
					gi.indirect.diffuse = BakedGI;
				#endif

				#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
					gi.indirect.diffuse = 0;
				#endif

				#if defined(_SPECULAR_SETUP)
					c += LightingStandardSpecular (o, worldViewDir, gi);
				#else
					c += LightingStandard( o, worldViewDir, gi );
				#endif
				
				#ifdef _TRANSMISSION_ASE
				{
					float shadow = _TransmissionShadow;
					#ifdef DIRECTIONAL
						float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
					#else
						float3 lightAtten = gi.light.color;
					#endif
					half3 transmission = max(0 , -dot(o.Normal, gi.light.dir)) * lightAtten * Transmission;
					c.rgb += o.Albedo * transmission;
				}
				#endif

				#ifdef _TRANSLUCENCY_ASE
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					#ifdef DIRECTIONAL
						float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
					#else
						float3 lightAtten = gi.light.color;
					#endif
					half3 lightDir = gi.light.dir + o.Normal * normal;
					half transVdotL = pow( saturate( dot( worldViewDir, -lightDir ) ), scattering );
					half3 translucency = lightAtten * (transVdotL * direct + gi.indirect.diffuse * ambient) * Translucency;
					c.rgb += o.Albedo * translucency * strength;
				}
				#endif

				//#ifdef _REFRACTION_ASE
				//	float4 projScreenPos = ScreenPos / ScreenPos.w;
				//	float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, WorldNormal ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
				//	projScreenPos.xy += refractionOffset.xy;
				//	float3 refraction = UNITY_SAMPLE_SCREENSPACE_TEXTURE( _GrabTexture, projScreenPos ) * RefractionColor;
				//	color.rgb = lerp( refraction, color.rgb, color.a );
				//	color.a = 1;
				//#endif

				c.rgb += o.Emission;

				#ifdef ASE_FOG
					UNITY_APPLY_FOG(IN.fogCoord, c);
				#endif
				return c;
			}
			ENDCG
		}

		
		Pass
		{
			
			Name "Deferred"
			Tags { "LightMode"="Deferred" }

			AlphaToMask Off

			CGPROGRAM
			#define ASE_NO_AMBIENT 1

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma exclude_renderers nomrt 
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#pragma multi_compile_prepassfinal
			#ifndef UNITY_PASS_DEFERRED
				#define UNITY_PASS_DEFERRED
			#endif
			#include "HLSLSupport.cginc"
			#if !defined( UNITY_INSTANCED_LOD_FADE )
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#if !defined( UNITY_INSTANCED_SH )
				#define UNITY_INSTANCED_SH
			#endif
			#if !defined( UNITY_INSTANCED_LIGHTMAPSTS )
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
			#endif//ASE Sampling Macros
			

			struct appdata {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f {
				#if UNITY_VERSION >= 201810
					UNITY_POSITION(pos);
				#else
					float4 pos : SV_POSITION;
				#endif
				float4 lmap : TEXCOORD2;
				#ifndef LIGHTMAP_ON
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						half3 sh : TEXCOORD3;
					#endif
				#else
					#ifdef DIRLIGHTMAP_OFF
						float4 lmapFadePos : TEXCOORD4;
					#endif
				#endif
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
				float4 ase_color : COLOR;
				float4 ase_texcoord12 : TEXCOORD12;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			#ifdef LIGHTMAP_ON
			float4 unity_LightmapFade;
			#endif
			fixed4 unity_Ambient;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			uniform half _Banner;
			uniform half _Message;
			uniform float _IsSimpleShader;
			uniform float _IsVertexShader;
			uniform half _IsTVEShader;
			uniform half TVE_DEBUG_Type;
			uniform float _IsBarkShader;
			uniform float _IsCrossShader;
			uniform float _IsGrassShader;
			uniform float _IsLeafShader;
			uniform float _IsPropShader;
			uniform float _IsImpostorShader;
			uniform float _IsPolygonalShader;
			uniform float _IsStandardShader;
			uniform float _IsSubsurfaceShader;
			uniform half TVE_DEBUG_Index;
			uniform sampler2D _MainAlbedoTex;
			uniform half4 _MainUVs;
			uniform sampler2D _MainNormalTex;
			uniform sampler2D _MainMaskTex;
			uniform sampler2D _SecondAlbedoTex;
			uniform half _DetailCoordMode;
			uniform half4 _SecondUVs;
			uniform sampler2D _SecondNormalTex;
			uniform sampler2D _SecondMaskTex;
			uniform float _DetailMode;
			uniform sampler2D _EmissiveTex;
			uniform half4 _EmissiveUVs;
			uniform float4 _EmissiveColor;
			uniform float _EmissiveCat;
			uniform half TVE_DEBUG_Min;
			uniform half TVE_DEBUG_Max;
			float4 _MainAlbedoTex_TexelSize;
			float4 _MainNormalTex_TexelSize;
			float4 _MainMaskTex_TexelSize;
			float4 _SecondAlbedoTex_TexelSize;
			float4 _SecondMaskTex_TexelSize;
			float4 _EmissiveTex_TexelSize;
			uniform float4 _MainAlbedoTex_ST;
			uniform sampler2D TVE_DEBUG_MipTex;
			uniform float4 _MainNormalTex_ST;
			uniform float4 _MainMaskTex_ST;
			uniform float4 _SecondAlbedoTex_ST;
			uniform float4 _SecondMaskTex_ST;
			uniform float4 _EmissiveTex_ST;
			uniform sampler2D TVE_NoiseTex;
			uniform float _MotionScale_10;
			uniform half4 TVE_NoiseParams;
			uniform half4 TVE_MotionParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
			uniform half4 TVE_MotionCoords;
			uniform half _VertexPivotMode;
			uniform half TVE_DEBUG_Layer;
			SamplerState sampler_Linear_Clamp;
			uniform float TVE_MotionUsage[10];
			uniform float _MotionSpeed_10;
			uniform float _MotionVariation_10;
			uniform half _VertexDynamicMode;
			uniform half4 TVE_ColorsParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
			uniform half4 TVE_ColorsCoords;
			uniform float TVE_ColorsUsage[10];
			uniform half4 TVE_ExtrasParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
			uniform half4 TVE_ExtrasCoords;
			uniform float TVE_ExtrasUsage[10];
			uniform half4 TVE_VertexParams;
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertexTex);
			uniform half4 TVE_VertexCoords;
			uniform float TVE_VertexUsage[10];
			uniform half4 _LeavesFilterColor;
			uniform half4 _MainColor;
			uniform half _VertexColorMode;
			uniform float _LeavesFilterRange;
			uniform half _LeavesFilterMode;
			uniform float _IsVegetationShader;
			uniform half TVE_DEBUG_Filter;
			uniform half TVE_DEBUG_Clip;
			uniform float _RenderClip;
			uniform float _Cutoff;
			uniform float _IsElementShader;
			uniform float _IsHelperShader;

	
			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			

			v2f VertexFunction (appdata v  ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 customSurfaceDepth676_g73574 = v.vertex.xyz;
				float customEye676_g73574 = -UnityObjectToViewPos( customSurfaceDepth676_g73574 ).z;
				o.ase_texcoord8.x = customEye676_g73574;
				float4 color1097_g73574 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 color1096_g73574 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float2 uv_MainMaskTex1077_g73574 = v.ase_texcoord.xy;
				float3 linearToGamma1066_g73574 = LinearToGammaSpace( _LeavesFilterColor.rgb );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch1060_g73574 = (_LeavesFilterColor).rgb;
				#else
				float3 staticSwitch1060_g73574 = linearToGamma1066_g73574;
				#endif
				float2 uv_MainAlbedoTex1045_g73574 = v.ase_texcoord.xy;
				float4 tex2DNode1045_g73574 = tex2Dlod( _MainAlbedoTex, float4( uv_MainAlbedoTex1045_g73574, 0, 0.0) );
				float3 lerpResult1043_g73574 = lerp( (tex2DNode1045_g73574).rgb , (v.ase_color).rgb , _VertexColorMode);
				half3 Main_Albedo1078_g73574 = ( (_MainColor).rgb * lerpResult1043_g73574 );
				float3 linearToGamma1058_g73574 = LinearToGammaSpace( Main_Albedo1078_g73574 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float3 staticSwitch1068_g73574 = (Main_Albedo1078_g73574).xyz;
				#else
				float3 staticSwitch1068_g73574 = linearToGamma1058_g73574;
				#endif
				float lerpResult1071_g73574 = lerp( 1.0 , saturate( ( 1.0 - ceil( ( distance( staticSwitch1060_g73574 , staticSwitch1068_g73574 ) - _LeavesFilterRange ) ) ) ) , _LeavesFilterMode);
				half Main_ColorFilter1061_g73574 = lerpResult1071_g73574;
				float4 lerpResult1095_g73574 = lerp( color1097_g73574 , color1096_g73574 , ( tex2Dlod( _MainMaskTex, float4( uv_MainMaskTex1077_g73574, 0, 0.0) ).b * Main_ColorFilter1061_g73574 ));
				float4 vertexToFrag11_g73576 = lerpResult1095_g73574;
				o.ase_texcoord12 = vertexToFrag11_g73576;
				float Debug_Index464_g73574 = TVE_DEBUG_Index;
				float3 ifLocalVar40_g73581 = 0;
				if( Debug_Index464_g73574 == 0.0 )
				ifLocalVar40_g73581 = saturate( v.vertex.xyz );
				float3 ifLocalVar40_g73605 = 0;
				if( Debug_Index464_g73574 == 1.0 )
				ifLocalVar40_g73605 = v.normal;
				float3 ifLocalVar40_g73622 = 0;
				if( Debug_Index464_g73574 == 2.0 )
				ifLocalVar40_g73622 = v.tangent.xyz;
				float ifLocalVar40_g73598 = 0;
				if( Debug_Index464_g73574 == 3.0 )
				ifLocalVar40_g73598 = saturate( v.tangent.w );
				float3 temp_cast_2 = (v.ase_color.r).xxx;
				float3 hsvTorgb260_g73574 = HSVToRGB( float3(v.ase_color.r,1.0,1.0) );
				float3 gammaToLinear266_g73574 = GammaToLinearSpace( hsvTorgb260_g73574 );
				float _IsBarkShader347_g73574 = _IsBarkShader;
				float _IsLeafShader360_g73574 = _IsLeafShader;
				float _IsCrossShader342_g73574 = _IsCrossShader;
				float _IsGrassShader341_g73574 = _IsGrassShader;
				float _IsVegetationShader1101_g73574 = _IsVegetationShader;
				float _IsAnyVegetationShader362_g73574 = saturate( ( _IsBarkShader347_g73574 + _IsLeafShader360_g73574 + _IsCrossShader342_g73574 + _IsGrassShader341_g73574 + _IsVegetationShader1101_g73574 ) );
				float3 lerpResult290_g73574 = lerp( temp_cast_2 , gammaToLinear266_g73574 , _IsAnyVegetationShader362_g73574);
				float3 ifLocalVar40_g73620 = 0;
				if( Debug_Index464_g73574 == 5.0 )
				ifLocalVar40_g73620 = lerpResult290_g73574;
				float ifLocalVar40_g73659 = 0;
				if( Debug_Index464_g73574 == 6.0 )
				ifLocalVar40_g73659 = v.ase_color.g;
				float ifLocalVar40_g73589 = 0;
				if( Debug_Index464_g73574 == 7.0 )
				ifLocalVar40_g73589 = v.ase_color.b;
				float ifLocalVar40_g73601 = 0;
				if( Debug_Index464_g73574 == 8.0 )
				ifLocalVar40_g73601 = v.ase_color.a;
				float ifLocalVar40_g73587 = 0;
				if( Debug_Index464_g73574 == 9.0 )
				ifLocalVar40_g73587 = v.ase_color.a;
				float enc1154_g73574 = v.ase_texcoord.z;
				float2 localDecodeFloatToVector21154_g73574 = DecodeFloatToVector2( enc1154_g73574 );
				float2 break1155_g73574 = localDecodeFloatToVector21154_g73574;
				float ifLocalVar40_g73604 = 0;
				if( Debug_Index464_g73574 == 10.0 )
				ifLocalVar40_g73604 = break1155_g73574.x;
				float ifLocalVar40_g73603 = 0;
				if( Debug_Index464_g73574 == 11.0 )
				ifLocalVar40_g73603 = break1155_g73574.y;
				float3 appendResult1147_g73574 = (float3(v.ase_texcoord.x , v.ase_texcoord.y , 0.0));
				float3 ifLocalVar40_g73584 = 0;
				if( Debug_Index464_g73574 == 12.0 )
				ifLocalVar40_g73584 = appendResult1147_g73574;
				float3 appendResult1148_g73574 = (float3(v.texcoord1.xyzw.x , v.texcoord1.xyzw.y , 0.0));
				float3 ifLocalVar40_g73608 = 0;
				if( Debug_Index464_g73574 == 13.0 )
				ifLocalVar40_g73608 = appendResult1148_g73574;
				float3 appendResult1149_g73574 = (float3(v.texcoord1.xyzw.z , v.texcoord1.xyzw.w , 0.0));
				float3 ifLocalVar40_g73610 = 0;
				if( Debug_Index464_g73574 == 14.0 )
				ifLocalVar40_g73610 = appendResult1149_g73574;
				float3 appendResult60_g73660 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
				float3 ifLocalVar40_g73575 = 0;
				if( Debug_Index464_g73574 == 15.0 )
				ifLocalVar40_g73575 = appendResult60_g73660;
				float3 vertexToFrag328_g73574 = ( ( ifLocalVar40_g73581 + ifLocalVar40_g73605 + ifLocalVar40_g73622 + ifLocalVar40_g73598 ) + ( ifLocalVar40_g73620 + ifLocalVar40_g73659 + ifLocalVar40_g73589 + ifLocalVar40_g73601 ) + ( ifLocalVar40_g73587 + ifLocalVar40_g73604 + ifLocalVar40_g73603 ) + ( ifLocalVar40_g73584 + ifLocalVar40_g73608 + ifLocalVar40_g73610 + ifLocalVar40_g73575 ) );
				o.ase_texcoord8.yzw = vertexToFrag328_g73574;
				
				o.ase_texcoord9 = v.ase_texcoord;
				o.ase_texcoord10 = v.texcoord1.xyzw;
				o.ase_texcoord11 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.vertex.w = 1;
				v.normal = v.normal;
				v.tangent = v.tangent;

				o.pos = UnityObjectToClipPos(v.vertex);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
				o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
				o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
				o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);

				#ifdef DYNAMICLIGHTMAP_ON
					o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#else
					o.lmap.zw = 0;
				#endif
				#ifdef LIGHTMAP_ON
					o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#ifdef DIRLIGHTMAP_OFF
						o.lmapFadePos.xyz = (mul(unity_ObjectToWorld, v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w;
						o.lmapFadePos.w = (-UnityObjectToViewPos(v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w);
					#endif
				#else
					o.lmap.xy = 0;
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						o.sh = 0;
						o.sh = ShadeSHPerVertex (worldNormal, o.sh);
					#endif
				#endif
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( appdata v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.tangent = v.tangent;
				o.normal = v.normal;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				appdata o = (appdata) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
				o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			v2f vert ( appdata v )
			{
				return VertexFunction( v );
			}
			#endif

			void frag (v2f IN , bool ase_vface : SV_IsFrontFace
				, out half4 outGBuffer0 : SV_Target0
				, out half4 outGBuffer1 : SV_Target1
				, out half4 outGBuffer2 : SV_Target2
				, out half4 outEmission : SV_Target3
				#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
				, out half4 outShadowMask : SV_Target4
				#endif
				#ifdef _DEPTHOFFSET_ON
				, out float outputDepth : SV_Depth
				#endif
			) 
			{
				UNITY_SETUP_INSTANCE_ID(IN);

				#ifdef LOD_FADE_CROSSFADE
					UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				#endif

				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif
				float3 WorldTangent = float3(IN.tSpace0.x,IN.tSpace1.x,IN.tSpace2.x);
				float3 WorldBiTangent = float3(IN.tSpace0.y,IN.tSpace1.y,IN.tSpace2.y);
				float3 WorldNormal = float3(IN.tSpace0.z,IN.tSpace1.z,IN.tSpace2.z);
				float3 worldPos = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				half atten = 1;

				float Debug_Type367_g73574 = TVE_DEBUG_Type;
				float4 color646_g73574 = IsGammaSpace() ? float4(0.9245283,0.7969696,0.4142933,1) : float4(0.8368256,0.5987038,0.1431069,1);
				float customEye676_g73574 = IN.ase_texcoord8.x;
				float saferPower688_g73574 = abs( (0.0 + (customEye676_g73574 - 300.0) * (1.0 - 0.0) / (0.0 - 300.0)) );
				float clampResult702_g73574 = clamp( pow( saferPower688_g73574 , 1.25 ) , 0.75 , 1.0 );
				float Shading655_g73574 = clampResult702_g73574;
				float4 Output_Converted717_g73574 = ( color646_g73574 * Shading655_g73574 );
				float4 ifLocalVar40_g73600 = 0;
				if( Debug_Type367_g73574 == 0.0 )
				ifLocalVar40_g73600 = Output_Converted717_g73574;
				float4 color466_g73574 = IsGammaSpace() ? float4(0.8113208,0.4952317,0.264062,0) : float4(0.6231937,0.2096542,0.05668841,0);
				float _IsBarkShader347_g73574 = _IsBarkShader;
				float4 color469_g73574 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsCrossShader342_g73574 = _IsCrossShader;
				float4 color472_g73574 = IsGammaSpace() ? float4(0.7100264,0.8018868,0.2231666,0) : float4(0.4623997,0.6070304,0.0407874,0);
				float _IsGrassShader341_g73574 = _IsGrassShader;
				float4 color475_g73574 = IsGammaSpace() ? float4(0.3267961,0.7264151,0.3118103,0) : float4(0.08721471,0.4865309,0.07922345,0);
				float _IsLeafShader360_g73574 = _IsLeafShader;
				float4 color478_g73574 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsPropShader346_g73574 = _IsPropShader;
				float4 color1114_g73574 = IsGammaSpace() ? float4(0.9716981,0.3162602,0.4816265,0) : float4(0.9368213,0.08154967,0.1974273,0);
				float _IsImpostorShader1110_g73574 = _IsImpostorShader;
				float4 color1117_g73574 = IsGammaSpace() ? float4(0.257921,0.8679245,0.8361252,0) : float4(0.05410501,0.7254258,0.6668791,0);
				float _IsPolygonalShader1112_g73574 = _IsPolygonalShader;
				float4 Output_Shader445_g73574 = ( ( ( color466_g73574 * _IsBarkShader347_g73574 ) + ( color469_g73574 * _IsCrossShader342_g73574 ) + ( color472_g73574 * _IsGrassShader341_g73574 ) + ( color475_g73574 * _IsLeafShader360_g73574 ) + ( color478_g73574 * _IsPropShader346_g73574 ) + ( color1114_g73574 * _IsImpostorShader1110_g73574 ) + ( color1117_g73574 * _IsPolygonalShader1112_g73574 ) ) * Shading655_g73574 );
				float4 ifLocalVar40_g73677 = 0;
				if( Debug_Type367_g73574 == 1.0 )
				ifLocalVar40_g73677 = Output_Shader445_g73574;
				float4 color529_g73574 = IsGammaSpace() ? float4(0.62,0.77,0.15,0) : float4(0.3423916,0.5542217,0.01960665,0);
				float _IsVertexShader1158_g73574 = _IsVertexShader;
				float4 color544_g73574 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsSimpleShader359_g73574 = _IsSimpleShader;
				float4 color521_g73574 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsStandardShader344_g73574 = _IsStandardShader;
				float4 color1121_g73574 = IsGammaSpace() ? float4(0.9245283,0.8421515,0.1788003,0) : float4(0.8368256,0.677754,0.02687956,0);
				float _IsSubsurfaceShader548_g73574 = _IsSubsurfaceShader;
				float4 Output_Lighting525_g73574 = ( ( ( color529_g73574 * _IsVertexShader1158_g73574 ) + ( color544_g73574 * _IsSimpleShader359_g73574 ) + ( color521_g73574 * _IsStandardShader344_g73574 ) + ( color1121_g73574 * _IsSubsurfaceShader548_g73574 ) ) * Shading655_g73574 );
				float4 ifLocalVar40_g73658 = 0;
				if( Debug_Type367_g73574 == 2.0 )
				ifLocalVar40_g73658 = Output_Lighting525_g73574;
				float Debug_Index464_g73574 = TVE_DEBUG_Index;
				half2 Main_UVs1219_g73574 = ( ( IN.ase_texcoord9.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode586_g73574 = tex2D( _MainAlbedoTex, Main_UVs1219_g73574 );
				float3 appendResult637_g73574 = (float3(tex2DNode586_g73574.r , tex2DNode586_g73574.g , tex2DNode586_g73574.b));
				float3 ifLocalVar40_g73602 = 0;
				if( Debug_Index464_g73574 == 0.0 )
				ifLocalVar40_g73602 = appendResult637_g73574;
				float ifLocalVar40_g73612 = 0;
				if( Debug_Index464_g73574 == 1.0 )
				ifLocalVar40_g73612 = tex2D( _MainAlbedoTex, Main_UVs1219_g73574 ).a;
				float4 tex2DNode604_g73574 = tex2D( _MainNormalTex, Main_UVs1219_g73574 );
				float3 appendResult876_g73574 = (float3(tex2DNode604_g73574.a , tex2DNode604_g73574.g , 1.0));
				float3 gammaToLinear878_g73574 = GammaToLinearSpace( appendResult876_g73574 );
				float3 ifLocalVar40_g73639 = 0;
				if( Debug_Index464_g73574 == 2.0 )
				ifLocalVar40_g73639 = gammaToLinear878_g73574;
				float ifLocalVar40_g73585 = 0;
				if( Debug_Index464_g73574 == 3.0 )
				ifLocalVar40_g73585 = tex2D( _MainMaskTex, Main_UVs1219_g73574 ).r;
				float ifLocalVar40_g73679 = 0;
				if( Debug_Index464_g73574 == 4.0 )
				ifLocalVar40_g73679 = tex2D( _MainMaskTex, Main_UVs1219_g73574 ).g;
				float ifLocalVar40_g73614 = 0;
				if( Debug_Index464_g73574 == 5.0 )
				ifLocalVar40_g73614 = tex2D( _MainMaskTex, Main_UVs1219_g73574 ).b;
				float ifLocalVar40_g73582 = 0;
				if( Debug_Index464_g73574 == 6.0 )
				ifLocalVar40_g73582 = tex2D( _MainMaskTex, Main_UVs1219_g73574 ).a;
				float2 appendResult1251_g73574 = (float2(IN.ase_texcoord10.z , IN.ase_texcoord10.w));
				float2 Mesh_DetailCoord1254_g73574 = appendResult1251_g73574;
				float2 lerpResult1231_g73574 = lerp( IN.ase_texcoord9.xy , Mesh_DetailCoord1254_g73574 , _DetailCoordMode);
				half2 Second_UVs1234_g73574 = ( ( lerpResult1231_g73574 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				float4 tex2DNode854_g73574 = tex2D( _SecondAlbedoTex, Second_UVs1234_g73574 );
				float3 appendResult839_g73574 = (float3(tex2DNode854_g73574.r , tex2DNode854_g73574.g , tex2DNode854_g73574.b));
				float3 ifLocalVar40_g73597 = 0;
				if( Debug_Index464_g73574 == 7.0 )
				ifLocalVar40_g73597 = appendResult839_g73574;
				float ifLocalVar40_g73621 = 0;
				if( Debug_Index464_g73574 == 8.0 )
				ifLocalVar40_g73621 = tex2D( _SecondAlbedoTex, Second_UVs1234_g73574 ).a;
				float4 tex2DNode841_g73574 = tex2D( _SecondNormalTex, Second_UVs1234_g73574 );
				float3 appendResult880_g73574 = (float3(tex2DNode841_g73574.a , tex2DNode841_g73574.g , 1.0));
				float3 gammaToLinear879_g73574 = GammaToLinearSpace( appendResult880_g73574 );
				float3 ifLocalVar40_g73667 = 0;
				if( Debug_Index464_g73574 == 8.0 )
				ifLocalVar40_g73667 = gammaToLinear879_g73574;
				float ifLocalVar40_g73640 = 0;
				if( Debug_Index464_g73574 == 10.0 )
				ifLocalVar40_g73640 = tex2D( _SecondMaskTex, Second_UVs1234_g73574 ).r;
				float ifLocalVar40_g73611 = 0;
				if( Debug_Index464_g73574 == 11.0 )
				ifLocalVar40_g73611 = tex2D( _SecondMaskTex, Second_UVs1234_g73574 ).g;
				float ifLocalVar40_g73657 = 0;
				if( Debug_Index464_g73574 == 12.0 )
				ifLocalVar40_g73657 = tex2D( _SecondMaskTex, Second_UVs1234_g73574 ).b;
				float ifLocalVar40_g73666 = 0;
				if( Debug_Index464_g73574 == 13.0 )
				ifLocalVar40_g73666 = tex2D( _SecondMaskTex, Second_UVs1234_g73574 ).a;
				half2 Emissive_UVs1245_g73574 = ( ( IN.ase_texcoord9.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				float4 tex2DNode858_g73574 = tex2D( _EmissiveTex, Emissive_UVs1245_g73574 );
				float3 appendResult867_g73574 = (float3(tex2DNode858_g73574.r , tex2DNode858_g73574.g , tex2DNode858_g73574.b));
				float3 ifLocalVar40_g73609 = 0;
				if( Debug_Index464_g73574 == 14.0 )
				ifLocalVar40_g73609 = appendResult867_g73574;
				float Debug_Min721_g73574 = TVE_DEBUG_Min;
				float temp_output_7_0_g73652 = Debug_Min721_g73574;
				float4 temp_cast_3 = (temp_output_7_0_g73652).xxxx;
				float Debug_Max723_g73574 = TVE_DEBUG_Max;
				float4 Output_Maps561_g73574 = ( ( ( float4( ( ( ifLocalVar40_g73602 + ifLocalVar40_g73612 + ifLocalVar40_g73639 ) + ( ifLocalVar40_g73585 + ifLocalVar40_g73679 + ifLocalVar40_g73614 + ifLocalVar40_g73582 ) ) , 0.0 ) + float4( ( ( ( ifLocalVar40_g73597 + ifLocalVar40_g73621 + ifLocalVar40_g73667 ) + ( ifLocalVar40_g73640 + ifLocalVar40_g73611 + ifLocalVar40_g73657 + ifLocalVar40_g73666 ) ) * _DetailMode ) , 0.0 ) + ( ( float4( ifLocalVar40_g73609 , 0.0 ) * _EmissiveColor ) * _EmissiveCat ) ) - temp_cast_3 ) / ( Debug_Max723_g73574 - temp_output_7_0_g73652 ) );
				float4 ifLocalVar40_g73651 = 0;
				if( Debug_Type367_g73574 == 3.0 )
				ifLocalVar40_g73651 = Output_Maps561_g73574;
				float Resolution44_g74628 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 color62_g74628 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74628 = 0;
				if( Resolution44_g74628 <= 256.0 )
				ifLocalVar61_g74628 = color62_g74628;
				float4 color55_g74628 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74628 = 0;
				if( Resolution44_g74628 == 512.0 )
				ifLocalVar56_g74628 = color55_g74628;
				float4 color42_g74628 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74628 = 0;
				if( Resolution44_g74628 == 1024.0 )
				ifLocalVar40_g74628 = color42_g74628;
				float4 color48_g74628 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74628 = 0;
				if( Resolution44_g74628 == 2048.0 )
				ifLocalVar47_g74628 = color48_g74628;
				float4 color51_g74628 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74628 = 0;
				if( Resolution44_g74628 >= 4096.0 )
				ifLocalVar52_g74628 = color51_g74628;
				float4 ifLocalVar40_g73695 = 0;
				if( Debug_Index464_g73574 == 0.0 )
				ifLocalVar40_g73695 = ( ifLocalVar61_g74628 + ifLocalVar56_g74628 + ifLocalVar40_g74628 + ifLocalVar47_g74628 + ifLocalVar52_g74628 );
				float Resolution44_g74627 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 color62_g74627 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74627 = 0;
				if( Resolution44_g74627 <= 256.0 )
				ifLocalVar61_g74627 = color62_g74627;
				float4 color55_g74627 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74627 = 0;
				if( Resolution44_g74627 == 512.0 )
				ifLocalVar56_g74627 = color55_g74627;
				float4 color42_g74627 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74627 = 0;
				if( Resolution44_g74627 == 1024.0 )
				ifLocalVar40_g74627 = color42_g74627;
				float4 color48_g74627 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74627 = 0;
				if( Resolution44_g74627 == 2048.0 )
				ifLocalVar47_g74627 = color48_g74627;
				float4 color51_g74627 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74627 = 0;
				if( Resolution44_g74627 >= 4096.0 )
				ifLocalVar52_g74627 = color51_g74627;
				float4 ifLocalVar40_g73693 = 0;
				if( Debug_Index464_g73574 == 1.0 )
				ifLocalVar40_g73693 = ( ifLocalVar61_g74627 + ifLocalVar56_g74627 + ifLocalVar40_g74627 + ifLocalVar47_g74627 + ifLocalVar52_g74627 );
				float Resolution44_g74626 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 color62_g74626 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74626 = 0;
				if( Resolution44_g74626 <= 256.0 )
				ifLocalVar61_g74626 = color62_g74626;
				float4 color55_g74626 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74626 = 0;
				if( Resolution44_g74626 == 512.0 )
				ifLocalVar56_g74626 = color55_g74626;
				float4 color42_g74626 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74626 = 0;
				if( Resolution44_g74626 == 1024.0 )
				ifLocalVar40_g74626 = color42_g74626;
				float4 color48_g74626 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74626 = 0;
				if( Resolution44_g74626 == 2048.0 )
				ifLocalVar47_g74626 = color48_g74626;
				float4 color51_g74626 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74626 = 0;
				if( Resolution44_g74626 >= 4096.0 )
				ifLocalVar52_g74626 = color51_g74626;
				float4 ifLocalVar40_g73694 = 0;
				if( Debug_Index464_g73574 == 2.0 )
				ifLocalVar40_g73694 = ( ifLocalVar61_g74626 + ifLocalVar56_g74626 + ifLocalVar40_g74626 + ifLocalVar47_g74626 + ifLocalVar52_g74626 );
				float Resolution44_g74633 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g74633 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74633 = 0;
				if( Resolution44_g74633 <= 256.0 )
				ifLocalVar61_g74633 = color62_g74633;
				float4 color55_g74633 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74633 = 0;
				if( Resolution44_g74633 == 512.0 )
				ifLocalVar56_g74633 = color55_g74633;
				float4 color42_g74633 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74633 = 0;
				if( Resolution44_g74633 == 1024.0 )
				ifLocalVar40_g74633 = color42_g74633;
				float4 color48_g74633 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74633 = 0;
				if( Resolution44_g74633 == 2048.0 )
				ifLocalVar47_g74633 = color48_g74633;
				float4 color51_g74633 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74633 = 0;
				if( Resolution44_g74633 >= 4096.0 )
				ifLocalVar52_g74633 = color51_g74633;
				float4 ifLocalVar40_g74612 = 0;
				if( Debug_Index464_g73574 == 3.0 )
				ifLocalVar40_g74612 = ( ifLocalVar61_g74633 + ifLocalVar56_g74633 + ifLocalVar40_g74633 + ifLocalVar47_g74633 + ifLocalVar52_g74633 );
				float Resolution44_g74632 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 color62_g74632 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74632 = 0;
				if( Resolution44_g74632 <= 256.0 )
				ifLocalVar61_g74632 = color62_g74632;
				float4 color55_g74632 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74632 = 0;
				if( Resolution44_g74632 == 512.0 )
				ifLocalVar56_g74632 = color55_g74632;
				float4 color42_g74632 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74632 = 0;
				if( Resolution44_g74632 == 1024.0 )
				ifLocalVar40_g74632 = color42_g74632;
				float4 color48_g74632 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74632 = 0;
				if( Resolution44_g74632 == 2048.0 )
				ifLocalVar47_g74632 = color48_g74632;
				float4 color51_g74632 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74632 = 0;
				if( Resolution44_g74632 >= 4096.0 )
				ifLocalVar52_g74632 = color51_g74632;
				float4 ifLocalVar40_g74610 = 0;
				if( Debug_Index464_g73574 == 4.0 )
				ifLocalVar40_g74610 = ( ifLocalVar61_g74632 + ifLocalVar56_g74632 + ifLocalVar40_g74632 + ifLocalVar47_g74632 + ifLocalVar52_g74632 );
				float Resolution44_g74634 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g74634 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74634 = 0;
				if( Resolution44_g74634 <= 256.0 )
				ifLocalVar61_g74634 = color62_g74634;
				float4 color55_g74634 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74634 = 0;
				if( Resolution44_g74634 == 512.0 )
				ifLocalVar56_g74634 = color55_g74634;
				float4 color42_g74634 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74634 = 0;
				if( Resolution44_g74634 == 1024.0 )
				ifLocalVar40_g74634 = color42_g74634;
				float4 color48_g74634 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74634 = 0;
				if( Resolution44_g74634 == 2048.0 )
				ifLocalVar47_g74634 = color48_g74634;
				float4 color51_g74634 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74634 = 0;
				if( Resolution44_g74634 >= 4096.0 )
				ifLocalVar52_g74634 = color51_g74634;
				float4 ifLocalVar40_g74611 = 0;
				if( Debug_Index464_g73574 == 5.0 )
				ifLocalVar40_g74611 = ( ifLocalVar61_g74634 + ifLocalVar56_g74634 + ifLocalVar40_g74634 + ifLocalVar47_g74634 + ifLocalVar52_g74634 );
				float Resolution44_g74631 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 color62_g74631 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g74631 = 0;
				if( Resolution44_g74631 <= 256.0 )
				ifLocalVar61_g74631 = color62_g74631;
				float4 color55_g74631 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g74631 = 0;
				if( Resolution44_g74631 == 512.0 )
				ifLocalVar56_g74631 = color55_g74631;
				float4 color42_g74631 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g74631 = 0;
				if( Resolution44_g74631 == 1024.0 )
				ifLocalVar40_g74631 = color42_g74631;
				float4 color48_g74631 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g74631 = 0;
				if( Resolution44_g74631 == 2048.0 )
				ifLocalVar47_g74631 = color48_g74631;
				float4 color51_g74631 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g74631 = 0;
				if( Resolution44_g74631 >= 4096.0 )
				ifLocalVar52_g74631 = color51_g74631;
				float4 ifLocalVar40_g74613 = 0;
				if( Debug_Index464_g73574 == 6.0 )
				ifLocalVar40_g74613 = ( ifLocalVar61_g74631 + ifLocalVar56_g74631 + ifLocalVar40_g74631 + ifLocalVar47_g74631 + ifLocalVar52_g74631 );
				float4 Output_Resolution737_g73574 = ( ( ifLocalVar40_g73695 + ifLocalVar40_g73693 + ifLocalVar40_g73694 ) + ( ifLocalVar40_g74612 + ifLocalVar40_g74610 + ifLocalVar40_g74611 ) + ifLocalVar40_g74613 );
				float4 ifLocalVar40_g74586 = 0;
				if( Debug_Type367_g73574 == 4.0 )
				ifLocalVar40_g74586 = Output_Resolution737_g73574;
				float2 uv_MainAlbedoTex = IN.ase_texcoord9.xy * _MainAlbedoTex_ST.xy + _MainAlbedoTex_ST.zw;
				float2 UVs72_g74639 = Main_UVs1219_g73574;
				float Resolution44_g74639 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g74639 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74639 * ( Resolution44_g74639 / 8.0 ) ) );
				float4 lerpResult78_g74639 = lerp( tex2D( _MainAlbedoTex, uv_MainAlbedoTex ) , tex2DNode77_g74639 , tex2DNode77_g74639.a);
				float4 ifLocalVar40_g74585 = 0;
				if( Debug_Index464_g73574 == 0.0 )
				ifLocalVar40_g74585 = lerpResult78_g74639;
				float2 uv_MainNormalTex = IN.ase_texcoord9.xy * _MainNormalTex_ST.xy + _MainNormalTex_ST.zw;
				float2 UVs72_g74630 = Main_UVs1219_g73574;
				float Resolution44_g74630 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 tex2DNode77_g74630 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74630 * ( Resolution44_g74630 / 8.0 ) ) );
				float4 lerpResult78_g74630 = lerp( tex2D( _MainNormalTex, uv_MainNormalTex ) , tex2DNode77_g74630 , tex2DNode77_g74630.a);
				float4 ifLocalVar40_g74583 = 0;
				if( Debug_Index464_g73574 == 1.0 )
				ifLocalVar40_g74583 = lerpResult78_g74630;
				float2 uv_MainMaskTex = IN.ase_texcoord9.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
				float2 UVs72_g74629 = Main_UVs1219_g73574;
				float Resolution44_g74629 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 tex2DNode77_g74629 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74629 * ( Resolution44_g74629 / 8.0 ) ) );
				float4 lerpResult78_g74629 = lerp( tex2D( _MainMaskTex, uv_MainMaskTex ) , tex2DNode77_g74629 , tex2DNode77_g74629.a);
				float4 ifLocalVar40_g74584 = 0;
				if( Debug_Index464_g73574 == 2.0 )
				ifLocalVar40_g74584 = lerpResult78_g74629;
				float2 uv_SecondAlbedoTex = IN.ase_texcoord9.xy * _SecondAlbedoTex_ST.xy + _SecondAlbedoTex_ST.zw;
				float2 UVs72_g74637 = Second_UVs1234_g73574;
				float Resolution44_g74637 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g74637 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74637 * ( Resolution44_g74637 / 8.0 ) ) );
				float4 lerpResult78_g74637 = lerp( tex2D( _SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g74637 , tex2DNode77_g74637.a);
				float4 ifLocalVar40_g74620 = 0;
				if( Debug_Index464_g73574 == 3.0 )
				ifLocalVar40_g74620 = lerpResult78_g74637;
				float2 uv_SecondMaskTex = IN.ase_texcoord9.xy * _SecondMaskTex_ST.xy + _SecondMaskTex_ST.zw;
				float2 UVs72_g74636 = Second_UVs1234_g73574;
				float Resolution44_g74636 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 tex2DNode77_g74636 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74636 * ( Resolution44_g74636 / 8.0 ) ) );
				float4 lerpResult78_g74636 = lerp( tex2D( _SecondMaskTex, uv_SecondMaskTex ) , tex2DNode77_g74636 , tex2DNode77_g74636.a);
				float4 ifLocalVar40_g74618 = 0;
				if( Debug_Index464_g73574 == 4.0 )
				ifLocalVar40_g74618 = lerpResult78_g74636;
				float2 UVs72_g74638 = Second_UVs1234_g73574;
				float Resolution44_g74638 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g74638 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74638 * ( Resolution44_g74638 / 8.0 ) ) );
				float4 lerpResult78_g74638 = lerp( tex2D( _SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g74638 , tex2DNode77_g74638.a);
				float4 ifLocalVar40_g74619 = 0;
				if( Debug_Index464_g73574 == 5.0 )
				ifLocalVar40_g74619 = lerpResult78_g74638;
				float2 uv_EmissiveTex = IN.ase_texcoord9.xy * _EmissiveTex_ST.xy + _EmissiveTex_ST.zw;
				float2 UVs72_g74635 = Emissive_UVs1245_g73574;
				float Resolution44_g74635 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 tex2DNode77_g74635 = tex2D( TVE_DEBUG_MipTex, ( UVs72_g74635 * ( Resolution44_g74635 / 8.0 ) ) );
				float4 lerpResult78_g74635 = lerp( tex2D( _EmissiveTex, uv_EmissiveTex ) , tex2DNode77_g74635 , tex2DNode77_g74635.a);
				float4 ifLocalVar40_g74621 = 0;
				if( Debug_Index464_g73574 == 6.0 )
				ifLocalVar40_g74621 = lerpResult78_g74635;
				float4 Output_MipLevel1284_g73574 = ( ( ifLocalVar40_g74585 + ifLocalVar40_g74583 + ifLocalVar40_g74584 ) + ( ifLocalVar40_g74620 + ifLocalVar40_g74618 + ifLocalVar40_g74619 ) + ifLocalVar40_g74621 );
				float4 ifLocalVar40_g74589 = 0;
				if( Debug_Type367_g73574 == 5.0 )
				ifLocalVar40_g74589 = Output_MipLevel1284_g73574;
				float3 WorldPosition893_g73574 = worldPos;
				half3 Input_Position419_g73645 = WorldPosition893_g73574;
				float Input_MotionScale287_g73645 = ( _MotionScale_10 + 0.2 );
				half Global_Scale448_g73645 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g73645 = (( Input_Position419_g73645 * Input_MotionScale287_g73645 * Global_Scale448_g73645 * 0.0075 )).xz;
				float4 temp_output_91_19_g73685 = TVE_MotionCoords;
				float4x4 break19_g73682 = unity_ObjectToWorld;
				float3 appendResult20_g73682 = (float3(break19_g73682[ 0 ][ 3 ] , break19_g73682[ 1 ][ 3 ] , break19_g73682[ 2 ][ 3 ]));
				float3 appendResult60_g73681 = (float3(IN.ase_texcoord11.x , IN.ase_texcoord11.z , IN.ase_texcoord11.y));
				float3 temp_output_122_0_g73682 = ( appendResult60_g73681 * _VertexPivotMode );
				float3 PivotsOnly105_g73682 = (mul( unity_ObjectToWorld, float4( temp_output_122_0_g73682 , 0.0 ) ).xyz).xyz;
				half3 ObjectData20_g73683 = ( appendResult20_g73682 + PivotsOnly105_g73682 );
				half3 WorldData19_g73683 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g73683 = WorldData19_g73683;
				#else
				float3 staticSwitch14_g73683 = ObjectData20_g73683;
				#endif
				float3 temp_output_114_0_g73682 = staticSwitch14_g73683;
				half3 ObjectData20_g73607 = temp_output_114_0_g73682;
				half3 WorldData19_g73607 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g73607 = WorldData19_g73607;
				#else
				float3 staticSwitch14_g73607 = ObjectData20_g73607;
				#endif
				float3 ObjectPosition890_g73574 = staticSwitch14_g73607;
				half2 UV94_g73685 = ( (temp_output_91_19_g73685).zw + ( (temp_output_91_19_g73685).xy * (ObjectPosition890_g73574).xz ) );
				float Debug_Layer885_g73574 = TVE_DEBUG_Layer;
				float temp_output_84_0_g73685 = Debug_Layer885_g73574;
				float4 lerpResult107_g73685 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g73685,temp_output_84_0_g73685), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g73685]);
				float4 break322_g73680 = lerpResult107_g73685;
				float2 appendResult433_g73680 = (float2(break322_g73680.x , break322_g73680.y));
				float2 temp_output_436_0_g73680 = (appendResult433_g73680*2.0 + -1.0);
				half2 Wind_DirectionWS1031_g73574 = temp_output_436_0_g73680;
				half2 Input_DirectionWS423_g73645 = Wind_DirectionWS1031_g73574;
				half Input_MotionSpeed62_g73645 = _MotionSpeed_10;
				half Global_Speed449_g73645 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g73645 = _MotionVariation_10;
				float3 break111_g73689 = ObjectPosition890_g73574;
				half Input_DynamicMode120_g73689 = _VertexDynamicMode;
				half Input_Variation124_g73689 = IN.ase_color.r;
				half ObjectData20_g73690 = frac( ( ( ( break111_g73689.x + break111_g73689.y + break111_g73689.z + 0.001275 ) * ( 1.0 - Input_DynamicMode120_g73689 ) ) + Input_Variation124_g73689 ) );
				half WorldData19_g73690 = Input_Variation124_g73689;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g73690 = WorldData19_g73690;
				#else
				float staticSwitch14_g73690 = ObjectData20_g73690;
				#endif
				float clampResult129_g73689 = clamp( staticSwitch14_g73690 , 0.01 , 0.99 );
				half Global_MeshVariation1176_g73574 = clampResult129_g73689;
				half Input_GlobalVariation569_g73645 = Global_MeshVariation1176_g73574;
				float temp_output_630_0_g73645 = ( ( ( _Time.y * Input_MotionSpeed62_g73645 * Global_Speed449_g73645 ) + ( Input_MotionVariation284_g73645 * Input_GlobalVariation569_g73645 ) ) * 0.03 );
				float temp_output_607_0_g73645 = frac( temp_output_630_0_g73645 );
				float4 lerpResult590_g73645 = lerp( tex2D( TVE_NoiseTex, ( temp_output_597_0_g73645 + ( -Input_DirectionWS423_g73645 * temp_output_607_0_g73645 ) ) ) , tex2D( TVE_NoiseTex, ( temp_output_597_0_g73645 + ( -Input_DirectionWS423_g73645 * frac( ( temp_output_630_0_g73645 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_607_0_g73645 - 0.5 ) ) / 0.5 ));
				half2 Motion_Noise915_g73574 = ((lerpResult590_g73645).rg*2.0 + -1.0);
				float3 appendResult1180_g73574 = (float3(Motion_Noise915_g73574 , 0.0));
				float3 ifLocalVar40_g73586 = 0;
				if( Debug_Index464_g73574 == 0.0 )
				ifLocalVar40_g73586 = appendResult1180_g73574;
				float4 temp_output_91_19_g73635 = TVE_ColorsCoords;
				half2 UV94_g73635 = ( (temp_output_91_19_g73635).zw + ( (temp_output_91_19_g73635).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_82_0_g73635 = Debug_Layer885_g73574;
				float4 lerpResult108_g73635 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g73635,temp_output_82_0_g73635), 0.0 ) , TVE_ColorsUsage[(int)temp_output_82_0_g73635]);
				float3 ifLocalVar40_g73606 = 0;
				if( Debug_Index464_g73574 == 1.0 )
				ifLocalVar40_g73606 = (lerpResult108_g73635).rgb;
				float4 temp_output_91_19_g73623 = TVE_ColorsCoords;
				half2 UV94_g73623 = ( (temp_output_91_19_g73623).zw + ( (temp_output_91_19_g73623).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_82_0_g73623 = Debug_Layer885_g73574;
				float4 lerpResult108_g73623 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g73623,temp_output_82_0_g73623), 0.0 ) , TVE_ColorsUsage[(int)temp_output_82_0_g73623]);
				float ifLocalVar40_g73619 = 0;
				if( Debug_Index464_g73574 == 2.0 )
				ifLocalVar40_g73619 = saturate( (lerpResult108_g73623).a );
				float4 temp_output_93_19_g73631 = TVE_ExtrasCoords;
				half2 UV96_g73631 = ( (temp_output_93_19_g73631).zw + ( (temp_output_93_19_g73631).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73631 = Debug_Layer885_g73574;
				float4 lerpResult109_g73631 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g73631,temp_output_84_0_g73631), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g73631]);
				float ifLocalVar40_g73595 = 0;
				if( Debug_Index464_g73574 == 3.0 )
				ifLocalVar40_g73595 = (lerpResult109_g73631).r;
				float4 temp_output_93_19_g73577 = TVE_ExtrasCoords;
				half2 UV96_g73577 = ( (temp_output_93_19_g73577).zw + ( (temp_output_93_19_g73577).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73577 = Debug_Layer885_g73574;
				float4 lerpResult109_g73577 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g73577,temp_output_84_0_g73577), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g73577]);
				float ifLocalVar40_g73678 = 0;
				if( Debug_Index464_g73574 == 4.0 )
				ifLocalVar40_g73678 = (lerpResult109_g73577).g;
				float4 temp_output_93_19_g73641 = TVE_ExtrasCoords;
				half2 UV96_g73641 = ( (temp_output_93_19_g73641).zw + ( (temp_output_93_19_g73641).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73641 = Debug_Layer885_g73574;
				float4 lerpResult109_g73641 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g73641,temp_output_84_0_g73641), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g73641]);
				float ifLocalVar40_g73596 = 0;
				if( Debug_Index464_g73574 == 5.0 )
				ifLocalVar40_g73596 = (lerpResult109_g73641).b;
				float4 temp_output_93_19_g73668 = TVE_ExtrasCoords;
				half2 UV96_g73668 = ( (temp_output_93_19_g73668).zw + ( (temp_output_93_19_g73668).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73668 = Debug_Layer885_g73574;
				float4 lerpResult109_g73668 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g73668,temp_output_84_0_g73668), 0.0 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g73668]);
				float ifLocalVar40_g73590 = 0;
				if( Debug_Index464_g73574 == 6.0 )
				ifLocalVar40_g73590 = saturate( (lerpResult109_g73668).a );
				float4 temp_output_91_19_g73627 = TVE_MotionCoords;
				half2 UV94_g73627 = ( (temp_output_91_19_g73627).zw + ( (temp_output_91_19_g73627).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73627 = Debug_Layer885_g73574;
				float4 lerpResult107_g73627 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g73627,temp_output_84_0_g73627), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g73627]);
				float3 appendResult1012_g73574 = (float3((lerpResult107_g73627).rg , 0.0));
				float3 ifLocalVar40_g73583 = 0;
				if( Debug_Index464_g73574 == 7.0 )
				ifLocalVar40_g73583 = appendResult1012_g73574;
				float4 temp_output_91_19_g73653 = TVE_MotionCoords;
				half2 UV94_g73653 = ( (temp_output_91_19_g73653).zw + ( (temp_output_91_19_g73653).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73653 = Debug_Layer885_g73574;
				float4 lerpResult107_g73653 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g73653,temp_output_84_0_g73653), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g73653]);
				float ifLocalVar40_g73599 = 0;
				if( Debug_Index464_g73574 == 8.0 )
				ifLocalVar40_g73599 = (lerpResult107_g73653).b;
				float4 temp_output_91_19_g73661 = TVE_MotionCoords;
				half2 UV94_g73661 = ( (temp_output_91_19_g73661).zw + ( (temp_output_91_19_g73661).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73661 = Debug_Layer885_g73574;
				float4 lerpResult107_g73661 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g73661,temp_output_84_0_g73661), 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g73661]);
				float ifLocalVar40_g73665 = 0;
				if( Debug_Index464_g73574 == 9.0 )
				ifLocalVar40_g73665 = saturate( (lerpResult107_g73661).a );
				float4 temp_output_94_19_g73673 = TVE_VertexCoords;
				half2 UV97_g73673 = ( (temp_output_94_19_g73673).zw + ( (temp_output_94_19_g73673).xy * (WorldPosition893_g73574).xz ) );
				float temp_output_84_0_g73673 = Debug_Layer885_g73574;
				float4 lerpResult109_g73673 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g73673,temp_output_84_0_g73673), 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g73673]);
				float ifLocalVar40_g73613 = 0;
				if( Debug_Index464_g73574 == 10.0 )
				ifLocalVar40_g73613 = saturate( (lerpResult109_g73673).a );
				float temp_output_7_0_g73692 = Debug_Min721_g73574;
				float3 temp_cast_29 = (temp_output_7_0_g73692).xxx;
				float3 Output_Globals888_g73574 = saturate( ( ( ( ifLocalVar40_g73586 + ( ifLocalVar40_g73606 + ifLocalVar40_g73619 ) + ( ifLocalVar40_g73595 + ifLocalVar40_g73678 + ifLocalVar40_g73596 + ifLocalVar40_g73590 ) + ( ifLocalVar40_g73583 + ifLocalVar40_g73599 + ifLocalVar40_g73665 ) + ( ifLocalVar40_g73613 + 0.0 ) ) - temp_cast_29 ) / ( Debug_Max723_g73574 - temp_output_7_0_g73692 ) ) );
				float3 ifLocalVar40_g74590 = 0;
				if( Debug_Type367_g73574 == 8.0 )
				ifLocalVar40_g74590 = Output_Globals888_g73574;
				float4 color1086_g73574 = IsGammaSpace() ? float4(0.1226415,0.1226415,0.1226415,0) : float4(0.01390275,0.01390275,0.01390275,0);
				float4 vertexToFrag11_g73576 = IN.ase_texcoord12;
				float _IsVegetationShader1101_g73574 = _IsVegetationShader;
				float4 lerpResult1089_g73574 = lerp( color1086_g73574 , vertexToFrag11_g73576 , ( _IsPolygonalShader1112_g73574 * _IsVegetationShader1101_g73574 ));
				float3 Output_Misc1080_g73574 = (lerpResult1089_g73574).rgb;
				float3 ifLocalVar40_g74591 = 0;
				if( Debug_Type367_g73574 == 9.0 )
				ifLocalVar40_g74591 = Output_Misc1080_g73574;
				float3 vertexToFrag328_g73574 = IN.ase_texcoord8.yzw;
				float4 color1016_g73574 = IsGammaSpace() ? float4(0.5831653,0.6037736,0.2135992,0) : float4(0.2992498,0.3229691,0.03750122,0);
				float4 color1017_g73574 = IsGammaSpace() ? float4(0.8117647,0.3488252,0.2627451,0) : float4(0.6239604,0.0997834,0.05612849,0);
				float4 switchResult1015_g73574 = (((ase_vface>0)?(color1016_g73574):(color1017_g73574)));
				float3 ifLocalVar40_g73588 = 0;
				if( Debug_Index464_g73574 == 4.0 )
				ifLocalVar40_g73588 = (switchResult1015_g73574).rgb;
				float temp_output_7_0_g73691 = Debug_Min721_g73574;
				float3 temp_cast_32 = (temp_output_7_0_g73691).xxx;
				float3 Output_Mesh316_g73574 = saturate( ( ( ( vertexToFrag328_g73574 + ifLocalVar40_g73588 ) - temp_cast_32 ) / ( Debug_Max723_g73574 - temp_output_7_0_g73691 ) ) );
				float3 ifLocalVar40_g74592 = 0;
				if( Debug_Type367_g73574 == 10.0 )
				ifLocalVar40_g74592 = Output_Mesh316_g73574;
				float4 temp_output_459_0_g73574 = ( ifLocalVar40_g73600 + ifLocalVar40_g73677 + ifLocalVar40_g73658 + ifLocalVar40_g73651 + ifLocalVar40_g74586 + ifLocalVar40_g74589 + float4( ifLocalVar40_g74590 , 0.0 ) + float4( ifLocalVar40_g74591 , 0.0 ) + float4( ifLocalVar40_g74592 , 0.0 ) );
				float4 color690_g73574 = IsGammaSpace() ? float4(0.1226415,0.1226415,0.1226415,0) : float4(0.01390275,0.01390275,0.01390275,0);
				float _IsTVEShader647_g73574 = _IsTVEShader;
				float4 lerpResult689_g73574 = lerp( color690_g73574 , temp_output_459_0_g73574 , _IsTVEShader647_g73574);
				float Debug_Filter322_g73574 = TVE_DEBUG_Filter;
				float4 lerpResult326_g73574 = lerp( temp_output_459_0_g73574 , lerpResult689_g73574 , Debug_Filter322_g73574);
				float Debug_Clip623_g73574 = TVE_DEBUG_Clip;
				float lerpResult622_g73574 = lerp( 1.0 , tex2D( _MainAlbedoTex, uv_MainAlbedoTex ).a , ( Debug_Clip623_g73574 * _RenderClip ));
				clip( lerpResult622_g73574 - _Cutoff);
				clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
				
				o.Albedo = fixed3( 0.5, 0.5, 0.5 );
				o.Normal = fixed3( 0, 0, 1 );
				o.Emission = lerpResult326_g73574.rgb;
				#if defined(_SPECULAR_SETUP)
					o.Specular = fixed3( 0, 0, 0 );
				#else
					o.Metallic = 0;
				#endif
				o.Smoothness = 0;
				o.Occlusion = 1;
				o.Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float3 BakedGI = 0;

				#ifdef _ALPHATEST_ON
					clip( o.Alpha - AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
					outputDepth = IN.pos.z;
				#endif

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				float3 worldN;
				worldN.x = dot(IN.tSpace0.xyz, o.Normal);
				worldN.y = dot(IN.tSpace1.xyz, o.Normal);
				worldN.z = dot(IN.tSpace2.xyz, o.Normal);
				worldN = normalize(worldN);
				o.Normal = worldN;

				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
				gi.indirect.diffuse = 0;
				gi.indirect.specular = 0;
				gi.light.color = 0;
				gi.light.dir = half3(0,1,0);

				UnityGIInput giInput;
				UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
				giInput.light = gi.light;
				giInput.worldPos = worldPos;
				giInput.worldViewDir = worldViewDir;
				giInput.atten = atten;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					giInput.lightmapUV = IN.lmap;
				#else
					giInput.lightmapUV = 0.0;
				#endif
				#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					giInput.ambient = IN.sh;
				#else
					giInput.ambient.rgb = 0.0;
				#endif
				giInput.probeHDR[0] = unity_SpecCube0_HDR;
				giInput.probeHDR[1] = unity_SpecCube1_HDR;
				#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
					giInput.boxMin[0] = unity_SpecCube0_BoxMin;
				#endif
				#ifdef UNITY_SPECCUBE_BOX_PROJECTION
					giInput.boxMax[0] = unity_SpecCube0_BoxMax;
					giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
					giInput.boxMax[1] = unity_SpecCube1_BoxMax;
					giInput.boxMin[1] = unity_SpecCube1_BoxMin;
					giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
				#endif

				#if defined(_SPECULAR_SETUP)
					LightingStandardSpecular_GI( o, giInput, gi );
				#else
					LightingStandard_GI( o, giInput, gi );
				#endif

				#ifdef ASE_BAKEDGI
					gi.indirect.diffuse = BakedGI;
				#endif

				#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
					gi.indirect.diffuse = 0;
				#endif

				#if defined(_SPECULAR_SETUP)
					outEmission = LightingStandardSpecular_Deferred( o, worldViewDir, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
				#else
					outEmission = LightingStandard_Deferred( o, worldViewDir, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
				#endif

				#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
					outShadowMask = UnityGetRawBakedOcclusions (IN.lmap.xy, float3(0, 0, 0));
				#endif
				#ifndef UNITY_HDR_ON
					outEmission.rgb = exp2(-outEmission.rgb);
				#endif
			}
			ENDCG
		}

	
	}
	
	
	Dependency "LightMode"="ForwardBase"

	Fallback Off
}
/*ASEBEGIN
Version=19100
Node;AmplifyShaderEditor.RangedFloatNode;2069;-1792,-4992;Half;False;Global;TVE_DEBUG_Min;TVE_DEBUG_Min;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2155;-1792,-5248;Half;False;Global;TVE_DEBUG_Layer;TVE_DEBUG_Layer;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2013;-1792,-5312;Half;False;Global;TVE_DEBUG_Index;TVE_DEBUG_Index;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1908;-1792,-5376;Half;False;Global;TVE_DEBUG_Type;TVE_DEBUG_Type;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1953;-1792,-5120;Half;False;Global;TVE_DEBUG_Filter;TVE_DEBUG_Filter;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2032;-1792,-5056;Half;False;Global;TVE_DEBUG_Clip;TVE_DEBUG_Clip;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2070;-1792,-4928;Half;False;Global;TVE_DEBUG_Max;TVE_DEBUG_Max;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;1774;-880,2944;Inherit;False;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1803;-1344,2944;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1878;-1792,-5632;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Debug);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1772;-1088,3072;Float;False;Constant;_Float3;Float 3;31;0;Create;True;0;0;0;False;0;False;24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1931;-1408,-5632;Half;False;Property;_DebugCategory;[ Debug Category ];103;0;Create;True;0;0;0;False;1;StyledCategory(Debug Settings, 5, 10);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1843;-1632,2944;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1771;-1088,2944;Inherit;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;1800;-1472,2944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1804;-1792,2944;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1881;-1600,-5632;Half;False;Property;_Message;Message;104;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use this shader to debug the original mesh or the converted mesh attributes., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2109;-896,-5376;Float;False;True;-1;2;;0;4;Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Debug;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;18;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;True;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True=DisableBatching;True;7;False;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;1;LightMode=ForwardBase;0;Standard;40;Workflow,InvertActionOnDeselection;1;0;Surface;0;0;  Blend;0;0;  Refraction Model;0;0;  Dither Shadows;1;0;Cull Mode;1;0;Deferred Pass;1;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;0;  Use Shadow Threshold;0;0;Receive Shadows;0;0;GPU Instancing;0;0;LOD CrossFade;0;0;Built-in Fog;0;0;Ambient Light;0;0;Meta Pass;0;0;Add Pass;0;0;Override Baked GI;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Fwd Specular Highlights Toggle;0;0;Fwd Reflections Toggle;0;0;Disable Batching;1;0;Vertex Position,InvertActionOnDeselection;1;0;0;6;False;True;False;True;False;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2112;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;9;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2113;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;9;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;True;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;True;1;=;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2110;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;9;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;1;LightMode=ForwardAdd;False;False;0;True;1;LightMode=ForwardAdd;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2108;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;9;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;True;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=ForwardBase;False;False;0;-1;59;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;LightMode=ForwardBase;=;=;=;=;=;=;=;=;=;=;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2111;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;9;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;True;2;True;17;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.FunctionNode;2203;-896,-5632;Inherit;False;Compile All Shaders;-1;;73162;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2207;-1408,-5376;Inherit;False;Tool Debug;1;;73574;d48cde928c5068141abea1713047719b;1,1236,0;7;336;FLOAT;0;False;465;FLOAT;0;False;884;FLOAT;0;False;337;FLOAT;0;False;624;FLOAT;0;False;720;FLOAT;0;False;722;FLOAT;0;False;1;COLOR;338
WireConnection;1774;0;1771;0
WireConnection;1774;1;1772;0
WireConnection;1774;3;1803;0
WireConnection;1803;0;1800;0
WireConnection;1843;0;1804;0
WireConnection;1800;0;1843;0
WireConnection;2109;2;2207;338
WireConnection;2207;336;1908;0
WireConnection;2207;465;2013;0
WireConnection;2207;884;2155;0
WireConnection;2207;337;1953;0
WireConnection;2207;624;2032;0
WireConnection;2207;720;2069;0
WireConnection;2207;722;2070;0
ASEEND*/
//CHKSM=21C0B0D2D1563E14D435404BBC77F079380A4B5A