// Made with Amplify Shader Editor v1.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Helpers/I Made It"
{
	Properties
	{
		[StyledBanner(I Made It)]_Banner("Banner", Float) = 0
		[StyledMessage(Info, Use this helper shader to set your maps and the converter will pack them to be used with the vegetation shaders. All the other parameters will be set on the vegetation materials., 5, 5 )]_MainMessage("!!! Main Message !!!", Float) = 0
		[StyledCategory(Render Settings)]_CategorySettings("[ Category Settings ]", Float) = 0
		[Enum(Bark Material,0,Leaf Material,1)]_MaterialMode("Material Mode", Float) = 1
		[Enum(Use Mask Map,0,Use Separate Maps,1)]_MasksMode("Masks Mode", Float) = 0
		[Enum(Use Subsurface Map,0,Use Thickness Map,1)]_SubsurfaceMode("Subsurface Mode", Float) = 0
		[Enum(Off,0,On,1)][Space(10)]_RenderClip("Alpha Clipping", Float) = 1
		_AlphaClipValue("Alpha Treshold", Range( 0 , 1)) = 0.5
		[StyledCategory(Main Settings)]_CategoryMain("[ Category Main ]", Float) = 0
		[StyledMessage(Info, Use a Mask Map for the surface shading or use separate maps and the converter will pack them automatically., 5, 10 )]_SurfaceMessage("!!! Surface Message !!!", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainAlbedoTex("Main Albedo (RGB) Alpha (A)", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainNormalTex("Main Normal", 2D) = "bump" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainMaskTex("Main Mask Metallic (R) Occlusion (G) Mask (B) Smoothness (A)", 2D) = "gray" {}
		[NoScaleOffset][Space(10)][StyledTextureSingleLine]_MainMetallicTex("Main Metallic (R)", 2D) = "black" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainOcclusionTex("Main Occlusion (R)", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainSmoothnessTex("Main Smoothness (R)", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainSubsurfaceTex("Main Subsurface or Detail Mask (R)", 2D) = "black" {}
		[Space(10)][StyledVector(9)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[HDR]_MainColor("Main Color", Color) = (1,1,1,1)
		_MainNormalValue("Main Normal", Range( -8 , 8)) = 1
		_MainMetallicValue("Metallic", Range( 0 , 1)) = 1
		_MainOcclusionValue("Occlusion", Range( 0 , 1)) = 1
		_MainSmoothnessValue("Smoothness", Range( 0 , 1)) = 1
		[StyledCategory(Emissive Settings)]_CategoryEmissive("[ Category Emissive ]", Float) = 0
		[NoScaleOffset][Space(10)][StyledTextureSingleLine]_EmissiveTex("Emissive Texture (RGB)", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_EmissiveUVs("Emissive UVs", Vector) = (1,1,0,0)
		[Enum(None,0,Any,10,Baked,20,Realtime,30)]_EmissiveFlagMode("Emissive Baking", Float) = 0
		[HDR]_EmissiveColor("Emissive Color", Color) = (0,0,0,0)
		[StyledEmissiveIntensity]_EmissiveIntensityParams("Emissive Intensity", Vector) = (1,1,1,0)
		[StyledCategory(Additional Maps)]_CategoryAdditional("[ Category Additional ]", Float) = 0
		[StyledMessage(Info, Use the additional maps as vertex mask for motion or any other mask. Open the I Made It preset for more details., 5, 10 )]_AdditionalMessage("!!! Additional Message !!!", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_AdditionalTex1("Additional Mask 1", 2D) = "gray" {}
		[NoScaleOffset][StyledTextureSingleLine]_AdditionalTex2("Additional Mask 2", 2D) = "gray" {}
		[NoScaleOffset][StyledTextureSingleLine]_AdditionalTex3("Additional Mask 3", 2D) = "gray" {}
		[NoScaleOffset][StyledTextureSingleLine]_AdditionalTex4("Additional Mask 4", 2D) = "gray" {}
		[NoScaleOffset][StyledTextureSingleLine]_AdditionalTex5("Additional Mask 5", 2D) = "gray" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 4.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _AdditionalTex3;
		uniform sampler2D _AdditionalTex4;
		uniform sampler2D _AdditionalTex5;
		uniform half _CategoryMain;
		uniform sampler2D _AdditionalTex1;
		uniform sampler2D _MainMaskTex;
		uniform sampler2D _MainSmoothnessTex;
		uniform sampler2D _MainNormalTex;
		uniform sampler2D _MainOcclusionTex;
		uniform sampler2D _MainMetallicTex;
		uniform float _SurfaceMessage;
		uniform half _CategoryAdditional;
		uniform half _CategorySettings;
		uniform sampler2D _AdditionalTex2;
		uniform sampler2D _MainSubsurfaceTex;
		uniform float _AlphaClipValue;
		uniform float _RenderClip;
		uniform float _SubsurfaceMode;
		uniform float _MasksMode;
		uniform half _Banner;
		uniform float _MainMessage;
		uniform float _AdditionalMessage;
		uniform half _CategoryEmissive;
		uniform float _MaterialMode;
		uniform half _EmissiveFlagMode;
		uniform half4 _MainUVs;
		uniform float _MainNormalValue;
		uniform sampler2D _MainAlbedoTex;
		uniform float4 _MainColor;
		uniform half4 _EmissiveColor;
		uniform float4 _EmissiveIntensityParams;
		uniform sampler2D _EmissiveTex;
		uniform half4 _EmissiveUVs;
		uniform float _MainMetallicValue;
		uniform float _MainSmoothnessValue;
		uniform float _MainOcclusionValue;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			half2 Main_UVs1167_g6 = ( ( i.uv_texcoord * (_MainUVs).xy ) + (_MainUVs).zw );
			float3 Main_Normal1201_g6 = UnpackScaleNormal( tex2D( _MainNormalTex, Main_UVs1167_g6 ), _MainNormalValue );
			o.Normal = Main_Normal1201_g6;
			float4 tex2DNode1176_g6 = tex2D( _MainAlbedoTex, Main_UVs1167_g6 );
			float4 Main_Albedo1198_g6 = ( tex2DNode1176_g6 * _MainColor );
			float Main_Alpha1195_g6 = tex2DNode1176_g6.a;
			clip( Main_Alpha1195_g6 - ( _AlphaClipValue * _RenderClip ));
			o.Albedo = Main_Albedo1198_g6.rgb;
			float4 temp_output_1254_0_g6 = ( _EmissiveColor * _EmissiveIntensityParams.x );
			half2 Emissive_UVs1240_g6 = ( ( i.uv_texcoord * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
			half3 Final_Emissive1258_g6 = (( temp_output_1254_0_g6 * tex2D( _EmissiveTex, Emissive_UVs1240_g6 ) )).rgb;
			o.Emission = Final_Emissive1258_g6;
			float4 tex2DNode1181_g6 = tex2D( _MainMaskTex, Main_UVs1167_g6 );
			float Mode_Masks1173_g6 = _MasksMode;
			float lerpResult1189_g6 = lerp( tex2DNode1181_g6.r , tex2D( _MainMetallicTex, Main_UVs1167_g6 ).r , Mode_Masks1173_g6);
			float Main_Metallic1200_g6 = ( lerpResult1189_g6 * _MainMetallicValue );
			o.Metallic = Main_Metallic1200_g6;
			float lerpResult1188_g6 = lerp( tex2DNode1181_g6.a , tex2D( _MainSmoothnessTex, Main_UVs1167_g6 ).r , Mode_Masks1173_g6);
			float Main_Smoothness1202_g6 = ( lerpResult1188_g6 * _MainSmoothnessValue );
			o.Smoothness = Main_Smoothness1202_g6;
			float lerpResult1185_g6 = lerp( tex2DNode1181_g6.g , tex2D( _MainOcclusionTex, Main_UVs1167_g6 ).r , Mode_Masks1173_g6);
			float lerpResult1192_g6 = lerp( 1.0 , lerpResult1185_g6 , _MainOcclusionValue);
			float Main_Occlusion1205_g6 = lerpResult1192_g6;
			o.Occlusion = Main_Occlusion1205_g6;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "TVEShaderHelperGUI"
}
/*ASEBEGIN
Version=19100
Node;AmplifyShaderEditor.FunctionNode;542;384,-384;Inherit;False;Compile All Shaders;-1;;5;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;543;0,-256;Inherit;False;Tool I Made It;0;;6;ea1031f7d4ccc5b46a9938085e401ba7;0;0;6;COLOR;338;FLOAT3;1233;FLOAT3;1266;FLOAT;1234;FLOAT;1235;FLOAT;1236
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;522;384,-256;Float;False;True;-1;4;TVEShaderHelperGUI;0;0;Standard;BOXOPHOBIC/The Vegetation Engine/Helpers/I Made It;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;522;0;543;338
WireConnection;522;1;543;1233
WireConnection;522;2;543;1266
WireConnection;522;3;543;1234
WireConnection;522;4;543;1235
WireConnection;522;5;543;1236
ASEEND*/
//CHKSM=E98AF22FDE859166A529022C1B9185016317F5EB