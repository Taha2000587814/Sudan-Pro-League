// Made with Amplify Shader Editor v1.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Elements/Default/Colors Map"
{
	Properties
	{
		[StyledBanner(Color Map Element)]_Banner("Banner", Float) = 0
		[StyledMessage(Info, Use the Colors Map elements to add color tinting to the vegetation assets. Element Texture RGB is used as tint color and Texture A is used as alpha mask. Particle Color is used as Main multiplier and Alpha as Element Intensity multiplier., 0,0)]_Message("Message", Float) = 0
		[StyledCategory(Render Settings)]_RenderCat("[ Render Cat ]", Float) = 0
		_ElementIntensity("Render Intensity", Range( 0 , 1)) = 1
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)]_ElementLayerWarning("Render Layer Warning", Float) = 0
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)]_ElementLayerMessage("Render Layer Message", Float) = 0
		[StyledMask(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_ElementLayerMask("Render Layer", Float) = 1
		[Enum(Multiply Material Colors,14,Replace Material Colors,15)]_ElementColorsMode("Render Effect", Float) = 15
		[StyledCategory(Element Settings)]_ElementCat("[ Element Cat ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainTex("Element Texture", 2D) = "white" {}
		[Space(10)][StyledRemapSlider(_MainTexMinValue, _MainTexMaxValue, 0, 1)]_MainTexRemap("Element Remap", Vector) = (0,0,0,0)
		[HideInInspector]_MainTexMinValue("Element Min", Range( 0 , 1)) = 0
		[HideInInspector]_MainTexMaxValue("Element Max", Range( 0 , 1)) = 1
		[StyledVector(9)]_MainUVs("Element UVs", Vector) = (1,1,0,0)
		[HDR][Gamma]_MainColor("Element Color", Color) = (0.5019608,0.5019608,0.5019608,1)
		[Space(10)]_InfluenceValue1("Winter Influence", Range( 0 , 1)) = 1
		_InfluenceValue2("Spring Influence", Range( 0 , 1)) = 1
		_InfluenceValue3("Summer Influence", Range( 0 , 1)) = 1
		_InfluenceValue4("Autumn Influence", Range( 0 , 1)) = 1
		[StyledRemapSlider(_NoiseMinValue, _NoiseMaxValue, 0, 1, 10, 0)]_NoiseRemap("Noise Remap", Vector) = (0,0,0,0)
		[Space(10)][StyledToggle]_ElementVertexColorMode("Use Particle Vertex Color", Float) = 1
		[StyledCategory(Fading Settings)]_FadeCat("[ Fade Cat ]", Float) = 0
		[HDR][StyledToggle]_ElementRaycastMode("Enable Raycast Fading", Float) = 0
		[StyledToggle]_ElementVolumeFadeMode("Enable Volume Edge Fading", Float) = 0
		[HideInInspector]_RaycastFadeValue("Raycast Fade Mask", Float) = 1
		[Space(10)][StyledLayers()]_RaycastLayerMask("Raycast Layer", Float) = 1
		_RaycastDistanceEndValue("Raycast Distance", Float) = 2
		[ASEEnd][StyledCategory(Advanced Settings)]_AdvancedCat("[ Advanced Cat ]", Float) = 0
		[HideInInspector]_ElementLayerValue("Legacy Layer Value", Float) = -1
		[HideInInspector]_InvertX("Legacy Invert Mode", Float) = 0
		[HideInInspector]_ElementFadeSupport("Legacy Edge Fading", Float) = 0
		[HideInInspector]_IsVersion("_IsVersion", Float) = 710
		[HideInInspector]_IsElementShader("_IsElementShader", Float) = 1
		[HideInInspector]_IsColorsElement("_IsColorsElement", Float) = 1
		[HideInInspector]_render_colormask("_render_colormask", Float) = 15

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "PreviewType"="Plane" "DisableBatching"="True" }
	LOD 0

		CGINCLUDE
		#pragma target 2.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		Cull Off
		ColorMask [_render_colormask]
		ZWrite Off
		ZTest LEqual
		
		
		
		Pass
		{
			Name "Unlit"

			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			// Element Type Define
			#define TVE_IS_COLORS_ELEMENT


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform half _IsColorsElement;
			uniform half _Banner;
			uniform half _ElementLayerMask;
			uniform half _RenderCat;
			uniform half _ElementCat;
			uniform half _FadeCat;
			uniform half _IsElementShader;
			uniform float _ElementFadeSupport;
			uniform half _ElementLayerValue;
			uniform half _ElementLayerWarning;
			uniform half _ElementRaycastMode;
			uniform half _RaycastDistanceEndValue;
			uniform half4 _NoiseRemap;
			uniform float _InvertX;
			uniform half _AdvancedCat;
			uniform half _ElementLayerMessage;
			uniform half4 _MainTexRemap;
			uniform half _RaycastLayerMask;
			uniform float _IsVersion;
			uniform half _Message;
			uniform half _render_colormask;
			uniform half4 _MainColor;
			uniform half _ElementVertexColorMode;
			uniform sampler2D _MainTex;
			uniform half4 _MainUVs;
			uniform half _MainTexMinValue;
			uniform half _MainTexMaxValue;
			uniform half _ElementIntensity;
			uniform half4 TVE_ColorsCoords;
			uniform half4 TVE_ExtrasCoords;
			uniform half4 TVE_MotionCoords;
			uniform half4 TVE_VertexCoords;
			uniform half TVE_ElementsFadeValue;
			uniform half _ElementVolumeFadeMode;
			uniform half _RaycastFadeValue;
			uniform half4 TVE_SeasonOptions;
			uniform half _InfluenceValue1;
			uniform half _InfluenceValue2;
			uniform half TVE_SeasonLerp;
			uniform half _InfluenceValue3;
			uniform half _InfluenceValue4;
			uniform half _ElementColorsMode;
			half4 IS_ELEMENT( half4 Colors, half4 Extras, half4 Motion, half4 Vertex )
			{
				#if defined (TVE_IS_COLORS_ELEMENT)
				return Colors;
				#elif defined (TVE_IS_EXTRAS_ELEMENT)
				return Extras;
				#elif defined (TVE_IS_MOTION_ELEMENT)
				return Motion;
				#elif defined (TVE_IS_VERTEX_ELEMENT)
				return Vertex;
				#else
				return Colors;
				#endif
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_color = v.color;
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				half4 Color_Main_RGBA49_g19316 = _MainColor;
				half4 temp_cast_0 = (1.0).xxxx;
				half Element_VertexColorMode1292_g19316 = _ElementVertexColorMode;
				half4 lerpResult1296_g19316 = lerp( temp_cast_0 , i.ase_color , Element_VertexColorMode1292_g19316);
				half4 Element_VertexColor1300_g19316 = lerpResult1296_g19316;
				half4 tex2DNode17_g19316 = tex2D( _MainTex, ( ( ( 1.0 - i.ase_texcoord1.xy ) * (_MainUVs).xy ) + (_MainUVs).zw ) );
				half4 MainTex_RGBA587_g19316 = tex2DNode17_g19316;
				half3 temp_output_604_0_g19316 = (( Color_Main_RGBA49_g19316 * Element_VertexColor1300_g19316 * MainTex_RGBA587_g19316 )).rgb;
				half3 Final_ColorsMap_RGB598_g19316 = temp_output_604_0_g19316;
				half temp_output_7_0_g20833 = _MainTexMinValue;
				half4 temp_cast_1 = (temp_output_7_0_g20833).xxxx;
				half4 break469_g19316 = saturate( ( ( tex2DNode17_g19316 - temp_cast_1 ) / ( _MainTexMaxValue - temp_output_7_0_g20833 ) ) );
				half MainTex_A74_g19316 = break469_g19316.a;
				half4 Colors37_g20853 = TVE_ColorsCoords;
				half4 Extras37_g20853 = TVE_ExtrasCoords;
				half4 Motion37_g20853 = TVE_MotionCoords;
				half4 Vertex37_g20853 = TVE_VertexCoords;
				half4 localIS_ELEMENT37_g20853 = IS_ELEMENT( Colors37_g20853 , Extras37_g20853 , Motion37_g20853 , Vertex37_g20853 );
				half4 temp_output_35_0_g20854 = localIS_ELEMENT37_g20853;
				half temp_output_7_0_g20862 = TVE_ElementsFadeValue;
				half2 temp_cast_2 = (temp_output_7_0_g20862).xx;
				half2 temp_output_851_0_g19316 = saturate( ( ( abs( (( (temp_output_35_0_g20854).zw + ( (temp_output_35_0_g20854).xy * (WorldPosition).xz ) )*2.002 + -1.001) ) - temp_cast_2 ) / ( 1.0 - temp_output_7_0_g20862 ) ) );
				half2 break852_g19316 = ( temp_output_851_0_g19316 * temp_output_851_0_g19316 );
				half lerpResult842_g19316 = lerp( 1.0 , ( 1.0 - saturate( ( break852_g19316.x + break852_g19316.y ) ) ) , _ElementVolumeFadeMode);
				half Fade_EdgeMask656_g19316 = lerpResult842_g19316;
				half Element_Intensity56_g19316 = ( _ElementIntensity * i.ase_color.a * Fade_EdgeMask656_g19316 * _RaycastFadeValue );
				half TVE_SeasonOptions_X50_g19316 = TVE_SeasonOptions.x;
				half Influence_Winter808_g19316 = _InfluenceValue1;
				half Influence_Spring814_g19316 = _InfluenceValue2;
				half TVE_SeasonLerp54_g19316 = TVE_SeasonLerp;
				half lerpResult829_g19316 = lerp( Influence_Winter808_g19316 , Influence_Spring814_g19316 , TVE_SeasonLerp54_g19316);
				half TVE_SeasonOptions_Y51_g19316 = TVE_SeasonOptions.y;
				half Influence_Summer815_g19316 = _InfluenceValue3;
				half lerpResult833_g19316 = lerp( Influence_Spring814_g19316 , Influence_Summer815_g19316 , TVE_SeasonLerp54_g19316);
				half TVE_SeasonOptions_Z52_g19316 = TVE_SeasonOptions.z;
				half Influence_Autumn810_g19316 = _InfluenceValue4;
				half lerpResult816_g19316 = lerp( Influence_Summer815_g19316 , Influence_Autumn810_g19316 , TVE_SeasonLerp54_g19316);
				half TVE_SeasonOptions_W53_g19316 = TVE_SeasonOptions.w;
				half lerpResult817_g19316 = lerp( Influence_Autumn810_g19316 , Influence_Winter808_g19316 , TVE_SeasonLerp54_g19316);
				half Influence834_g19316 = ( ( TVE_SeasonOptions_X50_g19316 * lerpResult829_g19316 ) + ( TVE_SeasonOptions_Y51_g19316 * lerpResult833_g19316 ) + ( TVE_SeasonOptions_Z52_g19316 * lerpResult816_g19316 ) + ( TVE_SeasonOptions_W53_g19316 * lerpResult817_g19316 ) );
				half Final_ColorsMap_A603_g19316 = ( MainTex_A74_g19316 * Element_Intensity56_g19316 * Influence834_g19316 );
				half4 appendResult622_g19316 = (half4(Final_ColorsMap_RGB598_g19316 , Final_ColorsMap_A603_g19316));
				half Element_EffectColors914_g19316 = _ElementColorsMode;
				
				
				finalColor = ( appendResult622_g19316 + ( Element_EffectColors914_g19316 * 0.0 ) );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "TVEShaderElementGUI"
	
	Fallback Off
}
/*ASEBEGIN
Version=19100
Node;AmplifyShaderEditor.FunctionNode;108;-640,-768;Inherit;False;Define Element Colors;63;;19315;378049ebac362e14aae08c2daa8ed737;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-384,-768;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Color Map Element);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;148;-640,-512;Inherit;False;Base Element;2;;19316;0e972c73cae2ee54ea51acc9738801d0;6,477,0,478,1,145,0,481,0,576,1,491,1;0;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-256,-768;Half;False;Property;_Message;Message;1;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use the Colors Map elements to add color tinting to the vegetation assets. Element Texture RGB is used as tint color and Texture A is used as alpha mask. Particle Color is used as Main multiplier and Alpha as Element Intensity multiplier., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;-640,-640;Half;False;Property;_render_colormask;_render_colormask;65;1;[HideInInspector];Create;True;0;0;0;True;0;False;15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-304,-512;Half;False;True;-1;2;TVEShaderElementGUI;0;5;BOXOPHOBIC/The Vegetation Engine/Elements/Default/Colors Map;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;2;5;False;;10;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;True;True;True;True;True;False;0;True;_render_colormask;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;4;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;PreviewType=Plane;DisableBatching=True=DisableBatching;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
WireConnection;0;0;148;0
ASEEND*/
//CHKSM=9148D98A39BFDBA9765654EF5D8DE4405BA2025E