//Cristian Pop - https://boxophobic.com/

using UnityEditor;
using UnityEngine;
using System.Collections.Generic;
using System.IO;

namespace TheVegetationEngine
{
    public class TVEUtils
    {
        // Material Utils
        public static void SetMaterialSettings(Material material)
        {
            var shaderName = material.shader.name;

            if (!material.HasProperty("_IsTVEShader"))
            {
                return;
            }

            if (material.HasProperty("_IsVersion"))
            {
                var version = material.GetInt("_IsVersion");

                if (version < 500)
                {
                    if (material.HasProperty("_RenderPriority"))
                    {
                        if (material.GetInt("_RenderPriority") != 0)
                        {
                            material.SetInt("_RenderQueue", 1);
                        }
                    }

                    material.SetInt("_IsVersion", 500);
                }

                if (version < 600)
                {
                    if (material.HasProperty("_LayerReactValue"))
                    {
                        material.SetInt("_LayerVertexValue", material.GetInt("_LayerReactValue"));
                    }

                    material.SetInt("_IsVersion", 600);
                }

                if (version < 620)
                {
                    if (material.HasProperty("_VertexRollingMode"))
                    {
                        material.SetInt("_MotionValue_20", material.GetInt("_VertexRollingMode"));
                    }

                    material.SetInt("_IsVersion", 620);
                }

                if (version < 630)
                {
                    material.DisableKeyword("TVE_DETAIL_BLEND_OVERLAY");
                    material.DisableKeyword("TVE_DETAIL_BLEND_REPLACE");

                    material.SetInt("_IsVersion", 630);
                }

                if (version < 640)
                {
                    if (material.HasProperty("_Cutoff"))
                    {
                        material.SetFloat("_AlphaCutoffValue", material.GetFloat("_Cutoff"));
                    }

                    material.SetInt("_IsVersion", 640);
                }

                if (version < 650)
                {
                    if (material.HasProperty("_Cutoff"))
                    {
                        material.SetFloat("_AlphaClipValue", material.GetFloat("_Cutoff"));
                    }

                    if (material.HasProperty("_MotionValue_20"))
                    {
                        material.SetFloat("_MotionValue_20", 1);
                    }

                    // Guess best values for squash motion
                    if (material.HasProperty("_MotionScale_20") && material.HasProperty("_MaxBoundsInfo"))
                    {
                        var bounds = material.GetVector("_MaxBoundsInfo");
                        var scale = Mathf.Round((1.0f / bounds.y * 10.0f * 0.5f) * 10) / 10;

                        if (scale > 1)
                        {
                            scale = Mathf.FloorToInt(scale);
                        }

                        material.SetFloat("_MotionScale_20", scale);
                    }

                    if (material.shader.name.Contains("Bark"))
                    {
                        material.SetFloat("_DetailCoordMode", 1);
                    }

                    if (material.shader.name.Contains("Grass"))
                    {
                        if (material.HasProperty("_ColorsMaskMinValue") && material.HasProperty("_ColorsMaskMaxValue"))
                        {
                            var min = material.GetFloat("_ColorsMaskMinValue");
                            var max = material.GetFloat("_ColorsMaskMaxValue");

                            material.SetFloat("_ColorsMaskMinValue", max);
                            material.SetFloat("_ColorsMaskMaxValue", min);
                        }

                        material.SetFloat("_MotionNormalValue", 0);
                    }

                    material.DisableKeyword("TVE_ALPHA_CLIP");
                    material.DisableKeyword("TVE_DETAIL_MODE_ON");
                    material.DisableKeyword("TVE_DETAIL_MODE_OFF");
                    material.DisableKeyword("TVE_DETAIL_TYPE_VERTEX_BLUE");
                    material.DisableKeyword("TVE_DETAIL_TYPE_PROJECTION");
                    material.DisableKeyword("TVE_IS_VEGETATION_SHADER");
                    material.DisableKeyword("TVE_IS_GRASS_SHADER");

                    material.SetInt("_IsVersion", 650);
                }

                if (version < 700)
                {
                    // Requires revalidation
                    material.SetInt("_IsVersion", 700);
                }

                if (version < 710)
                {
                    if (material.HasProperty("_MotionScale_20"))
                    {
                        var scale = material.GetFloat("_MotionScale_20");

                        material.SetFloat("_MotionScale_20", scale * 10.0f);
                    }

                    material.SetInt("_IsVersion", 710);
                }
            }

            // Set Internal Render Values
            if (material.HasProperty("_RenderMode"))
            {
                material.SetInt("_render_mode", material.GetInt("_RenderMode"));
            }

            if (material.HasProperty("_RenderCull"))
            {
                material.SetInt("_render_cull", material.GetInt("_RenderCull"));
            }

            if (material.HasProperty("_RenderZWrite"))
            {
                material.SetInt("_render_zw", material.GetInt("_RenderZWrite"));
            }

            if (material.HasProperty("_RenderClip"))
            {
                material.SetInt("_render_clip", material.GetInt("_RenderClip"));
            }

            if (material.HasProperty("_RenderSpecular"))
            {
                material.SetInt("_render_specular", material.GetInt("_RenderSpecular"));
            }

            // Set Render Mode
            if (material.HasProperty("_RenderMode"))
            {
                int mode = material.GetInt("_RenderMode");
                int zwrite = material.GetInt("_RenderZWrite");
                int queue = 0;
                int priority = 0;

                if (material.HasProperty("_RenderQueue") && material.HasProperty("_RenderPriority"))
                {
                    queue = material.GetInt("_RenderQueue");
                    priority = material.GetInt("_RenderPriority");
                }

                // User Defined, render type changes needed
                if (queue == 2)
                {
                    if (material.renderQueue == 2000)
                    {
                        material.SetOverrideTag("RenderType", "Opaque");
                    }

                    if (material.renderQueue > 2449 && material.renderQueue < 3000)
                    {
                        material.SetOverrideTag("RenderType", "AlphaTest");
                    }

                    if (material.renderQueue > 2999)
                    {
                        material.SetOverrideTag("RenderType", "Transparent");
                    }
                }

                // Opaque
                if (mode == 0)
                {
                    if (queue != 2)
                    {
                        material.SetOverrideTag("RenderType", "AlphaTest");
                        material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest + priority;
                    }

                    // Standard and Universal Render Pipeline
                    material.SetInt("_render_src", (int)UnityEngine.Rendering.BlendMode.One);
                    material.SetInt("_render_dst", (int)UnityEngine.Rendering.BlendMode.Zero);
                    material.SetInt("_render_zw", 1);
                    material.SetInt("_render_premul", 0);

                    // Set Main Color alpha to 1
                    if (material.HasProperty("_MainColor"))
                    {
                        var mainColor = material.GetColor("_MainColor");
                        material.SetColor("_MainColor", new Color(mainColor.r, mainColor.g, mainColor.b, 1.0f));
                    }

                    // HD Render Pipeline
                    material.DisableKeyword("_SURFACE_TYPE_TRANSPARENT");
                    material.DisableKeyword("_ENABLE_FOG_ON_TRANSPARENT");

                    material.DisableKeyword("_BLENDMODE_ALPHA");
                    material.DisableKeyword("_BLENDMODE_ADD");
                    material.DisableKeyword("_BLENDMODE_PRE_MULTIPLY");

                    material.SetInt("_RenderQueueType", 1);
                    material.SetInt("_SurfaceType", 0);
                    material.SetInt("_BlendMode", 0);
                    material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
                    material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
                    material.SetInt("_AlphaSrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
                    material.SetInt("_AlphaDstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
                    material.SetInt("_ZWrite", 1);
                    material.SetInt("_TransparentZWrite", 1);
                    material.SetInt("_ZTestDepthEqualForOpaque", 3);
                    material.SetInt("_ZTestGBuffer", 4);
                    material.SetInt("_ZTestTransparent", 4);

                    material.SetShaderPassEnabled("TransparentBackface", false);
                    material.SetShaderPassEnabled("TransparentBackfaceDebugDisplay", false);
                    material.SetShaderPassEnabled("TransparentDepthPrepass", false);
                    material.SetShaderPassEnabled("TransparentDepthPostpass", false);
                }
                // Transparent
                else
                {
                    if (queue != 2)
                    {
                        material.SetOverrideTag("RenderType", "Transparent");
                        material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent + priority;
                    }

                    // Standard and Universal Render Pipeline
                    material.SetInt("_render_src", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
                    material.SetInt("_render_dst", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                    material.SetInt("_render_premul", 0);

                    // HD Render Pipeline
                    material.EnableKeyword("_SURFACE_TYPE_TRANSPARENT");
                    material.EnableKeyword("_ENABLE_FOG_ON_TRANSPARENT");

                    material.EnableKeyword("_BLENDMODE_ALPHA");
                    material.DisableKeyword("_BLENDMODE_ADD");
                    material.DisableKeyword("_BLENDMODE_PRE_MULTIPLY");

                    material.SetInt("_RenderQueueType", 5);
                    material.SetInt("_SurfaceType", 1);
                    material.SetInt("_BlendMode", 0);
                    material.SetInt("_SrcBlend", 1);
                    material.SetInt("_DstBlend", 10);
                    material.SetInt("_AlphaSrcBlend", 1);
                    material.SetInt("_AlphaDstBlend", 10);
                    material.SetInt("_ZWrite", zwrite);
                    material.SetInt("_TransparentZWrite", zwrite);
                    material.SetInt("_ZTestDepthEqualForOpaque", 4);
                    material.SetInt("_ZTestGBuffer", 4);
                    material.SetInt("_ZTestTransparent", 4);

                    material.SetShaderPassEnabled("TransparentBackface", true);
                    material.SetShaderPassEnabled("TransparentBackfaceDebugDisplay", true);
                    material.SetShaderPassEnabled("TransparentDepthPrepass", true);
                    material.SetShaderPassEnabled("TransparentDepthPostpass", true);
                }
            }

            if (shaderName.Contains("Prop") || shaderName.Contains("Objects"))
            {
                material.SetShaderPassEnabled("MotionVectors", false);
            }
            else
            {
                material.SetShaderPassEnabled("MotionVectors", true);
            }

            // Set Receive Mode in HDRP
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
            {
                if (material.HasProperty("_RenderDecals"))
                {
                    int decals = material.GetInt("_RenderDecals");

                    if (decals == 0)
                    {
                        material.EnableKeyword("_DISABLE_DECALS");
                    }
                    else
                    {
                        material.DisableKeyword("_DISABLE_DECALS");
                    }
                }

                if (material.HasProperty("_RenderSSR"))
                {
                    int ssr = material.GetInt("_RenderSSR");

                    if (ssr == 0)
                    {
                        material.EnableKeyword("_DISABLE_SSR");

                        material.SetInt("_StencilRef", 0);
                        material.SetInt("_StencilRefDepth", 0);
                        material.SetInt("_StencilRefDistortionVec", 4);
                        material.SetInt("_StencilRefGBuffer", 2);
                        material.SetInt("_StencilRefMV", 32);
                        material.SetInt("_StencilWriteMask", 6);
                        material.SetInt("_StencilWriteMaskDepth", 8);
                        material.SetInt("_StencilWriteMaskDistortionVec", 4);
                        material.SetInt("_StencilWriteMaskGBuffer", 14);
                        material.SetInt("_StencilWriteMaskMV", 40);
                    }
                    else
                    {
                        material.DisableKeyword("_DISABLE_SSR");

                        material.SetInt("_StencilRef", 0);
                        material.SetInt("_StencilRefDepth", 8);
                        material.SetInt("_StencilRefDistortionVec", 4);
                        material.SetInt("_StencilRefGBuffer", 10);
                        material.SetInt("_StencilRefMV", 40);
                        material.SetInt("_StencilWriteMask", 6);
                        material.SetInt("_StencilWriteMaskDepth", 8);
                        material.SetInt("_StencilWriteMaskDistortionVec", 4);
                        material.SetInt("_StencilWriteMaskGBuffer", 14);
                        material.SetInt("_StencilWriteMaskMV", 40);
                    }
                }
            }

            // Set Cull Mode
            if (material.HasProperty("_RenderCull"))
            {
                int cull = material.GetInt("_RenderCull");

                material.SetInt("_CullMode", cull);
                material.SetInt("_TransparentCullMode", cull);
                material.SetInt("_CullModeForward", cull);

                // Needed for HD Render Pipeline
                material.DisableKeyword("_DOUBLESIDED_ON");
            }

            // Set Clip Mode
            if (material.HasProperty("_RenderClip"))
            {
                int clip = material.GetInt("_RenderClip");
                float cutoff = material.GetFloat("_AlphaClipValue");

                if (clip == 0)
                {
                    material.DisableKeyword("TVE_FEATURE_CLIP");
                    material.SetInt("_render_coverage", 0);
                    material.SetFloat("_AlphaClipValue", 0.5f);

                    if (shaderName.Contains("Impostor"))
                    {
                        material.SetFloat("_AlphaFeatherValue", 0.2f);
                    }
                    else
                    {
                        material.SetFloat("_AlphaFeatherValue", 0.5f);
                    }
                }
                else
                {
                    material.EnableKeyword("TVE_FEATURE_CLIP");

                    if (material.HasProperty("_RenderCoverage"))
                    {
                        material.SetInt("_render_coverage", material.GetInt("_RenderCoverage"));
                    }
                }

                material.SetFloat("_Cutoff", cutoff);

                // HD Render Pipeline
                material.SetFloat("_AlphaCutoff", cutoff);
                material.SetFloat("_AlphaCutoffPostpass", cutoff);
                material.SetFloat("_AlphaCutoffPrepass", cutoff);
                material.SetFloat("_AlphaCutoffShadow", cutoff);
            }

            // Set Normals Mode
            if (material.HasProperty("_RenderNormals") && material.HasProperty("_render_normals"))
            {
                int normals = material.GetInt("_RenderNormals");

                // Standard, Universal, HD Render Pipeline
                // Flip 0
                if (normals == 0)
                {
                    material.SetVector("_render_normals", new Vector4(-1, -1, -1, 0));
                    material.SetVector("_DoubleSidedConstants", new Vector4(-1, -1, -1, 0));
                }
                // Mirror 1
                else if (normals == 1)
                {
                    material.SetVector("_render_normals", new Vector4(1, 1, -1, 0));
                    material.SetVector("_DoubleSidedConstants", new Vector4(1, 1, -1, 0));
                }
                // None 2
                else if (normals == 2)
                {
                    material.SetVector("_render_normals", new Vector4(1, 1, 1, 0));
                    material.SetVector("_DoubleSidedConstants", new Vector4(1, 1, 1, 0));
                }
            }

            if (material.HasProperty("_RenderDirect") && material.HasProperty("_render_direct"))
            {
                float value = material.GetFloat("_RenderDirect");

                material.SetFloat("_render_direct", value);
            }

            if (material.HasProperty("_RenderShadow") && material.HasProperty("_render_shadow"))
            {
                float value = material.GetFloat("_RenderShadow");

                material.SetFloat("_render_shadow", value);
            }

            if (material.HasProperty("_RenderAmbient") && material.HasProperty("_render_ambient"))
            {
                float value = material.GetFloat("_RenderAmbient");

                material.SetFloat("_render_ambient", value);
            }

#if UNITY_EDITOR
            // Assign Default HD Foliage profile
            if (material.HasProperty("_SubsurfaceDiffusion"))
            {
                if (material.GetFloat("_SubsurfaceDiffusion") == 0)
                {
                    // Get the old diffusion with projects created with sample project
                    if (AssetDatabase.GUIDToAssetPath("78322c7f82657514ebe48203160e3f39") != "")
                    {
                        material.SetFloat("_SubsurfaceDiffusion", 3.5648174285888672f);
                        material.SetVector("_SubsurfaceDiffusion_asset", new Vector4(228889264007084710000000000000000000000f, 0.000000000000000000000000012389357880079404f, 0.00000000000000000000000000000000000076932702684439582f, 0.00018220426863990724f));
                        material.SetVector("_SubsurfaceDiffusion_Asset", new Vector4(228889264007084710000000000000000000000f, 0.000000000000000000000000012389357880079404f, 0.00000000000000000000000000000000000076932702684439582f, 0.00018220426863990724f));
                    }

                    // Get the new diffusion with projects created from empty template
                    if (AssetDatabase.GUIDToAssetPath("879ffae44eefa4412bb327928f1a96dd") != "")
                    {
                        material.SetFloat("_SubsurfaceDiffusion", 2.6486763954162598f);
                        material.SetVector("_SubsurfaceDiffusion_asset", new Vector4(-36985449400010195000000f, 20.616847991943359f, -0.00000000000000000000000000052916750040661612f, -1352014335655804900f));
                        material.SetVector("_SubsurfaceDiffusion_Asset", new Vector4(-36985449400010195000000f, 20.616847991943359f, -0.00000000000000000000000000052916750040661612f, -1352014335655804900f));
                    }
                }

                // Workaround when the old diffusion is set but the HDRP 12 diffusion should be used instead
                if (material.GetFloat("_SubsurfaceDiffusion") == 3.5648174285888672f && AssetDatabase.GUIDToAssetPath("78322c7f82657514ebe48203160e3f39") == "" && AssetDatabase.GUIDToAssetPath("879ffae44eefa4412bb327928f1a96dd") != "")
                {
                    material.SetFloat("_SubsurfaceDiffusion", 2.6486763954162598f);
                    material.SetVector("_SubsurfaceDiffusion_asset", new Vector4(-36985449400010195000000f, 20.616847991943359f, -0.00000000000000000000000000052916750040661612f, -1352014335655804900f));
                    material.SetVector("_SubsurfaceDiffusion_Asset", new Vector4(-36985449400010195000000f, 20.616847991943359f, -0.00000000000000000000000000052916750040661612f, -1352014335655804900f));
                }
            }
#endif


            // Set Detail Mode
            if (material.HasProperty("_DetailMode") && material.HasProperty("_SecondColor"))
            {
                if (material.GetInt("_DetailMode") == 0)
                {
                    material.DisableKeyword("TVE_FEATURE_DETAIL");
                }
                else
                {
                    material.EnableKeyword("TVE_FEATURE_DETAIL");
                }
            }

            // Set GI Mode
            if (material.HasProperty("_EmissiveFlagMode"))
            {
                int flag = material.GetInt("_EmissiveFlagMode");

                if (flag == 0)
                {
                    material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.None;
                }
                else if (flag == 10)
                {
                    material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.AnyEmissive;
                }
                else if (flag == 20)
                {
                    material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.BakedEmissive;
                }
                else if (flag == 30)
                {
                    material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.RealtimeEmissive;
                }
            }

            // Set Batching Mode
            if (material.HasProperty("_VertexDataMode"))
            {
                int batching = material.GetInt("_VertexDataMode");

                if (batching == 0)
                {
                    material.DisableKeyword("TVE_FEATURE_BATCHING");
                }
                else
                {
                    material.EnableKeyword("TVE_FEATURE_BATCHING");
                }
            }

            // Set Legacy props for external bakers
            if (material.HasProperty("_AlphaClipValue"))
            {
                material.SetFloat("_Cutoff", material.GetFloat("_AlphaClipValue"));
            }

            // Set Legacy props for external bakers
            if (material.HasProperty("_MainColor"))
            {
                material.SetColor("_Color", material.GetColor("_MainColor"));
            }

            // Set BlinnPhong Spec Color
            if (material.HasProperty("_SpecColor"))
            {
                material.SetColor("_SpecColor", Color.white);
            }

            if (material.HasProperty("_MainAlbedoTex"))
            {
                material.SetTexture("_MainTex", material.GetTexture("_MainAlbedoTex"));
            }

            if (material.HasProperty("_MainNormalTex"))
            {
                material.SetTexture("_BumpMap", material.GetTexture("_MainNormalTex"));
            }

            if (material.HasProperty("_MainUVs"))
            {
                material.SetTextureScale("_MainTex", new Vector2(material.GetVector("_MainUVs").x, material.GetVector("_MainUVs").y));
                material.SetTextureOffset("_MainTex", new Vector2(material.GetVector("_MainUVs").z, material.GetVector("_MainUVs").w));

                material.SetTextureScale("_BumpMap", new Vector2(material.GetVector("_MainUVs").x, material.GetVector("_MainUVs").y));
                material.SetTextureOffset("_BumpMap", new Vector2(material.GetVector("_MainUVs").z, material.GetVector("_MainUVs").w));
            }

            if (material.HasProperty("_SubsurfaceValue"))
            {
                // Subsurface Standard Render Pipeline
                material.SetFloat("_Translucency", material.GetFloat("_SubsurfaceScatteringValue"));
                material.SetFloat("_TransScattering", material.GetFloat("_SubsurfaceAngleValue"));
                material.SetFloat("_TransNormalDistortion", material.GetFloat("_SubsurfaceNormalValue"));
                material.SetFloat("_TransDirect", material.GetFloat("_SubsurfaceDirectValue"));
                material.SetFloat("_TransAmbient", material.GetFloat("_SubsurfaceAmbientValue"));
                material.SetFloat("_TransShadow", material.GetFloat("_SubsurfaceShadowValue"));

                //Subsurface Universal Render Pipeline
                material.SetFloat("_TransStrength", material.GetFloat("_SubsurfaceScatteringValue"));
                material.SetFloat("_TransNormal", material.GetFloat("_SubsurfaceNormalValue"));
            }

            // Set internals for impostor baking 
            if (material.HasProperty("_VertexOcclusionColor"))
            {
                material.SetInt("_HasOcclusion", 1);
            }
            else
            {
                material.SetInt("_HasOcclusion", 0);
            }

            if (material.HasProperty("_GradientColorOne"))
            {
                material.SetInt("_HasGradient", 1);
            }
            else
            {
                material.SetInt("_HasGradient", 0);
            }

            if (material.HasProperty("_EmissiveColor"))
            {
                material.SetInt("_HasEmissive", 1);
            }
            else
            {
                material.SetInt("_HasEmissive", 0);
            }

            // Enable Nature Rendered support
            material.SetOverrideTag("NatureRendererInstancing", "True");

            // Set Internal shader type
            if (shaderName.Contains("Vertex Lit"))
            {
                material.SetInt("_IsVertexShader", 1);
                material.SetInt("_IsSimpleShader", 0);
                material.SetInt("_IsStandardShader", 0);
                material.SetInt("_IsSubsurfaceShader", 0);
            }

            if (shaderName.Contains("Simple Lit"))
            {
                material.SetInt("_IsVertexShader", 0);
                material.SetInt("_IsSimpleShader", 1);
                material.SetInt("_IsStandardShader", 0);
                material.SetInt("_IsSubsurfaceShader", 0);
            }

            if (shaderName.Contains("Standard Lit"))
            {
                material.SetInt("_IsVertexShader", 0);
                material.SetInt("_IsSimpleShader", 0);
                material.SetInt("_IsStandardShader", 1);
                material.SetInt("_IsSubsurfaceShader", 0);
            }

            if (shaderName.Contains("Subsurface Lit"))
            {
                material.SetInt("_IsVertexShader", 0);
                material.SetInt("_IsSimpleShader", 0);
                material.SetInt("_IsStandardShader", 0);
                material.SetInt("_IsSubsurfaceShader", 1);
            }
        }

        public static void SetElementSettings(Material material)
        {
            if (material.HasProperty("_IsVersion"))
            {
                var version = material.GetInt("_IsVersion");

                if (version < 600)
                {
                    if (material.HasProperty("_ElementLayerValue"))
                    {
                        var oldLayer = material.GetInt("_ElementLayerValue");

                        if (material.GetInt("_ElementLayerValue") > 0)
                        {
                            material.SetInt("_ElementLayerMask", (int)Mathf.Pow(2, oldLayer));
                            material.SetInt("_ElementLayerValue", -1);
                        }
                    }

                    if (material.HasProperty("_InvertX"))
                    {
                        material.SetInt("_ElementInvertMode", material.GetInt("_InvertX"));
                    }

                    if (material.HasProperty("_ElementFadeSupport"))
                    {
                        material.SetInt("_ElementVolumeFadeMode", material.GetInt("_ElementFadeSupport"));
                    }

                    material.SetInt("_IsVersion", 600);
                }

                if (version < 700)
                {
                    // Requires revalidation
                    material.SetInt("_IsVersion", 700);
                }
            }

            if (material.HasProperty("_IsColorsElement"))
            {
                material.SetOverrideTag("ElementType", "ColorsElement");
            }
            else if (material.HasProperty("_IsExtrasElement"))
            {
                material.SetOverrideTag("ElementType", "ExtrasElement");
            }
            else if (material.HasProperty("_IsMotionElement"))
            {
                material.SetOverrideTag("ElementType", "MotionElement");
            }
            else if (material.HasProperty("_IsVertexElement"))
            {
                material.SetOverrideTag("ElementType", "VertexElement");
            }

            if (material.HasProperty("_ElementColorsMode"))
            {
                var effect = material.GetInt("_ElementColorsMode");

                material.SetInt("_render_colormask", effect);
            }

            if (material.HasProperty("_ElementInteractionMode"))
            {
                var effect = material.GetInt("_ElementInteractionMode");

                material.SetInt("_render_colormask", effect);
            }

            if (material.HasProperty("_ElementBlendA"))
            {
                var blend = material.GetInt("_ElementBlendA");

                if (blend == 0)
                {
                    material.SetInt("_render_src", (int)UnityEngine.Rendering.BlendMode.DstColor);
                    material.SetInt("_render_dst", (int)UnityEngine.Rendering.BlendMode.Zero);
                }
                else
                {
                    material.SetInt("_render_src", (int)UnityEngine.Rendering.BlendMode.One);
                    material.SetInt("_render_dst", (int)UnityEngine.Rendering.BlendMode.One);
                }
            }

            //if (material.HasProperty("_ElementRaycastMode"))
            //{
            //    var raycast = material.GetInt("_ElementRaycastMode");

            //    if (raycast == 1)
            //    {
            //        material.enableInstancing = false;
            //    }
            //}

#if UNITY_EDITOR
            if (material.HasProperty("_ElementLayerMask"))
            {
                var layers = material.GetInt("_ElementLayerMask");

                if (layers > 1)
                {
                    material.SetInt("_ElementLayerMessage", 1);
                }
                else
                {
                    material.SetInt("_ElementLayerMessage", 0);
                }

                if (layers == -1)
                {
                    material.SetInt("_ElementLayerWarning", 1);
                }
                else
                {
                    material.SetInt("_ElementLayerWarning", 0);
                }
            }
#endif
        }

        // Element Utils
        public static TVEElementData CreateElementData(TVEElement element)
        {
            var elementData = new TVEElementData();

            elementData.element = element;
            elementData.elementDataID = element.GetHashCode();
            //elementData.gameObject = gameObject;
            //elementData.renderer = element.gameObject.GetComponent<Renderer>();
            //elementData.material = element.elementMaterial;

            //elementData.fadeValue = 1.0f;

            if (elementData.element.customVisibility == ElementVisibility.UseGlobalVolumeSettings)
            {
                elementData.useGlobalVolumeVisibility = true;
            }
            else
            {
                elementData.useGlobalVolumeVisibility = false;
            }

            if (elementData.element.elementMesh != null && elementData.element.elementMaterial.enableInstancing == true)
            {
                elementData.instancedDataID = elementData.element.elementMesh.GetHashCode() + elementData.element.elementMaterial.GetHashCode();
            }

            return elementData;
        }

        public static void AddElementDataToVolume(TVEElementData elementData)
        {
            if (TVEManager.Instance == null)
            {
                return;
            }

            var renderDataSet = TVEManager.Instance.globalVolume.renderDataSet;
            var renderElements = TVEManager.Instance.globalVolume.renderElements;
            var renderInstanced = TVEManager.Instance.globalVolume.renderInstanced;

            for (int i = 0; i < renderDataSet.Count; i++)
            {
                var renderData = renderDataSet[i];

                if (renderData == null)
                {
                    continue;
                }

                var id = elementData.element.elementMaterial.GetTag(TVEConstants.ElementTypeTag, false).GetHashCode();

                elementData.renderDataID = id;

                if (renderData.useRenderTextureArray)
                {
                    elementData.layers = new List<int>(9);
                    var maxLayer = 0;

                    if (elementData.element.elementMaterial.HasProperty(TVEConstants.ElementLayerMask))
                    {
                        var bitmask = elementData.element.elementMaterial.GetInt(TVEConstants.ElementLayerMask);

                        for (int m = 0; m < 9; m++)
                        {
                            if (((1 << m) & bitmask) != 0)
                            {
                                elementData.layers.Add(1);
                                maxLayer = m;
                            }
                            else
                            {
                                elementData.layers.Add(0);
                            }
                        }
                    }
                    else
                    {
                        elementData.layers.Add(1);

                        for (int m = 1; m < 9; m++)
                        {
                            elementData.layers.Add(0);
                        }
                    }

                    if (maxLayer > renderData.bufferSize)
                    {
                        renderData.bufferSize = maxLayer;
                        TVEManager.Instance.globalVolume.CreateRenderBuffer(renderData);
                    }
                }
                else
                {
                    elementData.layers = new List<int>(9);
                    elementData.layers.Add(1);

                    for (int m = 1; m < 9; m++)
                    {
                        elementData.layers.Add(0);
                    }
                }

                if (Application.isPlaying && SystemInfo.supportsInstancing)
                {
                    if (elementData.instancedDataID == 0)
                    {
                        bool containsElement = false;

                        for (int e = 0; e < renderElements.Count; e++)
                        {
                            if (renderElements[e].elementDataID == elementData.elementDataID)
                            {
                                containsElement = true;
                                break;
                            }
                        }

                        if (!containsElement)
                        {
                            renderElements.Add(elementData);
                        }
                    }
                    else
                    {
                        bool containsElement = false;
                        int index = 0;

                        for (int e = 0; e < renderInstanced.Count; e++)
                        {
                            if (renderInstanced[e].renderers.Count > 1022)
                            {
                                continue;
                            }

                            if (renderInstanced[e].instancedDataID == elementData.instancedDataID)
                            {
                                containsElement = true;
                                index = e;
                                break;

                            }
                        }

                        if (!containsElement)
                        {
                            var elementInstanced = new TVEInstancedData();
                            elementInstanced.instancedDataID = elementData.instancedDataID;
                            elementInstanced.renderDataID = elementData.renderDataID;
                            elementInstanced.layers = elementData.layers;
                            elementInstanced.material = elementData.element.elementMaterial;
                            elementInstanced.mesh = elementData.element.elementMesh;
                            elementInstanced.elements.Add(elementData.element);
                            elementInstanced.renderers.Add(elementData.element.elementRenderer);

                            renderInstanced.Add(elementInstanced);
                        }
                        else
                        {
                            bool containsRenderer = false;

                            for (int r = 0; r < renderInstanced[index].renderers.Count; r++)
                            {
                                if (renderInstanced[index].renderers[r] == elementData.element.elementRenderer)
                                {
                                    containsRenderer = true;
                                    break;
                                }
                            }

                            if (!containsRenderer)
                            {
                                renderInstanced[index].elements.Add(elementData.element);
                                renderInstanced[index].renderers.Add(elementData.element.elementRenderer);
                            }
                        }
                    }
                }
                else
                {
                    bool containsElement = false;

                    for (int e = 0; e < renderElements.Count; e++)
                    {
                        if (renderElements[e].elementDataID == elementData.elementDataID)
                        {
                            containsElement = true;
                            break;
                        }
                    }

                    if (!containsElement)
                    {
                        renderElements.Add(elementData);
                    }
                }
            }
        }

        public static void RemoveElementDataFromVolume(TVEElementData elementData)
        {
            if (TVEManager.Instance == null)
            {
                return;
            }

            if (elementData == null)
            {
                return;
            }

            var renderElements = TVEManager.Instance.globalVolume.renderElements;

            if (renderElements != null)
            {
                for (int i = 0; i < renderElements.Count; i++)
                {
                    if (renderElements[i].elementDataID == elementData.elementDataID)
                    {
                        renderElements.RemoveAt(i);
                    }
                }
            }

            var renderInstanced = TVEManager.Instance.globalVolume.renderInstanced;

            if (renderInstanced != null)
            {
                for (int i = 0; i < renderInstanced.Count; i++)
                {
                    for (int j = 0; j < renderInstanced[i].renderers.Count; j++)
                    {
                        if (renderInstanced[i].renderers[j] == elementData.element.elementRenderer)
                        {
                            renderInstanced[i].elements.RemoveAt(j);
                            renderInstanced[i].renderers.RemoveAt(j);
                        }
                    }
                }
            }
        }

        public static void SetElementVisibility(TVEElementData elementData, ElementVisibility elementVisibility)
        {
            if (TVEManager.Instance == null)
            {
                return;
            }

            if (elementVisibility == ElementVisibility.UseGlobalVolumeSettings)
            {
                var visibility = TVEManager.Instance.globalVolume.elementsVisibility;

                if (visibility == TVEGlobalVolume.ElementsVisibility.AlwaysHidden)
                {
                    elementData.element.elementRenderer.enabled = false;
                }

                if (visibility == TVEGlobalVolume.ElementsVisibility.AlwaysVisible)
                {
                    elementData.element.elementRenderer.enabled = true;
                }

                if (visibility == TVEGlobalVolume.ElementsVisibility.HiddenAtRuntime)
                {
                    if (Application.isPlaying)
                    {
                        elementData.element.elementRenderer.enabled = false;
                    }
                    else
                    {
                        elementData.element.elementRenderer.enabled = true;
                    }
                }
            }
            else
            {
                if (elementVisibility == ElementVisibility.AlwaysHidden)
                {
                    elementData.element.elementRenderer.enabled = false;
                }

                if (elementVisibility == ElementVisibility.AlwaysVisible)
                {
                    elementData.element.elementRenderer.enabled = true;
                }

                if (elementVisibility == ElementVisibility.HiddenAtRuntime)
                {
                    if (Application.isPlaying)
                    {
                        elementData.element.elementRenderer.enabled = false;
                    }
                    else
                    {
                        elementData.element.elementRenderer.enabled = true;
                    }
                }
            }
        }

        public static bool IsValidElement(TVEElementData elementData)
        {
            var inVolume = false;

            var renderDataSet = TVEManager.Instance.globalVolume.renderDataSet;
            var elementBounds = elementData.element.elementRenderer.bounds;

            for (int i = 0; i < renderDataSet.Count; i++)
            {
                var renderData = renderDataSet[i];

                if (renderData == null)
                {
                    continue;
                }

                if (renderData.renderDataID == elementData.renderDataID)
                {
                    var volumeBounds = new Bounds(renderData.volumePosition, renderData.volumeScale);

                    if (volumeBounds.Intersects(elementBounds))
                    {
                        inVolume = true;
                    }
                }
            }

            return inVolume;
        }

        // Mesh Utils
        public static Mesh CreatePackedMesh(TVEMeshData meshData)
        {
            Mesh mesh = Object.Instantiate(meshData.mesh);

            var vertexCount = mesh.vertexCount;

            var bounds = mesh.bounds;
            var maxX = Mathf.Max(Mathf.Abs(bounds.min.x), Mathf.Abs(bounds.max.x));
            var maxZ = Mathf.Max(Mathf.Abs(bounds.min.z), Mathf.Abs(bounds.max.z));
            var maxR = Mathf.Max(maxX, maxZ) / 100f;
            var maxH = Mathf.Max(Mathf.Abs(bounds.min.y), Mathf.Abs(bounds.max.y)) / 100f;

            var dummyFloat = new List<float>(vertexCount);
            var dummyVector2 = new List<Vector2>(vertexCount);
            var dummyVector3 = new List<Vector3>(vertexCount);
            var dummyVector4 = new List<Vector4>(vertexCount);

            var colors = new List<Color>(vertexCount);
            var UV0 = new List<Vector4>(vertexCount);
            var UV2 = new List<Vector4>(vertexCount);
            var UV4 = new List<Vector4>(vertexCount);

            for (int i = 0; i < vertexCount; i++)
            {
                dummyFloat.Add(1);
                dummyVector2.Add(Vector2.zero);
                dummyVector3.Add(Vector3.zero);
                dummyVector4.Add(Vector4.zero);
            }

            mesh.GetColors(colors);
            mesh.GetUVs(0, UV0);
            mesh.GetUVs(1, UV2);
            mesh.GetUVs(3, UV4);

            if (UV2.Count == 0)
            {
                UV2 = dummyVector4;
            }

            if (UV4.Count == 0)
            {
                UV4 = dummyVector4;
            }

            if (meshData.variationMask == null)
            {
                meshData.variationMask = dummyFloat;
            }

            if (meshData.occlusionMask == null)
            {
                meshData.occlusionMask = dummyFloat;
            }

            if (meshData.detailMask == null)
            {
                meshData.detailMask = dummyFloat;
            }

            if (meshData.heightMask == null)
            {
                meshData.heightMask = dummyFloat;
            }

            if (meshData.motion2Mask == null)
            {
                meshData.motion2Mask = dummyFloat;
            }

            if (meshData.motion3Mask == null)
            {
                meshData.motion3Mask = dummyFloat;
            }

            if (meshData.detailCoord == null)
            {
                meshData.detailCoord = dummyVector2;
            }

            if (meshData.detailCoord == null)
            {
                meshData.pivotPositions = dummyVector3;
            }

            for (int i = 0; i < vertexCount; i++)
            {
                colors[i] = new Color(meshData.variationMask[i], meshData.occlusionMask[i], meshData.detailMask[i], meshData.heightMask[i]);
                UV0[i] = new Vector4(UV0[i].x, UV0[i].y, MathVector2ToFloat(meshData.motion2Mask[i], meshData.motion3Mask[i]), MathVector2ToFloat(maxH / 100f, maxR / 100f));
                UV2[i] = new Vector4(UV2[i].x, UV2[i].y, meshData.detailCoord[i].x, meshData.detailCoord[i].y);
                UV4[i] = new Vector4(meshData.pivotPositions[i].x, meshData.pivotPositions[i].z, meshData.pivotPositions[i].y, 0);
            }

            mesh.SetColors(colors);
            mesh.SetUVs(0, UV0);
            mesh.SetUVs(1, UV2);
            mesh.SetUVs(3, UV4);

            return mesh;
        }

        public static Mesh CombinePackedMeshes(List<GameObject> gameObjects, bool mergeSubMeshes)
        {
            var mesh = new Mesh();
            var combineInstances = new CombineInstance[gameObjects.Count];

            for (int i = 0; i < gameObjects.Count; i++)
            {
                var instanceMesh = Object.Instantiate(gameObjects[i].GetComponent<MeshFilter>().sharedMesh);
                var meshRenderer = gameObjects[i].GetComponent<MeshRenderer>();
                var transformMatrix = meshRenderer.transform.localToWorldMatrix;

                var vertexCount = instanceMesh.vertexCount;
                var UV4 = new List<Vector3>(vertexCount);
                var newUV4 = new List<Vector4>(vertexCount);

                instanceMesh.GetUVs(3, UV4);

                for (int v = 0; v < vertexCount; v++)
                {
                    var currentPivot = new Vector3(UV4[v].x, UV4[v].z, UV4[v].y);
                    var transformedPivot = gameObjects[i].transform.TransformPoint(currentPivot);
                    var swizzeledPivots = new Vector4(transformedPivot.x, transformedPivot.z, transformedPivot.y, 0);

                    newUV4.Add(swizzeledPivots);
                }

                instanceMesh.SetUVs(3, newUV4);

                combineInstances[i].mesh = instanceMesh;
                combineInstances[i].transform = transformMatrix;
                combineInstances[i].lightmapScaleOffset = meshRenderer.lightmapScaleOffset;
                combineInstances[i].realtimeLightmapScaleOffset = meshRenderer.realtimeLightmapScaleOffset;
            }

            mesh.CombineMeshes(combineInstances, mergeSubMeshes, true, true);

            return mesh;
        }

#if UNITY_EDITOR

        public static TVEMeshSettings MarkMeshReadable(Mesh mesh)
        {
            TVEMeshSettings meshSettings = new TVEMeshSettings();

            var meshPath = AssetDatabase.GetAssetPath(mesh);

            // Skip Speetree meshes
            if (!meshPath.EndsWith(".st"))
            {
                var modelImporter = AssetImporter.GetAtPath(meshPath) as ModelImporter;

                if (modelImporter != null)
                {
                    meshSettings.isReadable = modelImporter.isReadable;
                    meshSettings.keepQuads = modelImporter.keepQuads;

                    modelImporter.isReadable = true;
                    modelImporter.keepQuads = false;
                    modelImporter.SaveAndReimport();
                    AssetDatabase.Refresh();
                }
                else
                {
                    meshSettings.isReadable = true;
                    meshSettings.keepQuads = false;

                    string fileText = File.ReadAllText(meshPath);
                    fileText = fileText.Replace("m_IsReadable: 0", "m_IsReadable: 1");
                    File.WriteAllText(meshPath, fileText);
                    AssetDatabase.SaveAssets();
                    AssetDatabase.Refresh();
                }
            }

            return meshSettings;
        }

        public static void SetMeshReadable(Mesh mesh, TVEMeshSettings meshSettings)
        {
            var meshPath = AssetDatabase.GetAssetPath(mesh);

            // Skip Speetree meshes
            if (!meshPath.EndsWith(".st"))
            {
                var modelImporter = AssetImporter.GetAtPath(meshPath) as ModelImporter;

                if (modelImporter != null)
                {
                    modelImporter.isReadable = meshSettings.isReadable;
                    modelImporter.keepQuads = meshSettings.keepQuads;
                    modelImporter.SaveAndReimport();
                }
                else
                {
                    if (!meshSettings.isReadable)
                    {
                        string fileText = File.ReadAllText(meshPath);
                        fileText = fileText.Replace("m_IsReadable: 1", "m_IsReadable: 0");
                        File.WriteAllText(meshPath, fileText);
                        AssetDatabase.SaveAssets();
                        AssetDatabase.Refresh();
                    }
                }
            }
        }

        public static void CreateModifiableMeshes(Mesh mesh)
        {
            var meshPath = AssetDatabase.GetAssetPath(mesh);
            var meshSettings = MarkMeshReadable(mesh);

            var meshBase = Object.Instantiate(mesh);
            var meshMotion = Object.Instantiate(mesh);

            var vertexCount = mesh.vertexCount;

            var colors = new List<Color>(vertexCount);
            var UV0 = new List<Vector4>(vertexCount);
            var UV2 = new List<Vector4>(vertexCount);

            mesh.GetColors(colors);
            mesh.GetUVs(0, UV0);
            mesh.GetUVs(1, UV2);

            var dataUV3 = new List<Vector2>(vertexCount);
            var dataBase = new List<Color>(vertexCount);
            var dataMotion = new List<Color>(vertexCount);

            for (int i = 0; i < vertexCount; i++)
            {
                // Store Detail UVs
                dataUV3.Add(new Vector4(UV2[i].z, UV2[i].w, 0, 0));

                // Store Variation, Occlusion and Detail Mask
                dataBase.Add(new Color(colors[i].r, colors[i].g, colors[i].b, 0));

                // Store Height Mask, Branch Mask and Leaves Mask
                var motionMasks = MathFloatFromVector2(UV0[i].z);
                dataMotion.Add(new Color(colors[i].a, motionMasks.x, motionMasks.y, 0));
            }

            meshBase.SetUVs(2, dataUV3);
            meshBase.SetColors(dataBase);
            meshMotion.SetColors(dataMotion);

            SetMeshReadable(mesh, meshSettings);

            var basePath = meshPath.Replace("TVE Model", "Modifiable Base");
            var motionPath = meshPath.Replace("TVE Model", "Modifiable Motion");

            if (!File.Exists(basePath))
            {
                AssetDatabase.CreateAsset(meshBase, basePath);
            }
            else
            {
                var meshFile = AssetDatabase.LoadAssetAtPath<Mesh>(basePath);
                meshFile.Clear();
                EditorUtility.CopySerialized(meshBase, meshFile);
            }

            if (!File.Exists(motionPath))
            {
                AssetDatabase.CreateAsset(meshMotion, motionPath);
            }
            else
            {
                var meshFile = AssetDatabase.LoadAssetAtPath<Mesh>(motionPath);
                meshFile.Clear();
                EditorUtility.CopySerialized(meshMotion, meshFile);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        public static void CombineModifiableMeshes(Mesh mesh, Mesh meshBase, Mesh meshMotion)
        {
            MarkMeshReadable(meshBase);
            MarkMeshReadable(meshMotion);
            var meshSettings = MarkMeshReadable(mesh);

            var newMesh = Object.Instantiate(mesh);
            newMesh.name = mesh.name;

            var vertexCount = mesh.vertexCount;

            var newColors = new List<Color>(vertexCount);
            var newUV0 = new List<Vector4>(vertexCount);
            var newUV2 = new List<Vector4>(vertexCount);

            mesh.GetColors(newColors);
            mesh.GetUVs(0, newUV0);
            mesh.GetUVs(1, newUV2);

            var dataUV3 = new List<Vector2>(vertexCount);
            var dataBase = new List<Color>(vertexCount);
            var dataMotion = new List<Color>(vertexCount);

            meshBase.GetUVs(3, dataUV3);
            meshBase.GetColors(dataBase);
            meshMotion.GetColors(dataMotion);

            for (int i = 0; i < vertexCount; i++)
            {
                newColors[i] = new Color(dataBase[i].r, dataBase[i].g, dataBase[i].b, dataMotion[i].r);
                newUV0[i] = new Vector4(newUV0[i].x, newUV0[i].y, TVEUtils.MathVector2ToFloat(dataMotion[i].g, dataMotion[i].b), newUV0[i].w);
                newUV2[i] = new Vector4(newUV2[i].x, newUV2[i].y, dataUV3[i].x, dataUV3[i].y);
            }

            newMesh.SetColors(newColors);
            newMesh.SetUVs(0, newUV0);
            newMesh.SetUVs(1, newUV2);

            mesh.Clear();

            if (!meshSettings.isReadable)
            {
                newMesh.UploadMeshData(true);
            }

            EditorUtility.CopySerialized(newMesh, mesh);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }
#endif
        // Math Utils
        public static float MathRemap(float value, float low1, float high1, float low2, float high2)
        {
            return low2 + (value - low1) * (high2 - low2) / (high1 - low1);
        }

        public static float MathVector2ToFloat(float x, float y)
        {
            Vector2 output;

            output.x = Mathf.Floor(x * (2048 - 1));
            output.y = Mathf.Floor(y * (2048 - 1));

            return (output.x * 2048) + output.y;
        }

        public static Vector2 MathFloatFromVector2(float input)
        {
            Vector2 output;

            output.y = input % 2048f;
            output.x = Mathf.Floor(input / 2048f);

            return output / (2048f - 1);
        }

        // Misc
#if UNITY_EDITOR
        public static bool HasLabel(string path, string check)
        {
            bool valid = false;

            var asset = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(path);
            var labelsArr = AssetDatabase.GetLabels(asset);
            var labeldList = new List<string>();

            labeldList.AddRange(labelsArr);

            if (labeldList.Contains(check))
            {
                valid = true;
            }

            labeldList.Clear();

            return valid;
        }
#endif
    }
}
