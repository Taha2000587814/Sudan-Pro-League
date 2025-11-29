// Made with Amplify Shader Editor v1.9.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Elements/Default/Motion Interaction"
{
	Properties
	{
		[StyledBanner(Motion Interaction Element)]_Banner("Banner", Float) = 0
		[StyledMessage(Info, Use the Motion Interaction elements to add touch bending to the vegetation objects. Element Texture RG is used a World XZ bending and Texture A is used as interaction mask. Particle Color A is used as Element Intensity multiplier. The Noise direction is controled by the Element Texture RG direction and it is updated with particles or in play mode only., 0,0)]_Message("Message", Float) = 0
		[StyledCategory(Render Settings)]_RenderCat("[ Render Cat ]", Float) = 0
		_ElementIntensity("Render Intensity", Range( 0 , 1)) = 1
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)]_ElementLayerWarning("Render Layer Warning", Float) = 0
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)]_ElementLayerMessage("Render Layer Message", Float) = 0
		[StyledMask(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_ElementLayerMask("Render Layer", Float) = 1
		[Enum(Affect Material Bending,12,Affect Material Interaction,13,Affect Bending and Wind Power,14,Affect Interaction and Wind Power,15)]_ElementInteractionMode("Render Effect", Float) = 15
		[StyledCategory(Element Settings)]_ElementCat("[ Element Cat ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainTex("Element Texture", 2D) = "white" {}
		[Space(10)][StyledRemapSlider(_MainTexMinValue, _MainTexMaxValue, 0, 1)]_MainTexRemap("Element Remap", Vector) = (0,0,0,0)
		[HideInInspector]_MainTexMinValue("Element Min", Range( 0 , 1)) = 0
		[HideInInspector]_MainTexMaxValue("Element Max", Range( 0 , 1)) = 1
		[StyledVector(9)]_MainUVs("Element UVs", Vector) = (1,1,0,0)
		[StyledTextureSingleLine]_NoiseTex("Noise Texture", 2D) = "gray" {}
		[StyledRemapSlider(_NoiseMinValue, _NoiseMaxValue, 0, 1, 10, 0)]_NoiseRemap("Noise Remap", Vector) = (0,0,0,0)
		[HideInInspector]_NoiseMinValue("Noise Min", Range( 0 , 1)) = 0
		[HideInInspector]_NoiseMaxValue("Noise Max", Range( 0 , 1)) = 1
		_NoiseIntensityValue("Noise Intensity", Range( 0 , 1)) = 0
		_NoiseScaleValue("Noise Scale", Range( 0 , 20)) = 1
		_NoiseSpeedValue("Noise Speed", Range( 0 , 2)) = 1
		[Space(10)]_MotionPower("Motion Wind Power", Range( 0 , 1)) = 0
		[Space(10)][StyledToggle]_ElementDirectionMode("Use Particle Movement Direction", Float) = 0
		[StyledToggle]_ElementInvertMode("Use Inverted Element Direction", Float) = 0
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
		[HideInInspector]_IsMotionElement("_IsMotionElement", Float) = 1
		[HideInInspector]_render_colormask("_render_colormask", Float) = 15

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "PreviewType"="Plane" "DisableBatching"="True" }
	LOD 0

		CGINCLUDE
		#pragma target 2.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha, One One
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
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_FRAG_POSITION
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			// Element Type Define
			#define TVE_IS_MOTION_ELEMENT


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
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform half _IsMotionElement;
			uniform half _Banner;
			uniform half _Message;
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
			uniform half _render_colormask;
			uniform sampler2D _MainTex;
			uniform half4 _MainUVs;
			uniform half _MainTexMinValue;
			uniform half _MainTexMaxValue;
			uniform float _ElementDirectionMode;
			uniform float _ElementInvertMode;
			uniform sampler2D _NoiseTex;
			uniform half _NoiseScaleValue;
			uniform half _NoiseSpeedValue;
			uniform half _NoiseMinValue;
			uniform half _NoiseMaxValue;
			uniform half _NoiseIntensityValue;
			uniform half _MotionPower;
			uniform float _ElementIntensity;
			uniform half4 TVE_ColorsCoords;
			uniform half4 TVE_ExtrasCoords;
			uniform half4 TVE_MotionCoords;
			uniform half4 TVE_VertexCoords;
			uniform half TVE_ElementsFadeValue;
			uniform float _ElementVolumeFadeMode;
			uniform half _RaycastFadeValue;
			uniform half _ElementInteractionMode;
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

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_color = v.color;
				o.ase_texcoord2 = v.vertex;
				
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
				float4 tex2DNode17_g20496 = tex2D( _MainTex, ( ( ( 1.0 - i.ase_texcoord1.xy ) * (_MainUVs).xy ) + (_MainUVs).zw ) );
				float temp_output_7_0_g20833 = _MainTexMinValue;
				float4 temp_cast_0 = (temp_output_7_0_g20833).xxxx;
				float4 break469_g20496 = saturate( ( ( tex2DNode17_g20496 - temp_cast_0 ) / ( _MainTexMaxValue - temp_output_7_0_g20833 ) ) );
				half MainTex_R73_g20496 = break469_g20496.r;
				float temp_output_270_0_g20496 = (MainTex_R73_g20496*2.0 + -1.0);
				half MainTex_G265_g20496 = break469_g20496.g;
				float temp_output_269_0_g20496 = (MainTex_G265_g20496*2.0 + -1.0);
				float3 appendResult274_g20496 = (float3(temp_output_270_0_g20496 , 0.0 , temp_output_269_0_g20496));
				float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
				float3 temp_output_1083_0_g20496 = ( mul( unity_ObjectToWorld, float4( appendResult274_g20496 , 0.0 ) ).xyz / ase_objectScale );
				float3 break281_g20496 = temp_output_1083_0_g20496;
				half normalX_WS284_g20496 = break281_g20496.x;
				half Element_DirectionMode1013_g20496 = _ElementDirectionMode;
				float lerpResult1032_g20496 = lerp( normalX_WS284_g20496 , (i.ase_color.r*2.0 + -1.0) , Element_DirectionMode1013_g20496);
				half Element_InvertMode489_g20496 = _ElementInvertMode;
				float lerpResult353_g20496 = lerp( lerpResult1032_g20496 , -lerpResult1032_g20496 , Element_InvertMode489_g20496);
				half Direction_TextureX1150_g20496 = lerpResult353_g20496;
				half normalZ_WS285_g20496 = break281_g20496.z;
				float lerpResult1033_g20496 = lerp( normalZ_WS285_g20496 , (i.ase_color.g*2.0 + -1.0) , Element_DirectionMode1013_g20496);
				float lerpResult1038_g20496 = lerp( lerpResult1033_g20496 , -lerpResult1033_g20496 , Element_InvertMode489_g20496);
				half Direction_TextureZ1151_g20496 = lerpResult1038_g20496;
				float2 appendResult959_g20496 = (float2(( -i.ase_texcoord2.xyz.x * Direction_TextureX1150_g20496 ) , ( -i.ase_texcoord2.xyz.z * Direction_TextureZ1151_g20496 )));
				half Noise_Scale892_g20496 = _NoiseScaleValue;
				half Noise_Speed898_g20496 = _NoiseSpeedValue;
				half Noise_Min893_g20496 = _NoiseMinValue;
				float temp_output_7_0_g20848 = Noise_Min893_g20496;
				float4 temp_cast_3 = (temp_output_7_0_g20848).xxxx;
				half Noise_Max894_g20496 = _NoiseMaxValue;
				float4 break997_g20496 = saturate( ( ( tex2D( _NoiseTex, ( ( appendResult959_g20496 * Noise_Scale892_g20496 ) + ( _Time.y * Noise_Speed898_g20496 ) ) ) - temp_cast_3 ) / ( Noise_Max894_g20496 - temp_output_7_0_g20848 ) ) );
				half Noise_InteractionX972_g20496 = break997_g20496.r;
				half Noise_Intensity965_g20496 = _NoiseIntensityValue;
				float lerpResult979_g20496 = lerp( (Direction_TextureX1150_g20496*0.5 + 0.5) , Noise_InteractionX972_g20496 , Noise_Intensity965_g20496);
				half Noise_InteractionZ973_g20496 = break997_g20496.g;
				float lerpResult982_g20496 = lerp( (Direction_TextureZ1151_g20496*0.5 + 0.5) , Noise_InteractionZ973_g20496 , Noise_Intensity965_g20496);
				half Motion_Power1000_g20496 = _MotionPower;
				float3 appendResult292_g20496 = (float3(lerpResult979_g20496 , lerpResult982_g20496 , Motion_Power1000_g20496));
				half3 Final_MotionInteraction_RGB303_g20496 = appendResult292_g20496;
				half MainTex_A74_g20496 = break469_g20496.a;
				half4 Colors37_g20853 = TVE_ColorsCoords;
				half4 Extras37_g20853 = TVE_ExtrasCoords;
				half4 Motion37_g20853 = TVE_MotionCoords;
				half4 Vertex37_g20853 = TVE_VertexCoords;
				half4 localIS_ELEMENT37_g20853 = IS_ELEMENT( Colors37_g20853 , Extras37_g20853 , Motion37_g20853 , Vertex37_g20853 );
				float4 temp_output_35_0_g20854 = localIS_ELEMENT37_g20853;
				float temp_output_7_0_g20862 = TVE_ElementsFadeValue;
				float2 temp_cast_4 = (temp_output_7_0_g20862).xx;
				float2 temp_output_851_0_g20496 = saturate( ( ( abs( (( (temp_output_35_0_g20854).zw + ( (temp_output_35_0_g20854).xy * (WorldPosition).xz ) )*2.002 + -1.001) ) - temp_cast_4 ) / ( 1.0 - temp_output_7_0_g20862 ) ) );
				float2 break852_g20496 = ( temp_output_851_0_g20496 * temp_output_851_0_g20496 );
				float lerpResult842_g20496 = lerp( 1.0 , ( 1.0 - saturate( ( break852_g20496.x + break852_g20496.y ) ) ) , _ElementVolumeFadeMode);
				half Fade_EdgeMask656_g20496 = lerpResult842_g20496;
				half Element_Intensity56_g20496 = ( _ElementIntensity * i.ase_color.a * Fade_EdgeMask656_g20496 * _RaycastFadeValue );
				half Element_EffectInteraction946_g20496 = _ElementInteractionMode;
				half Final_MotionInteraction_A305_g20496 = ( ( MainTex_A74_g20496 * Element_Intensity56_g20496 ) + ( Element_EffectInteraction946_g20496 * 0.0 ) );
				float4 appendResult479_g20496 = (float4(Final_MotionInteraction_RGB303_g20496 , Final_MotionInteraction_A305_g20496));
				
				
				finalColor = appendResult479_g20496;
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
Node;AmplifyShaderEditor.FunctionNode;177;-640,-1280;Inherit;False;Define Element Motion;63;;19669;6eebc31017d99e84e811285e6a5d199d;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-352,-1280;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Motion Interaction Element);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-224,-1280;Half;False;Property;_Message;Message;1;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use the Motion Interaction elements to add touch bending to the vegetation objects. Element Texture RG is used a World XZ bending and Texture A is used as interaction mask. Particle Color A is used as Element Intensity multiplier. The Noise direction is controled by the Element Texture RG direction and it is updated with particles or in play mode only., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;277;-639,-1024;Inherit;False;Base Element;2;;20496;0e972c73cae2ee54ea51acc9738801d0;6,477,2,478,0,145,3,481,3,576,1,491,1;0;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;197;-640,-1152;Half;False;Property;_render_colormask;_render_colormask;65;1;[HideInInspector];Create;True;0;0;0;True;0;False;15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-320,-1024;Float;False;True;-1;2;TVEShaderElementGUI;0;5;BOXOPHOBIC/The Vegetation Engine/Elements/Default/Motion Interaction;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;;10;False;;4;1;False;;1;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;True;True;True;True;True;True;0;True;_render_colormask;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;4;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;PreviewType=Plane;DisableBatching=True=DisableBatching;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
WireConnection;0;0;277;0
ASEEND*/
//CHKSM=3ACD3C6D0847D12977967C81526F2DF5F8280D74