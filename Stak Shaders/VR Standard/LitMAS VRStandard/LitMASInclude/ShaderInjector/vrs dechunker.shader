// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Copyright (c) Valve Corporation, All rights reserved. ======================================================================================================

// Reminder for evro: Search for EVRONOTE to find notes that arent original commetns

Shader "Valve/vr_standard"
{
	Properties
	{
		// COMPLETE: Properties
	}

	SubShader
	{
		Tags {"RenderPipeline" = "UniversalPipeline"  "RenderType" = "Opaque" "Queue" = "Geometry" }
		LOD 300

		//-------------------------------------------------------------------------------------------------------------------------------------------------------------
		// Base forward pass (directional light, emission, lightmaps, ...)
		//-------------------------------------------------------------------------------------------------------------------------------------------------------------
		Pass
		{
			Name "FORWARD"
			Tags { "LightMode" = "ForwardBase" "PassFlags" = "OnlyDirectional" } // NOTE: "OnlyDirectional" prevents Unity from baking dynamic lights into SH terms at runtime

			// COMPLETE: Pass Properties
			// Blend [_SrcBlend] [_DstBlend]
			// ZWrite [_ZWrite]
			// Cull [_Cull]
			// Offset [_OffsetFactor] , [_OffsetUnits]

			//AlphaToMask [_Test]


			HLSLPROGRAM
				#pragma target 5.0
			//	#pragma only_renderers d3d11
			//	#pragma exclude_renderers gles

				//-------------------------------------------------------------------------------------------------------------------------------------------------------------
			// COMPLETE: Shader Features


				#pragma multi_compile_instancing

				#pragma vertex MainVs
				#pragma fragment MainPs

				// COMPLETE: Dynamic combo skips (Static combo skips happen in ValveShaderGUI.cs in SetMaterialKeywords())
				// #if ( S_UNLIT )
				// 	#undef LIGHTMAP_OFF
				// 	#define LIGHTMAP_OFF 1
				// 	#undef LIGHTMAP_ON

				// 	#undef DIRLIGHTMAP_OFF
				// 	#define DIRLIGHTMAP_OFF 1
				// 	#undef DIRLIGHTMAP_COMBINED
				// 	#undef DIRLIGHTMAP_SEPARATE

				// 	#undef DYNAMICLIGHTMAP_OFF
				// 	#define DYNAMICLIGHTMAP_OFF 1
				// 	#undef DYNAMICLIGHTMAP_ON
				// #endif

				// Includes -------------------------------------------------------------------------------------------------------------------------------------------------
				
				// EVRONOTE: I put all the litmas includes here, hopefully this is enough
				
				//#include "UnityCG.cginc"
				#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
				#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
				#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
				#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
				#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Packing.hlsl"
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZLighting.hlsl"
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZBlueNoise.hlsl"

				#if !defined(SHADER_API_MOBILE)
					#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZLightingSSR.hlsl"
				#endif
				//#include "UnityLightingCommon.cginc"
				//include "UnityStandardUtils.cginc"
				#include "vr_StandardInput.hlsl"
				#include "vr_utils.hlsl"
				#include "vr_lighting.hlsl"
				#include "vr_matrix_palette_skinning.hlsl"
				#include "vr_fog.hlsl"

				#include "vr_zAO.hlsl"



				

				//COMPLETE - Non-Sampler Properties
				//COMPLETE: Sampler Variables (converted to LITMAS)


				// Structs --------------------------------------------------------------------------------------------------------------------------------------------------
				struct VertIn
				{
					UNITY_VERTEX_INPUT_INSTANCE_ID
					float4 vPositionOs : POSITION;
					float4 vertexColor : COLOR;
					float3 vNormalOs : NORMAL;
					float2 vTexCoord0 : TEXCOORD0;
					#if ( _DETAIL || S_OVERRIDE_LIGHTMAP || LIGHTMAP_ON )
						float2 vTexCoord1 : TEXCOORD1;
					#endif
					#if ( DYNAMICLIGHTMAP_ON || UNITY_PASS_META )
						float2 vTexCoord2 : TEXCOORD2;
					#endif

					#if ( _NORMALMAP || _PARALLAXMAP )
						float4 vTangentUOs_flTangentVSign : TANGENT;
					#endif

					#if ( MATRIX_PALETTE_SKINNING )
						float4 vBoneIndices : COLOR;
					#endif
				};

				struct VertOut
				{
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
					float4 vPositionPs : SV_POSITION;

					float4 vertexColor : COLOR;

					#if ( !S_UNLIT )
						float3 vPositionWs : TEXCOORD0;
						float3 vNormalWs : TEXCOORD1;
					
					#endif

					#if ( _DETAIL )
						float4 vTextureCoords : TEXCOORD2;
					#else
						float2 vTextureCoords : TEXCOORD2;
					#endif

					#if ( S_OVERRIDE_LIGHTMAP || LIGHTMAP_ON || DYNAMICLIGHTMAP_ON )
						#if ( DYNAMICLIGHTMAP_ON )
							centroid float4 vLightmapUV : TEXCOORD3;
						#else
							centroid float2 vLightmapUV : TEXCOORD3;
						#endif
					#endif

					#if ( _NORMALMAP || _PARALLAXMAP )
						float3 vTangentUWs : TEXCOORD4;
						float3 vTangentVWs : TEXCOORD5;
					#endif

					#if ( D_VALVE_FOG )
						float2 vFogCoords : TEXCOORD6;
					#endif

					half4 SHVertLights : TEXCOORD7;
				};

				

				float g_flValveGlobalVertexScale = 1.0; // Used to "hide" all valve materials for debugging

				// World-aligned texture
				float3 g_vWorldAlignedTextureSize = float3( 1.0, 1.0, 1.0 );
				float3 g_vWorldAlignedNormalTangentU = float3( -1.0, 0.0, 0.0 );
				float3 g_vWorldAlignedNormalTangentV = float3( 0.0, 0.0, 1.0 );
				float3 g_vWorldAlignedTexturePosition = float3( 0.0, 0.0, 0.0 );



				// MainVs ---------------------------------------------------------------------------------------------------------------------------------------------------
				VertOut MainVs( VertIn i )
				{
					VertOut o = ( VertOut )0;

					//Instancing
					UNITY_INITIALIZE_OUTPUT(VertOut, o);
					UNITY_SETUP_INSTANCE_ID(i);
					UNITY_TRANSFER_INSTANCE_ID(i,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


					#if ( MATRIX_PALETTE_SKINNING )
					{
						#if ( _NORMALMAP || _PARALLAXMAP )
						{
							MatrixPaletteSkinning( i.vPositionOs.xyzw, i.vNormalOs.xyz, i.vTangentUOs_flTangentVSign.xyz, i.vBoneIndices.xyzw );
						}
						#else
						{
							MatrixPaletteSkinning( i.vPositionOs.xyzw, i.vNormalOs.xyz, i.vBoneIndices.xyzw );
						}
						#endif
					}
					#endif 

					// Position
					i.vPositionOs.xyzw *= g_flValveGlobalVertexScale; // Used to "hide" all valve materials for debugging
					float3 vPositionWs = mul( unity_ObjectToWorld, i.vPositionOs.xyzw ).xyz;
					#if ( !S_UNLIT )
					{
						o.vPositionWs.xyz = vPositionWs.xyz;
					}
					#endif
					o.vPositionPs.xyzw = UnityObjectToClipPos( i.vPositionOs.xyzw );

					//Vertex Color
					o.vertexColor = i.vertexColor;


					// Normal
					float3 vNormalWs = UnityObjectToWorldNormal( i.vNormalOs.xyz );
					#if ( !S_UNLIT )
					{
						o.vNormalWs.xyz = vNormalWs.xyz;
					}
					#endif

					#if ( _NORMALMAP || _PARALLAXMAP )
					{
						// TangentU and TangentV
						float3 vTangentUWs = UnityObjectToWorldDir( i.vTangentUOs_flTangentVSign.xyz ); // Transform tangentU into world space
						//vTangentUWs.xyz = normalize( vTangentUWs.xyz - ( vNormalWs.xyz * dot( vTangentUWs.xyz, vNormalWs.xyz ) ) ); // Force tangentU perpendicular to normal and normalize

						o.vTangentUWs.xyz = vTangentUWs.xyz;
						o.vTangentVWs.xyz = cross( vNormalWs.xyz, vTangentUWs.xyz ) * i.vTangentUOs_flTangentVSign.w;

						


					}
					#endif

					#if ( S_WORLD_ALIGNED_TEXTURE )
					{
						float3 vTexturePositionScaledWs = ( vPositionWs.xyz - g_vWorldAlignedTexturePosition.xyz ) / g_vWorldAlignedTextureSize.xyz;
						o.vTextureCoords.x = dot( vTexturePositionScaledWs.xyz, g_vWorldAlignedNormalTangentU.xyz );
						o.vTextureCoords.y = dot( vTexturePositionScaledWs.xyz, g_vWorldAlignedNormalTangentV.xyz );
						#if ( _DETAIL )
						{
							o.vTextureCoords.zw = TRANSFORM_TEX( o.vTextureCoords.xy, _DetailAlbedoMap );
						}
						#endif
					}
					#else
					{
						// Texture coords (Copied from Unity's TexCoords() helper function)
						o.vTextureCoords.xy = TRANSFORM_TEX( i.vTexCoord0, _MainTex );
						#if ( _DETAIL )
						{
							o.vTextureCoords.zw = TRANSFORM_TEX( ( ( _UVSec == 0 ) ? i.vTexCoord0 : i.vTexCoord1 ), _DetailAlbedoMap );
							//float2 detailscale = _DetailAlbedoMap_ST.xy;
						}
						#endif
					}
					#endif

					// Indirect lighting uv's or light probe
					#if ( S_OVERRIDE_LIGHTMAP )
					{
						o.vLightmapUV.xy = i.vTexCoord1.xy;
					}
					#elif ( LIGHTMAP_ON )
					{
						// Static lightmaps
						o.vLightmapUV.xy = i.vTexCoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					}
					#endif

					#if ( DYNAMICLIGHTMAP_ON )
					{
						o.vLightmapUV.zw = i.vTexCoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					}
					#endif

					#if ( D_VALVE_FOG )
					{
						o.vFogCoords.xy = CalculateFogCoords( vPositionWs.xyz );
					}
					#endif

					o.SHVertLights = 0;
					// Calculate vertex lights and L2 probe lighting on quest 
					o.SHVertLights.xyz = VertexLighting(o.wPos, o.normXYZ_tanX.xyz);
    				#if !defined(LIGHTMAP_ON) && !defined(DYNAMICLIGHTMAP_ON) && defined(SHADER_API_MOBILE)
    					o.SHVertLights.xyz += SampleSHVertex(o.normXYZ_tanX.xyz);
    				#endif

					return o;
				}

				// MainPs ---------------------------------------------------------------------------------------------------------------------------------------------------
				//#define g_vColorTint _Color
				#define g_tColor _MainTex
				#define g_tNormalMap _BumpMap
				#define g_flBumpScale _BumpScale
				#define g_vReflectance _SpecColor
				#define g_tReflectanceGloss _SpecGlossMap
				#define g_flGlossScale _Glossiness
				#define g_tDetailAlbedo _DetailAlbedoMap
				#define g_tDetailNormal _DetailNormalMap
				#define g_flDetailNormalScale _DetailNormalMapScale
				#define g_tFluorescenceMap _FluorescenceMap
				#define g_vColorFluorescence _FluorescenceColor
				#define g_vAbsorbance _Absorbance
				#define g_vColorShift1 _ColorShift1
				#define g_vColorShift2 _ColorShift2
				#define g_vColorShift3 _ColorShift3
				#define g_fEmissionFalloff _EmissionFalloff
				#define g_tParallax _ParallaxMap
				#define g_fParallaxScale _Parallax
				#define g_fSpecMod _SpecMod

				float g_flReflectanceScale = 1.0;
				float g_flReflectanceBias = 0.0;

				float _OcclusionStrengthDirectDiffuse = 1.0;
				float _OcclusionStrengthDirectSpecular = 1.0;
				float _OcclusionStrengthIndirectDiffuse = 1.0;
				float _OcclusionStrengthIndirectSpecular = 1.0;

				
				float _AnisotropicRotation;
				float _AnisotropicRatio;

				float _FogMultiplier = 1.0;

				float4 MainPs( VertOut i
					#if ( S_RENDER_BACKFACES )
						, bool bIsFrontFace : SV_IsFrontFace
					#endif
					) : SV_Target0
				{
					float4 outputColor = float4 (1, 1, 1, 1);

					UNITY_SETUP_INSTANCE_ID(i);

					//-----------------------------------------------------------//
					// Negate the world normal if we are rendering the back face //
					//-----------------------------------------------------------//
					#if ( S_RENDER_BACKFACES && !S_UNLIT )
					{
						i.vNormalWs.xyz *= ( bIsFrontFace ? 1.0 : -1.0 );
					}
					#endif

					//---------------//
					// Tangent Space //
					//---------------//
					
					//COMPLETE: Tangent Space


					//----------------//
					// Texture Packing//
					//----------------//					

					//COMPLETE: Texture Packing
					
					//-----------------------//
					//		Parallaxing		//
					//---------------------//

					//COMPLETE: Parallaxing
					
					//--------//
					// Normal //
					//--------//
					
				
					//COMPLETE: Normal Map w detail


					//--------//
					// Albedo //
					//--------//

					//COMPLETE: Albedo and Detail
					
					//--------------//
					// Fluorescence //
					//--------------//
					#if ( _FLUORESCENCEMAP)
					//float3 vFluorescence = max(tex2D( g_tFluorescenceMap, i.vTextureCoords.xy ).rgb, g_vColorFluorescence.rgb);
					float3 vFluorescence = tex2D( g_tFluorescenceMap, zTextureCoords.xy ).rgb * g_vColorFluorescence.rgb;

					#endif




					#if ( !S_UNLIT || _ALPHAPREMULTIPLY_ON  )
					 Dotfresnel = saturate(dot( vNormalWs.xyz , CalculatePositionToCameraDirWs( i.vPositionWs.xyz ) ));	
					#endif
									
					//--------------//
					// Translucency //
					//--------------//
					//#if ( _ALPHATEST_ON )
					//{
					//	//clip( vAlbedoTexel.a - _Cutoff );
					//	outputColor.a = vAlbedoTexel.a;
					//	//outputColor.a = (outputColor.a - _Cutoff) / max(fwidth(outputColor.a), 0.0001) + 0.5;
					//}
					//#endif

					#if ( _ALPHAPREMULTIPLY_ON )
					{
						vAlbedo.rgb *= vAlbedoTexel.a;
					}
					#endif

					#if ( _ALPHABLEND_ON || _ALPHAPREMULTIPLY_ON || _ALPHATEST_ON)
					{
						
						#if ( !S_UNLIT && !_ALPHATEST_ON)
						
						float normalBlend = 1 - saturate( Dotfresnel );
						outputColor.a = saturate(vAlbedoTexel.a + lerp(0 , 1 * _Cutoff , normalBlend ));

						#else
						outputColor.a = vAlbedoTexel.a;
						#endif

						#if ( _VERTEXTINT )
						outputColor.a *= i.vertexColor.w;
						#endif

						#if ( _ALPHATEST_ON )

						//Magic AlphaToCoverage sharpening. Thanks Ben Golus! https://medium.com/@bgolus/anti-aliased-alpha-test-the-esoteric-alpha-to-coverage-8b177335ae4f
						outputColor.a = (outputColor.a - _Cutoff) / max(fwidth(outputColor.a), 0.0001) + 0.5;
						#endif

					}
					#else
					{
						outputColor.a = 1.0;
					}
					#endif

					#if S_EMISSIVE_MULTI
					float3 AlbedoPreMetal = vAlbedo.rgb;
					#endif

					//-----------//
					// Roughness //
					//-----------//
					float3 vRoughness = float3( 0.6, 0.0, 0.0 );// vNormalTexel.rb;
					//#if ( S_HIGH_QUALITY_GLOSS )
					//{
					//	float4 vGlossTexel = Tex2D( g_tGloss, i.vTextureCoords.xy );
					//	vRoughness.xy += vGlossTexel.ag;
					//}
					//#endif

					// Reflectance and gloss
					float3 vReflectance = float3( 0.0, 0.0, 0.0 );
					float3 flGloss = float3(0.0, 0.0, 0.0);
					#if ( S_SPECULAR_METALLIC )
					{
						float2 vMetallicGloss;// = MetallicGloss( i.vTextureCoords.xy );
						#ifdef _METALLICGLOSSMAP
							#if ( S_PACKING_MAES ||  S_PACKING_RMA || S_PACKING_MAS )
							vMetallicGloss.xy = unPackedTexture.rb;
							#else
							vMetallicGloss.xy = tex2D(_MetallicGlossMap, zTextureCoords.xy).ra;
							#endif

						#else
							vMetallicGloss.xy = half2(_Metallic, _Glossiness);
						#endif

						float flOneMinusReflectivity;
						float3 vSpecColor;
						float3 diffColor = DiffuseAndSpecularFromMetallic( vAlbedo.rgb, vMetallicGloss.x, /*out*/ vSpecColor, /*out*/ flOneMinusReflectivity);
						vAlbedo.rgb = diffColor.rgb;

						vReflectance.rgb = vSpecColor.rgb;
						flGloss.x = vMetallicGloss.y;
					}
					#elif ( S_SPECULAR_BLINNPHONG )
					{
						float4 vReflectanceGloss; // = SpecularGloss( i.vTextureCoords.xy );
						#ifdef _SPECGLOSSMAP
							vReflectanceGloss.rgba = tex2D(_SpecGlossMap, zTextureCoords.xy);
						#else
							vReflectanceGloss.rgba = float4(_SpecColor.rgb, _Glossiness);
						#endif

						vReflectanceGloss.rgb = ( vReflectanceGloss.rgb * g_flReflectanceScale.xxx ) + g_flReflectanceBias.xxx;
						vReflectance.rgb = vReflectanceGloss.rgb;
						flGloss.x = vReflectanceGloss.a;
					}

					#elif ( S_ANISOTROPIC_GLOSS  )
					{
						//x = Metallic, y = Gloss, z = Rotation, w = Ratio
						float4 vMetallicGloss;// = MetallicGloss( i.vTextureCoords.xy );
						#ifdef _METALLICGLOSSMAP
							vMetallicGloss.xyzw = tex2D(_MetallicGlossMap, zTextureCoords.xy ).ragb;	
							vMetallicGloss.z = frac(vMetallicGloss.z + _AnisotropicRotation);
							//+ ScreenSpaceDither( zTextureCoords.xy * 256 ).xy * 0.2 

						#else
							vMetallicGloss.xyzw = half4(_Metallic, _Glossiness, _AnisotropicRotation, _AnisotropicRatio);
						#endif

						float flOneMinusReflectivity;
						float3 vSpecColor;
						float3 diffColor = DiffuseAndSpecularFromMetallic( vAlbedo.rgb, vMetallicGloss.x, /*out*/ vSpecColor, /*out*/ flOneMinusReflectivity);
						vAlbedo.rgb = diffColor.rgb;

						vReflectance.rgb = vSpecColor.rgb;
						flGloss.xyz = vMetallicGloss.yzw;
					}

					#elif ( S_RETROREFLECTIVE )
					{
						float normalBlend = saturate( Dotfresnel );
						normalBlend = pow (normalBlend , 0.25);

						float2 vMetallicGloss;// = MetallicGloss( i.vTextureCoords.xy );
						#ifdef _METALLICGLOSSMAP
							vMetallicGloss.xy = tex2D(_MetallicGlossMap, zTextureCoords.xy).ra;
						#else
							vMetallicGloss.xy = half2(_Metallic, _Glossiness);
						#endif

						float flOneMinusReflectivity;
						float3 vSpecColor;
						float3 diffColor = DiffuseAndSpecularFromMetallic( vAlbedo.rgb, vMetallicGloss.x, /*out*/ vSpecColor, /*out*/ flOneMinusReflectivity);
						vAlbedo.rgb = diffColor.rgb;

						vReflectance.rgb = vSpecColor.rgb;
						flGloss.x = vMetallicGloss.y ;//* normalBlend;
					
					}

					
					#endif
 
					vRoughness.xyz = float3( ( 1.0 - saturate(flGloss.x * g_fSpecMod) ), flGloss.y, flGloss.z );

					#if ( !S_SPECULAR_NONE )
					{
						vRoughness.x = AdjustRoughnessByGeometricNormal( vRoughness.x, vGeometricNormalWs.xyz );
					}
					#endif

					// EVRONOTE: Yeahhhhh lighting will be tricky, its controlled entirely by Valve Camera i think.
					//----------//
					// Lighting //
					//----------//

					// EVRONOTE: wagghhhhh i dont understand surface data i wanna kms w this lighting stuff
					// Could maybe just inject SLZ lighting into the vr_lighting.cginc/hlsl
					
					#if defined(LIGHTMAP_ON)
						SLZFragData fragData = SLZGetFragData(i.vPositionPs, i.vPositionWs, vNormalWs, i.vLightmapUV.xy, i.vLightmapUV.zw, i.SHVertLights.xyz);
					#else
						SLZFragData fragData = SLZGetFragData(i.vPositionPs, i.vPositionWs, vNormalWs, float2(0, 0), float2(0, 0), i.SHVertLights.xyz);
					#endif
					
//					LightingTerms_t lightingTerms;
//					// EVRONOTE: Unneeded?
//					//lightingTerms.vDiffuse.rgba = float4( 1.0, 1.0, 1.0 , 1.0);
//					//lightingTerms.vSpecular.rgb = float3( 0.0, 0.0, 0.0 );
//					//lightingTerms.vIndirectDiffuse.rgb = float3( 0.0, 0.0, 0.0 );
//					//lightingTerms.vIndirectSpecular.rgb = float3( 0.0, 0.0, 0.0 );
//					//lightingTerms.vTransmissiveSunlight.rgb = float3( 0.0, 0.0, 0.0 );
//
//					//float flFresnelExponent = 5.0;
//					float flMetalness = 0.0f;
//
//					// EVRONOTE: Originally "( !S_UNLIT )" but can be switched to false for testing as unlit until i can get lighting working
					#if ( !S_UNLIT )
					{
						float4 vLightmapUV = float4( 0.0, 0.0, 0.0, 0.0 );
						#if ( S_OVERRIDE_LIGHTMAP || LIGHTMAP_ON || DYNAMICLIGHTMAP_ON )
						{
							vLightmapUV.xy = i.vLightmapUV.xy;
							#if ( DYNAMICLIGHTMAP_ON )
							{
								vLightmapUV.zw = i.vLightmapUV.zw;
							}
							#endif
						}
						#endif

						// Compute lighting
//						lightingTerms = ComputeLighting( i.vPositionWs.xyz, vNormalWs.xyz, vTangentUWs.xyz, vTangentVWs.xyz, vRoughness.xyz, vReflectance.rgb, g_flFresnelExponent, vLightmapUV.xyzw, Dotfresnel );

						#if ( S_OCCLUSION || _NORMALMAP )
						{

							#if ( !S_OCCLUSION)
							float flOcclusion = 1;
							#else

								#if (S_PACKING_MAES || S_PACKING_RMA || S_PACKING_MAS )
								float flOcclusion = unPackedTexture.g;
								#else
								float flOcclusion = tex2D( _OcclusionMap, zTextureCoords.xy ).g;
								#endif


							#endif

							#if ( _NORMALMAP )	
							float2 normalABS =  abs(vNormalTs.xy * vNormalTs.xy) ;
							flOcclusion *= LerpOneTo(   (1 - (normalABS.x + normalABS.y) ) * (vNormalTs.z ), _NormalToOcclusion);						 
							#endif

//							lightingTerms.vDiffuse.rgba *= LerpOneTo( flOcclusion, _OcclusionStrength * _OcclusionStrengthDirectDiffuse );
//							lightingTerms.vSpecular.rgb *= LerpOneTo( flOcclusion, _OcclusionStrength * _OcclusionStrengthDirectSpecular );
//							lightingTerms.vIndirectDiffuse.rgb *= LerpOneTo( flOcclusion, _OcclusionStrength * _OcclusionStrengthIndirectDiffuse );
//							lightingTerms.vIndirectSpecular.rgb *= LerpOneTo( flOcclusion, _OcclusionStrength * _OcclusionStrengthIndirectSpecular );
						}
						#endif
					}
					#endif
					SLZSurfData surfData = SLZGetSurfDataMetallicGloss(vAlbedo.rgb, saturate(vMetallicGloss.x), saturate(vMetallicGloss.y), flOcclusion, vEmission.rgb, vAlbedo.a);
					

					// EVRONOTE Brdf might be difficult to implement entirely but I should be able to use the code from amplify
					// EVROTODO Implement BRDF Map
//					////BRDF remapping
//					//#if ( _BRDFMAP )
//					//{
//					//float3 brdfmap = tex2D( g_tBRDFMap, i.vTextureCoords.xy ).rgb;
//				//	outputColor.rgb = BRDFRemapping( lightingTerms.vDiffuse.rgb + lightingTerms.vIndirectDiffuse.rgb , g_tBRDFMap) * vAlbedo.rgb;
//					//outputColor.rgb = ( lightingTerms.vDiffuse.rgb + lightingTerms.vIndirectDiffuse.rgb );
//
//					//}
//				//	#else
//					//{
//					// Diffuse
//					outputColor.rgb = ClampToPositive( ( lightingTerms.vDiffuse.rgb + lightingTerms.vIndirectDiffuse.rgb ) * vAlbedo.rgb);
//				//	}
//				//	#endif
//
//
					//Color Shifting
					#if ( _COLORSHIFT )
					{
						float3 ColorMaskTex = 1 - tex2D(_ColorMask, zTextureCoords.xy ).rgb ;
						float3 ColorShifter = max(g_vColorShift1.rgb, ColorMaskTex.rrr) * max(g_vColorShift2.rgb, ColorMaskTex.ggg) * max(g_vColorShift3.rgb, ColorMaskTex.bbb);
						outputColor.rgb *= ColorShifter;
					}
					#endif
//
					//EVRONOTE Yeah i genuinely dont know how to do fluorescense now. Might try and see what default LitPBR URP does though
//					// Fluorescence
//					#if ( _FLUORESCENCEMAP )			
//
//					// float3 LitFluorescence =  float3(
//					// 					/*RED*/		max(max(lightingTerms.vDiffuse.r + lightingTerms.vIndirectDiffuse.r , max( lightingTerms.vDiffuse.g + lightingTerms.vIndirectDiffuse.g, lightingTerms.vDiffuse.b + lightingTerms.vIndirectDiffuse.b)), lightingTerms.vDiffuse.a),
//					// 					/*GREEN*/	max((max(lightingTerms.vDiffuse.g + lightingTerms.vIndirectDiffuse.g, lightingTerms.vDiffuse.b + lightingTerms.vIndirectDiffuse.b)) , lightingTerms.vDiffuse.a),
//					// 					/*BLUE*/	max(lightingTerms.vDiffuse.b + lightingTerms.vIndirectDiffuse.b , lightingTerms.vDiffuse.a)
//					// 								) 
//					// 								* vFluorescence.rgb ;
//					// outputColor.rgb = max(outputColor.rgb, LitFluorescence.rgb);
//
//					float4 FluorescenceAbsorb = (lightingTerms.vDiffuse + float4( lightingTerms.vIndirectDiffuse.rgb , 0.0 ) ) * g_vAbsorbance;					
//
//					float Absorbed_B = FluorescenceAbsorb.b + FluorescenceAbsorb.a;
//					float Absorbed_G = Absorbed_B + FluorescenceAbsorb.g;
//					float Absorbed_R = Absorbed_G + FluorescenceAbsorb.r;
//
//					float3 LitFluorescence =  float3(Absorbed_R, Absorbed_G, Absorbed_B) * vFluorescence.rgb ;
//					outputColor.rgb = max(outputColor.rgb, LitFluorescence.rgb);					
//
//					#endif
//					//)
//

					//COMPLETE: Emission Map
					

//					// Specular
//					#if ( !S_SPECULAR_NONE )
//					{
//						outputColor.rgb += lightingTerms.vSpecular.rgb;
//					}
//					#endif
//					outputColor.rgb += lightingTerms.vIndirectSpecular.rgb; // Indirect specular applies its own fresnel in the forward lighting header file
//					// Emission - Unity just adds the emissive term at the end instead of adding it to the diffuse lighting term. Artists may want both options.

					
					
					
					//COMPLETE: Emission Falloff	


					//Shape Occlusion

					// EVRONOTE: Shape Occlusion is put in by using specific gameobjects with spheres.
					// Should be able to put the spheres using ultevents
					// On second thought, i actually dont know... setting matrices with ultevents might not be possible
					// At the worst it can just be a vestigial codepiece if i ever decide to use a codemod

					#if (Z_SHAPEAO && !S_UNLIT )
					{
						float vAO = CalculateShapeAO( i.vPositionWs.xyz, vNormalWs.xyz);
					
						outputColor.rgb *= vAO;
					}
					#endif

					#endif

					// EVRONOTE: this might be my favorite bit in the whole shader, mult by albedo my beloved
					// COMPLETE: Emissive Multi
					#if (S_EMISSIVE_MULTI)
					outputColor.rgb += vEmission.rgb * AlbedoPreMetal.rgb;	
					#else
					outputColor.rgb += vEmission.rgb;
					#endif

					//COMPLETE: Vertex Tint

					
					
					// Fog
					// EVRONOTE: Replacing with SLZ fog, but I may try and see if i can get Valve fog working in the future
//					#if ( D_VALVE_FOG )
//					{				
//						
//						#if (_ALPHAPREMULTIPLY_ON || _ALPHAMULTIPLY_ON || _ALPHAMOD2X_ON)
//						outputColor.rgba = ApplyFog( outputColor.rgba, i.vFogCoords.xy, _FogMultiplier, _ColorMultiplier );
//						#else
//						outputColor.rgb = ApplyFog( outputColor.rgb, i.vFogCoords.xy, _FogMultiplier );
//						#endif
//					}
//					#endif

					#if !defined(_SSR_ENABLED)
						color = MixFogSurf(color, -fragData.viewDir, i.uv0XY_bitZ_fog.w, _Surface);
		
						color = VolumetricsSurf(color, fragData.position, _Surface);
					#endif


					// Dither to fix banding artifacts
					outputColor.rgba += ScreenSpaceDither( i.vPositionPs.xy );

					return outputColor;
				}
			ENDHLSL
		}

		//-------------------------------------------------------------------------------------------------------------------------------------------------------------
		// Shadow rendering pass
		//-------------------------------------------------------------------------------------------------------------------------------------------------------------
		//Pass
		//{
		//	Name "ShadowCaster"
		//	Tags { "LightMode" = "ShadowCaster" }
		//	
		//	ZWrite On ZTest LEqual
		//
		//	HLSLPROGRAM
		//		#pragma target 5.0
		//		// TEMPORARY: GLES2.0 temporarily disabled to prevent errors spam on devices without textureCubeLodEXT
		//		#pragma exclude_renderers gles
		//		
		//		// -------------------------------------
		//		#pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
		//		#pragma multi_compile_shadowcaster
		//
		//		#pragma vertex vertShadowCaster
		//		#pragma fragment fragShadowCaster
		//
		//		#include "UnityStandardShadow.cginc"
		//	ENDHLSL
		//}

		//-------------------------------------------------------------------------------------------------------------------------------------------------------------
		// Extracts information for lightmapping, GI (emission, albedo, ...)
		// This pass it not used during regular rendering.
		//-------------------------------------------------------------------------------------------------------------------------------------------------------------
		Pass
		{
			Name "META" 
			Tags { "LightMode"="Meta" }
		
			Cull Off
			HLSLPROGRAM
				#pragma only_renderers d3d11

				#pragma vertex vert_meta
				#pragma fragment frag_meta
		
				#pragma shader_feature _EMISSION
				#pragma shader_feature _METALLICGLOSSMAP
				#pragma shader_feature ___ _DETAIL_MULX2
		
				#include "UnityStandardMeta.cginc"
			ENDHLSL
		}
	}

	CustomEditor "ValveShaderGUI"
}
