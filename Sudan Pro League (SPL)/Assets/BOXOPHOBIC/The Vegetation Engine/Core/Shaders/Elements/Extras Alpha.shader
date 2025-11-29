// Made with Amplify Shader Editor v1.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Elements/Default/Extras Alpha"
{
	Properties
	{
		[StyledBanner(Alpha Element)]_Banner("Banner", Float) = 0
		[StyledMessage(Info, Use the Alpha elements to reduce the leaves amount or the alpha treshold. Useful to create winter sceneries or dead forests and dissolve effects. Element Texture A is used as alpha mask. Particle Color R is used as values multiplier and Alpha as Element Intensity multiplier., 0,0)]_Message("Message", Float) = 0
		[StyledCategory(Render Settings)]_RenderCat("[ Render Cat ]", Float) = 0
		_ElementIntensity("Render Intensity", Range( 0 , 1)) = 1
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)]_ElementLayerWarning("Render Layer Warning", Float) = 0
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)]_ElementLayerMessage("Render Layer Message", Float) = 0
		[StyledMask(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_ElementLayerMask("Render Layer", Float) = 1
		[Enum(Constant,0,Seasons,1)]_ElementMode("Render Mode", Float) = 0
		[Enum(Multiplicative Blending,0,Additive Blending,1)]_ElementBlendA("Render Effect", Float) = 0
		[StyledCategory(Element Settings)]_ElementCat("[ Element Cat ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainTex("Element Texture", 2D) = "white" {}
		[Space(10)][StyledRemapSlider(_MainTexMinValue, _MainTexMaxValue, 0, 1)]_MainTexRemap("Element Remap", Vector) = (0,0,0,0)
		[HideInInspector]_MainTexMinValue("Element Min", Range( 0 , 1)) = 0
		[HideInInspector]_MainTexMaxValue("Element Max", Range( 0 , 1)) = 1
		[StyledVector(9)]_MainUVs("Element UVs", Vector) = (1,1,0,0)
		_MainValue("Element Value", Range( 0 , 1)) = 1
		_AdditionalValue1("Winter Value", Range( 0 , 1)) = 1
		_AdditionalValue2("Spring Value", Range( 0 , 1)) = 1
		_AdditionalValue3("Summer Value", Range( 0 , 1)) = 1
		_AdditionalValue4("Autumn Value", Range( 0 , 1)) = 1
		[StyledRemapSlider(_NoiseMinValue, _NoiseMaxValue, 0, 1, 10, 0)]_NoiseRemap("Noise Remap", Vector) = (0,0,0,0)
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
		[HideInInspector]_render_src("_render_src", Float) = 2
		[HideInInspector]_render_dst("_render_dst", Float) = 0
		[HideInInspector]_IsExtrasElement("_IsExtrasElement", Float) = 1

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "PreviewType"="Plane" "DisableBatching"="True" }
	LOD 0

		CGINCLUDE
		#pragma target 2.0
		ENDCG
		Blend One Zero, [_render_src] [_render_dst]
		AlphaToMask Off
		Cull Off
		ColorMask A
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
			#define TVE_IS_EXTRAS_ELEMENT


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
			uniform half _IsExtrasElement;
			uniform half _Banner;
			uniform half _Message;
			uniform half _render_src;
			uniform half _render_dst;
			uniform half _MainValue;
			uniform half4 TVE_SeasonOptions;
			uniform half _AdditionalValue1;
			uniform half _AdditionalValue2;
			uniform half TVE_SeasonLerp;
			uniform half _AdditionalValue3;
			uniform half _AdditionalValue4;
			uniform half _ElementMode;
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
			uniform half _ElementBlendA;
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
			
			half GammaToLinearFloatFast( half sRGB )
			{
				return sRGB * (sRGB * (sRGB * 0.305306011h + 0.682171111h) + 0.012522878h);
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
				half3 Final_Alpha_RGB210_g20718 = half3(0,0,0);
				half Value_Main157_g20718 = _MainValue;
				half TVE_SeasonOptions_X50_g20718 = TVE_SeasonOptions.x;
				half Value_Winter158_g20718 = _AdditionalValue1;
				half temp_output_427_0_g20718 = ( 1.0 - Value_Winter158_g20718 );
				half Value_Spring159_g20718 = _AdditionalValue2;
				half temp_output_428_0_g20718 = ( 1.0 - Value_Spring159_g20718 );
				half TVE_SeasonLerp54_g20718 = TVE_SeasonLerp;
				half lerpResult419_g20718 = lerp( temp_output_427_0_g20718 , temp_output_428_0_g20718 , TVE_SeasonLerp54_g20718);
				half TVE_SeasonOptions_Y51_g20718 = TVE_SeasonOptions.y;
				half Value_Summer160_g20718 = _AdditionalValue3;
				half temp_output_429_0_g20718 = ( 1.0 - Value_Summer160_g20718 );
				half lerpResult422_g20718 = lerp( temp_output_428_0_g20718 , temp_output_429_0_g20718 , TVE_SeasonLerp54_g20718);
				half TVE_SeasonOptions_Z52_g20718 = TVE_SeasonOptions.z;
				half Value_Autumn161_g20718 = _AdditionalValue4;
				half temp_output_430_0_g20718 = ( 1.0 - Value_Autumn161_g20718 );
				half lerpResult407_g20718 = lerp( temp_output_429_0_g20718 , temp_output_430_0_g20718 , TVE_SeasonLerp54_g20718);
				half TVE_SeasonOptions_W53_g20718 = TVE_SeasonOptions.w;
				half lerpResult415_g20718 = lerp( temp_output_430_0_g20718 , temp_output_427_0_g20718 , TVE_SeasonLerp54_g20718);
				half Element_Mode55_g20718 = _ElementMode;
				half lerpResult413_g20718 = lerp( ( 1.0 - ( Value_Main157_g20718 * i.ase_color.r ) ) , ( ( ( TVE_SeasonOptions_X50_g20718 * lerpResult419_g20718 ) + ( TVE_SeasonOptions_Y51_g20718 * lerpResult422_g20718 ) + ( TVE_SeasonOptions_Z52_g20718 * lerpResult407_g20718 ) + ( TVE_SeasonOptions_W53_g20718 * lerpResult415_g20718 ) ) * i.ase_color.r ) , Element_Mode55_g20718);
				half Base_Extras_A423_g20718 = ( 1.0 - lerpResult413_g20718 );
				half4 tex2DNode17_g20718 = tex2D( _MainTex, ( ( ( 1.0 - i.ase_texcoord1.xy ) * (_MainUVs).xy ) + (_MainUVs).zw ) );
				half temp_output_7_0_g20833 = _MainTexMinValue;
				half4 temp_cast_0 = (temp_output_7_0_g20833).xxxx;
				half4 break469_g20718 = saturate( ( ( tex2DNode17_g20718 - temp_cast_0 ) / ( _MainTexMaxValue - temp_output_7_0_g20833 ) ) );
				half MainTex_A74_g20718 = break469_g20718.a;
				half lerpResult701_g20718 = lerp( 1.0 , Base_Extras_A423_g20718 , MainTex_A74_g20718);
				half4 Colors37_g20853 = TVE_ColorsCoords;
				half4 Extras37_g20853 = TVE_ExtrasCoords;
				half4 Motion37_g20853 = TVE_MotionCoords;
				half4 Vertex37_g20853 = TVE_VertexCoords;
				half4 localIS_ELEMENT37_g20853 = IS_ELEMENT( Colors37_g20853 , Extras37_g20853 , Motion37_g20853 , Vertex37_g20853 );
				half4 temp_output_35_0_g20854 = localIS_ELEMENT37_g20853;
				half temp_output_7_0_g20862 = TVE_ElementsFadeValue;
				half2 temp_cast_1 = (temp_output_7_0_g20862).xx;
				half2 temp_output_851_0_g20718 = saturate( ( ( abs( (( (temp_output_35_0_g20854).zw + ( (temp_output_35_0_g20854).xy * (WorldPosition).xz ) )*2.002 + -1.001) ) - temp_cast_1 ) / ( 1.0 - temp_output_7_0_g20862 ) ) );
				half2 break852_g20718 = ( temp_output_851_0_g20718 * temp_output_851_0_g20718 );
				half lerpResult842_g20718 = lerp( 1.0 , ( 1.0 - saturate( ( break852_g20718.x + break852_g20718.y ) ) ) , _ElementVolumeFadeMode);
				half Fade_EdgeMask656_g20718 = lerpResult842_g20718;
				half Element_Intensity56_g20718 = ( _ElementIntensity * i.ase_color.a * Fade_EdgeMask656_g20718 * _RaycastFadeValue );
				half lerpResult378_g20718 = lerp( 1.0 , lerpResult701_g20718 , Element_Intensity56_g20718);
				half Element_BlendA918_g20718 = _ElementBlendA;
				half lerpResult933_g20718 = lerp( lerpResult378_g20718 , ( Base_Extras_A423_g20718 * MainTex_A74_g20718 * Element_Intensity56_g20718 ) , Element_BlendA918_g20718);
				half temp_output_9_0_g20839 = lerpResult933_g20718;
				half sRGB8_g20839 = temp_output_9_0_g20839;
				half localGammaToLinearFloatFast8_g20839 = GammaToLinearFloatFast( sRGB8_g20839 );
				#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g20839 = temp_output_9_0_g20839;
				#else
				float staticSwitch1_g20839 = localGammaToLinearFloatFast8_g20839;
				#endif
				half Final_Alpha_A211_g20718 = staticSwitch1_g20839;
				half4 appendResult472_g20718 = (half4(Final_Alpha_RGB210_g20718 , Final_Alpha_A211_g20718));
				
				
				finalColor = appendResult472_g20718;
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
Node;AmplifyShaderEditor.FunctionNode;136;-640,-1152;Inherit;False;Base Element;2;;20718;0e972c73cae2ee54ea51acc9738801d0;6,477,1,478,0,145,3,481,0,576,1,491,1;0;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;106;-640,-1408;Inherit;False;Define Element Extras;65;;20875;adca672cb6779794dba5f669b4c5f8e3;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-384,-1408;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Alpha Element);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-256,-1408;Half;False;Property;_Message;Message;1;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use the Alpha elements to reduce the leaves amount or the alpha treshold. Useful to create winter sceneries or dead forests and dissolve effects. Element Texture A is used as alpha mask. Particle Color R is used as values multiplier and Alpha as Element Intensity multiplier., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-640,-1280;Inherit;False;Property;_render_src;_render_src;63;1;[HideInInspector];Create;True;0;0;0;True;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-480,-1280;Inherit;False;Property;_render_dst;_render_dst;64;1;[HideInInspector];Create;True;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-304,-1152;Half;False;True;-1;2;TVEShaderElementGUI;0;5;BOXOPHOBIC/The Vegetation Engine/Elements/Default/Extras Alpha;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;0;1;False;;1;False;;1;0;True;_render_src;0;True;_render_dst;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;True;True;False;False;False;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;4;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;PreviewType=Plane;DisableBatching=True=DisableBatching;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
WireConnection;0;0;136;0
ASEEND*/
//CHKSM=2E9C14ECF88FE637FF940120DFD5EAAE5AC669A5