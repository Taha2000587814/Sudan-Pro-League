Shader "Custom/PitchGrass"
{
	Properties
	{
		[MainTexture] _BaseColorTex("Pitch Texture", 2D) = "white" {}
		_GrassTint("Grass Tint", Color) = (1,1,1,1)
		_GrassDetailTex("Grass Detail Texture", 2D) = "white" {}
		_GrassDetailScale("Grass Detail Scale", Range(1, 50)) = 10
	}

		SubShader
		{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
			#pragma surface surf Standard addshadow
			#include "UnityCG.cginc"

			sampler2D _BaseColorTex;
			sampler2D _GrassDetailTex;
			float4 _GrassTint;
			float _GrassDetailScale;

			struct Input
			{
				float2 uv_BaseColorTex;
			};

			void surf(Input IN, inout SurfaceOutputStandard o)
			{
				// Main pitch texture (macro)
				float4 pitchTex = tex2D(_BaseColorTex, IN.uv_BaseColorTex);

				// Grass detail texture (micro, tiled)
				float2 detailUV = IN.uv_BaseColorTex * _GrassDetailScale;
				float4 detailTex = tex2D(_GrassDetailTex, detailUV);

				// Blend: multiply pitch with detail, then tint
				float3 finalColor = pitchTex.rgb * detailTex.rgb * _GrassTint.rgb;

				o.Albedo = finalColor;
				o.Alpha = 1.0;
			}
			ENDCG
		}

			FallBack "Diffuse"
}
