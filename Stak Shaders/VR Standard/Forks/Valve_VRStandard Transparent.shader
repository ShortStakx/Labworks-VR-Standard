// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
// Force reimport: 2
Shader "Valve/VRStandard Transparent V3"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[ASEBegin]_Cutoff("Alpha Clipping", Range( 0 , 1)) = 0.5
		_MainTex("Main Tex", 2D) = "white" {}
		_Color("Main Color", Color) = (1,1,1,0)
		[NoScaleOffset]_BumpMap("Normal Map", 2D) = "bump" {}
		_BumpScale("Normal Scale", Range( 0 , 1)) = 1
		_NormalToOcclusion("Normal To Occlusion", Range( 0 , 1)) = 0
		[KeywordEnum(MAS,MetallicSmoothness,RMA,MASK)] _MetallicType("Metallic Type", Float) = 0
		[NoScaleOffset]_MetallicGlossMap("Metallic Map", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 1
		_Glossiness("Smoothnes", Range( 0 , 1.5)) = 1
		_Specmod("Smoothness Scale", Range( 0 , 2)) = 1
		[Header(Parallax)][NoScaleOffset]_ParallaxMap("Height Map", 2D) = "white" {}
		_Parallax("Height Scale", Float) = 0
		[Header(Emission)][NoScaleOffset]_EmissionMap("Emission Map", 2D) = "white" {}
		_EmissionFalloff("Emission Falloff", Float) = 0
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_BakedMutiplier("Emission Baked Multiplier", Float) = 0
		[Toggle(_EMITALBEDO_ON)] _EmitAlbedo("Emit Albedo", Float) = 0
		[Header(Occlusion)][NoScaleOffset]_OcclusionMap("Occlusion Map", 2D) = "white" {}
		[Toggle(_USEOCCLUSION_ON)] _UseOcclusion("Use Occlusion", Float) = 0
		[Toggle(_HMMMDETAIL_ON)] _hmmmdetail("hmmm detail?", Float) = 1
		[Header(Detail)][NoScaleOffset]_DetailMask("Detail Mask", 2D) = "white" {}
		_DetailAlbedoMap("Detail Albedo X2", 2D) = "white" {}
		[NoScaleOffset]_DetailNormalMap("Detail Normal", 2D) = "bump" {}
		_DetailNormalMapScale("Detail Normal Scale", Float) = 1
		_OcclusionStrength("_OcclusionStrength", Range( 0 , 1)) = 1
		[Space(20)][Header(BRDF Lut)][Space(10)][Toggle(_BRDFMAP)] BRDFMAP("Enable BRDF map", Float) = 0
		[NoScaleOffset][SingleLineTexture]g_tBRDFMap("BRDF map", 2D) = "white" {}
		[Header(Color Mask)][NoScaleOffset]_ColorMask("Color Tint", 2D) = "white" {}
		_ColorShift1("_ColorShift1", Color) = (1,1,1,1)
		_ColorShift2("_ColorShift2", Color) = (1,1,1,1)
		_ColorShift3("_ColorShift3", Color) = (1,1,1,1)
		[Toggle(_VERTEXTINT_ON)] _VertexTint("Vertex Tint", Float) = 0
		[Toggle(VERTEXILLUMINATION_ON)] VertexIllumination("VertexIllumination", Float) = 0
		[Toggle(_VERTEXOCCLUSION_ON)] _VertexOcclusion("Vertex Occlusion", Float) = 0
		[ASEEnd][Toggle(_COLORSHIFT)] _UseColorMask("Use ColorMask", Float) = 0
		[HideInInspector]_Cull("cull", Float) = 0

		[Space(30)][Header(Screen Space Reflections)][Space(10)][Toggle(_NO_SSR)] _SSROff("Disable SSR", Float) = 0
		[Header(This should be 0 for skinned meshes)]
		_SSRTemporalMul("Temporal Accumulation Factor", Range(0, 2)) = 1.0
		//[Toggle(_SM6_QUAD)] _SM6_Quad("Quad-avg SSR", Float) = 0


	}
	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent" }
		
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off
		Cull [_Cull]
		ZTest LEqual
		Offset 1 , 1
		ColorMask RGBA
		//LOD 100
		

		
		Pass
		{

			

			Name "Forward"
			Tags { "Lightmode"="UniversalForward" }
			
			HLSLPROGRAM
			#define _ISTRANSPARENT
			#define _SurfaceFade
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _ALPHATEST_ON 1
			#define ASE_SRP_VERSION 999999
			#ifdef UNITY_COLORSPACE_GAMMA//ASE Color Space Def
			#define unity_ColorSpaceDouble half4(2.0, 2.0, 2.0, 2.0)//ASE Color Space Def
			#else // Linear values//ASE Color Space Def
			#define unity_ColorSpaceDouble half4(4.59479380, 4.59479380, 4.59479380, 2.0)//ASE Color Space Def
			#endif//ASE Color Space Def

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0

			
			#define LITMAS_FEATURE_TS_NORMALS
			
			#define LITMAS_FEATURE_SSR
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			#if defined(SHADER_API_DESKTOP)
			
			
			
			
			#endif

			//StandardForward------------------------------------------------------------------------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//
			//
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
					
					
			#define SHADERPASS SHADERPASS_FORWARD
			#define _NORMAL_DROPOFF_TS 1
			#define _EMISSION
			#define _NORMALMAP 1
					
			#if defined(SHADER_API_MOBILE)
			#if defined(MOBILE_LIGHTS_VERTEX)
				#define _ADDITIONAL_LIGHTS_VERTEX
			#endif
					
			#if defined(MOBILE_RECEIVE_SHADOWS)
				#undef _RECEIVE_SHADOWS_OFF
				#define _MAIN_LIGHT_SHADOWS
				#define _ADDITIONAL_LIGHT_SHADOWS
				#pragma multi_compile_fragment  _  _MAIN_LIGHT_SHADOWS_CASCADE
				#pragma multi_compile_fragment _ _ADDITIONAL_LIGHTS
				#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
				#define _SHADOWS_SOFT 1
			#else
				#define _RECEIVE_SHADOWS_OFF 1
			#endif
					
			#if defined(MOBILE_SSAO)
				#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#endif
					
			#if defined(MOBILE_REFLECTION_PROBE_BLENDING)
				#define _REFLECTION_PROBE_BLENDING
			#endif
					
			#if defined(MOBILE_REFLECTION_PROBE_BOX_PROJECTION)
				#define _REFLECTION_PROBE_BOX_PROJECTION 
			#endif
						
			#else
					
			//#define DYNAMIC_SCREEN_SPACE_OCCLUSION
			#if defined(PC_SSAO)
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#endif
					
			//#define DYNAMIC_ADDITIONAL_LIGHTS
			#if defined(PC_RECEIVE_SHADOWS)
				#undef _RECEIVE_SHADOWS_OFF
				#pragma multi_compile_fragment  _  _MAIN_LIGHT_SHADOWS_CASCADE
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHTS
					
					
			//#define DYNAMIC_ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
					
				#define _SHADOWS_SOFT 1
			#else
				#define _RECEIVE_SHADOWS_OFF 1
			#endif
					
			#if defined(PC_REFLECTION_PROBE_BLENDING)
				#define _REFLECTION_PROBE_BLENDING
			#endif
				//#pragma shader_feature_fragment _REFLECTION_PROBE_BOX_PROJECTION
				// We don't need a keyword for this! the w component of the probe position already branches box vs non-box, & so little cost on pc it doesn't matter
			#if defined(PC_REFLECTION_PROBE_BOX_PROJECTION)
				#define _REFLECTION_PROBE_BOX_PROJECTION 
			#endif
					
			// Begin Injection STANDALONE_DEFINES from Injection_SSR.hlsl ----------------------------------------------------------
			#pragma multi_compile _ _SLZ_SSR_ENABLED
			#pragma shader_feature_local _ _NO_SSR
			#if defined(_SLZ_SSR_ENABLED) && !defined(_NO_SSR) && !defined(SHADER_API_MOBILE)
				#define _SSR_ENABLED
			#endif
			// End Injection STANDALONE_DEFINES from Injection_SSR.hlsl ----------------------------------------------------------
					
			#endif
					
			#pragma multi_compile_fragment _ _LIGHT_COOKIES
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			//#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			//#pragma multi_compile_fog
			//#pragma skip_variants FOG_LINEAR FOG_EXP
			//#pragma multi_compile_fragment _ DEBUG_DISPLAY
			//#pragma multi_compile_fragment _ _DETAILS_ON
			//#pragma multi_compile_fragment _ _EMISSION_ON
					
					
			#if defined(LITMAS_FEATURE_LIGHTMAPPING)
				#pragma multi_compile _ LIGHTMAP_ON
				#pragma multi_compile _ DYNAMICLIGHTMAP_ON
				#pragma multi_compile _ DIRLIGHTMAP_COMBINED
				#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#endif
					
					
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
			#undef UNITY_DECLARE_DEPTH_TEXTURE_INCLUDED
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZLighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZBlueNoise.hlsl"
					
			// Begin Injection INCLUDES from Injection_SSR.hlsl ----------------------------------------------------------
			#if !defined(SHADER_API_MOBILE)
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZLightingSSR.hlsl"
			#endif
			// End Injection INCLUDES from Injection_SSR.hlsl ----------------------------------------------------------
					
					
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _BRDFMAP
			#pragma shader_feature_local _HMMMDETAIL_ON
			#pragma shader_feature_local _COLORSHIFT
			#pragma shader_feature_local _VERTEXTINT_ON
			#pragma shader_feature_local _EMITALBEDO_ON
			#pragma shader_feature_local _METALLICTYPE_MAS _METALLICTYPE_METALLICSMOOTHNESS _METALLICTYPE_RMA _METALLICTYPE_MASK
			#pragma shader_feature_local _VERTEXOCCLUSION_ON
			#pragma shader_feature_local _USEOCCLUSION_ON
			#pragma shader_feature_local VERTEXILLUMINATION_ON

					
			struct VertIn
			{
				float4 vertex   : POSITION;
				float3 normal    : NORMAL;
				float4 tangent   : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_color : COLOR;
			};
			
			struct VertOut
			{
				float4 vertex       : SV_POSITION;
				float4 uv0XY_bitZ_fog : TEXCOORD0;
			#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
				float4 uv1 : TEXCOORD1;
			#endif
				half4 SHVertLights : TEXCOORD2;
				half4 normXYZ_tanX : TEXCOORD3;
				float3 wPos : TEXCOORD4;
			
			// Begin Injection INTERPOLATORS from Injection_SSR.hlsl ----------------------------------------------------------
				float4 lastVertex : TEXCOORD5;
			// End Injection INTERPOLATORS from Injection_SSR.hlsl ----------------------------------------------------------
			// Begin Injection INTERPOLATORS from Injection_NormalMaps.hlsl ----------------------------------------------------------
				half4 tanYZ_bitXY : TEXCOORD6;
			// End Injection INTERPOLATORS from Injection_NormalMaps.hlsl ----------------------------------------------------------
			
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
			};
			
			//TEXTURE2D(_BaseMap);
			//SAMPLER(sampler_BaseMap);
			
			//TEXTURE2D(_BumpMap);
			//TEXTURE2D(_MetallicGlossMap);
			
			//TEXTURE2D(_DetailMap);
			//SAMPLER(sampler_DetailMap);
			
			// Begin Injection UNIFORMS from Injection_Emission.hlsl ----------------------------------------------------------
			//TEXTURE2D(_EmissionMap);
			// End Injection UNIFORMS from Injection_Emission.hlsl ----------------------------------------------------------
			
			CBUFFER_START(UnityPerMaterial)
				float4 _MainTex_ST;
				float4 _ParallaxMap_ST;
				float4 _Color;
				float4 _ColorShift1;
				float4 _ColorShift2;
				float4 _ColorShift3;
				float4 _DetailAlbedoMap_ST;
				float4 _EmissionColor;
				float _OcclusionStrength;
				float _NormalToOcclusion;
				float _Specmod;
				float _Glossiness;
				float _Metallic;
				float _BumpScale;
				float _EmissionFalloff;
				float _Cull;
				float _DetailNormalMapScale;
				float _Parallax;
				float _BakedMutiplier;
				float _Cutoff;
				//float4 _BaseMap_ST;
				//half4 _BaseColor;
			// Begin Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			//float4 _DetailMap_ST;
			//half  _Details;
			//half  _Normals;
			// End Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
				float _SSRTemporalMul;
			// End Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_Emission.hlsl ----------------------------------------------------------
				//half  _Emission;
				//half4 _EmissionColor;
				//half  _EmissionFalloff;
				//half  _BakedMutiplier;
			// End Injection MATERIAL_CBUFFER from Injection_Emission.hlsl ----------------------------------------------------------
				//int _Surface;
			CBUFFER_END
			sampler2D _MainTex;
			sampler2D _ParallaxMap;
			sampler2D _ColorMask;
			sampler2D _DetailAlbedoMap;
			sampler2D _DetailMask;
			sampler2D _DetailNormalMap;
			sampler2D _BumpMap;
			sampler2D _EmissionMap;
			sampler2D _MetallicGlossMap;
			sampler2D _OcclusionMap;

			
			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = 2;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
			}
			
			float3 ColorShift454( float4 ColorMask, float4 ColorShift1, float4 ColorShift2, float4 ColorShift3 )
			{
				#if ( _COLORSHIFT )
				float3 ColorMaskTex = 1 - ColorMask.rgb ;
				float3 ColorShifter = max(ColorShift1.rgb, ColorMaskTex.rrr) * max(ColorShift2.rgb, ColorMaskTex.ggg) * max(ColorShift3.rgb, ColorMaskTex.bbb);
				return ColorShifter;
				#else
				return float3(0, 0, 0);
				#endif
			}
			
			float2 ReturnDetailAlbedo446( float In0 )
			{
				return _DetailAlbedoMap_ST.xy;
			}
			
			float4 ChannelPacker464( float4 MetallicMap, float Metallic, float Smoothness, float LuhAcceptor )
			{
				 #if (_METALLICTYPE_MAS)
				return MetallicMap;
				#elif (_METALLICTYPE_RMA)
				return float4(MetallicMap.g, MetallicMap.b, (1 - MetallicMap.r), 0);
				#elif (_METALLICTYPE_MAES)
				return MetallicMap.rgab;
				#elif (_METALLICTYPE_FLOATS)
				return float4(Metallic, 1, Smoothness, 0);
				#else
				return float4(MetallicMap.r, 1, MetallicMap.a, 0);
				#endif
			}
			
			float NormaltoOcclusion458( float3 vNormalTs, float NormalToOcclusion )
			{
				float2 normalABS =  abs(vNormalTs.xy * vNormalTs.xy) ;
				return lerp(1,   (1 - (normalABS.x + normalABS.y) ) * (vNormalTs.z ), NormalToOcclusion);
			}
			
			
			half3 OverlayBlendDetail(half source, half3 destination)
			{
				half3 switch0 = round(destination); // if destination >= 0.5 then 1, else 0 assuming 0-1 input
				half3 blendGreater = mad(mad(2.0, destination, -2.0), 1.0 - source, 1.0); // (2.0 * destination - 2.0) * ( 1.0 - source) + 1.0
				half3 blendLesser = (2.0 * source) * destination;
				return mad(switch0, blendGreater, mad(-switch0, blendLesser, blendLesser)); // switch0 * blendGreater + (1 - switch0) * blendLesser 
				//return half3(destination.r > 0.5 ? blendGreater.r : blendLesser.r,
				//             destination.g > 0.5 ? blendGreater.g : blendLesser.g,
				//             destination.b > 0.5 ? blendGreater.b : blendLesser.b
				//            );
			}
			
			
			VertOut vert(VertIn v  )
			{
				VertOut o = (VertOut)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
			
				float3 ase_worldTangent = TransformObjectToWorldDir(v.tangent.xyz);
				o.ase_texcoord7.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normal);
				o.ase_texcoord8.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord9.xyz = ase_worldBitangent;
				
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.w = 0;
				o.ase_texcoord8.w = 0;
				o.ase_texcoord9.w = 0;
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
				v.normal = v.normal;
			
				o.wPos = TransformObjectToWorld(v.vertex.xyz);
				o.vertex = TransformWorldToHClip(o.wPos);
				o.uv0XY_bitZ_fog.xy = v.uv0.xy;
			
			#if defined(LIGHTMAP_ON) || defined(DIRLIGHTMAP_COMBINED)
				OUTPUT_LIGHTMAP_UV(v.uv1.xy, unity_LightmapST, o.uv1.xy);
			#endif
			
			#ifdef DYNAMICLIGHTMAP_ON
				OUTPUT_LIGHTMAP_UV(v.uv2.xy, unity_DynamicLightmapST, o.uv1.zw);
			#endif
			
				// Exp2 fog
				half clipZ_0Far = UNITY_Z_0_FAR_FROM_CLIPSPACE(o.vertex.z);
				o.uv0XY_bitZ_fog.w = unity_FogParams.x * clipZ_0Far;
			
			// Begin Injection VERTEX_NORMALS from Injection_NormalMaps.hlsl ----------------------------------------------------------
				VertexNormalInputs ntb = GetVertexNormalInputs(v.normal, v.tangent);
				o.normXYZ_tanX = half4(ntb.normalWS, ntb.tangentWS.x);
				o.tanYZ_bitXY = half4(ntb.tangentWS.yz, ntb.bitangentWS.xy);
				o.uv0XY_bitZ_fog.z = ntb.bitangentWS.z;
			// End Injection VERTEX_NORMALS from Injection_NormalMaps.hlsl ----------------------------------------------------------
			
				o.SHVertLights = 0;
				// Calculate vertex lights and L2 probe lighting on quest 
				o.SHVertLights.xyz = VertexLighting(o.wPos, o.normXYZ_tanX.xyz);
			#if !defined(LIGHTMAP_ON) && !defined(DYNAMICLIGHTMAP_ON) && defined(SHADER_API_MOBILE)
				o.SHVertLights.xyz += SampleSHVertex(o.normXYZ_tanX.xyz);
			#endif
			
			// Begin Injection VERTEX_END from Injection_SSR.hlsl ----------------------------------------------------------
				#if defined(_SSR_ENABLED)
					float4 lastWPos = mul(GetPrevObjectToWorldMatrix(), v.vertex);
					o.lastVertex = mul(prevVP, lastWPos);
				#endif
			// End Injection VERTEX_END from Injection_SSR.hlsl ----------------------------------------------------------
				return o;
			}
			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif
			
			half4 frag(VertOut i 
				#ifdef ASE_DEPTH_WRITE_ON
				, out float outputDepth : ASE_SV_DEPTH
				#endif
				) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				float4 uvs4_MainTex = float4(i.uv0XY_bitZ_fog.xy,0,0);
				uvs4_MainTex.xy = float4(i.uv0XY_bitZ_fog.xy,0,0).xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float3 ase_worldTangent = i.ase_texcoord7.xyz;
				float3 ase_worldNormal = i.ase_texcoord8.xyz;
				float3 ase_worldBitangent = i.ase_texcoord9.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - i.wPos.xyz );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = normalize(ase_tanViewDir);
				float2 OffsetPOM153 = POM( _ParallaxMap, uvs4_MainTex.xy, ddx(uvs4_MainTex.xy), ddy(uvs4_MainTex.xy), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, ( _Parallax * -1.0 ), 0, _ParallaxMap_ST.xy, float2(0,0), 0 );
				float2 UV_Main492 = OffsetPOM153;
				float4 tex2DNode9 = tex2D( _MainTex, UV_Main492 );
				float4 color297 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				#ifdef _VERTEXTINT_ON
				float4 staticSwitch296 = i.ase_color;
				#else
				float4 staticSwitch296 = color297;
				#endif
				float4 temp_output_178_0 = ( tex2DNode9 * _Color * staticSwitch296 );
				float4 tex2DNode282 = tex2D( _ColorMask, UV_Main492 );
				float4 ColorMask454 = tex2DNode282;
				float4 ColorShift1454 = _ColorShift1;
				float4 ColorShift2454 = _ColorShift2;
				float4 ColorShift3454 = _ColorShift3;
				float3 localColorShift454 = ColorShift454( ColorMask454 , ColorShift1454 , ColorShift2454 , ColorShift3454 );
				float3 ColorMask473 = localColorShift454;
				#ifdef _COLORSHIFT
				float4 staticSwitch293 = ( temp_output_178_0 * float4( ColorMask473 , 0.0 ) );
				#else
				float4 staticSwitch293 = temp_output_178_0;
				#endif
				float4 ColorMaskAlbedo501 = staticSwitch293;
				float In0446 = 0.0;
				float2 localReturnDetailAlbedo446 = ReturnDetailAlbedo446( In0446 );
				float4 uvs4_DetailAlbedoMap = float4(i.uv0XY_bitZ_fog.xy,0,0);
				uvs4_DetailAlbedoMap.xy = float4(i.uv0XY_bitZ_fog.xy,0,0).xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
				float4 DetailAlbedoUV499 = ( ( ( float4( OffsetPOM153, 0.0 , 0.0 ) - uvs4_MainTex ) * float4( localReturnDetailAlbedo446, 0.0 , 0.0 ) ) + uvs4_DetailAlbedoMap );
				float temp_output_9_0_g135 = tex2D( _DetailMask, DetailAlbedoUV499.xy ).r;
				float temp_output_18_0_g135 = ( 1.0 - temp_output_9_0_g135 );
				float3 appendResult16_g135 = (float3(temp_output_18_0_g135 , temp_output_18_0_g135 , temp_output_18_0_g135));
				#ifdef _HMMMDETAIL_ON
				float4 staticSwitch199 = float4( ( ColorMaskAlbedo501.rgb * ( ( ( tex2D( _DetailAlbedoMap, DetailAlbedoUV499.xy ).rgb * (unity_ColorSpaceDouble).rgb ) * temp_output_9_0_g135 ) + appendResult16_g135 ) ) , 0.0 );
				#else
				float4 staticSwitch199 = staticSwitch293;
				#endif
				float4 AlbedoDetails488 = staticSwitch199;
				
				float3 unpack99 = UnpackNormalScale( tex2D( _DetailNormalMap, DetailAlbedoUV499.xy ), _DetailNormalMapScale );
				unpack99.z = lerp( 1, unpack99.z, saturate(_DetailNormalMapScale) );
				float3 DetailNormal480 = unpack99;
				float clampResult73 = clamp( _BumpScale , 0.0 , 1.0 );
				float3 unpack70 = UnpackNormalScale( tex2D( _BumpMap, UV_Main492 ), clampResult73 );
				unpack70.z = lerp( 1, unpack70.z, saturate(clampResult73) );
				float3 NormalMap477 = unpack70;
				float3 temp_output_460_0 = BlendNormal( DetailNormal480 , NormalMap477 );
				float3 Normals486 = temp_output_460_0;
				
				#ifdef _EMITALBEDO_ON
				float4 staticSwitch391 = staticSwitch293;
				#else
				float4 staticSwitch391 = float4(1,1,1,1);
				#endif
				float4 temp_output_249_0 = ( tex2D( _EmissionMap, UV_Main492 ) * _EmissionColor * staticSwitch391 );
				float dotResult3_g134 = dot( ase_worldViewDir , ase_worldNormal );
				float4 Emission484 = ( temp_output_249_0 * saturate( pow( abs( dotResult3_g134 ) , _EmissionFalloff ) ) );
				
				float4 BakedEmission482 = ( temp_output_249_0 * _BakedMutiplier );
				
				float4 MetallicMap464 = tex2D( _MetallicGlossMap, UV_Main492 );
				float Metallic464 = _Metallic;
				float Smoothness464 = _Glossiness;
				#if defined(_METALLICTYPE_MAS)
				float staticSwitch157 = 0.0;
				#elif defined(_METALLICTYPE_METALLICSMOOTHNESS)
				float staticSwitch157 = 0.0;
				#elif defined(_METALLICTYPE_RMA)
				float staticSwitch157 = 0.0;
				#elif defined(_METALLICTYPE_MASK)
				float staticSwitch157 = 0.0;
				#else
				float staticSwitch157 = 0.0;
				#endif
				float LuhAcceptor464 = staticSwitch157;
				float4 localChannelPacker464 = ChannelPacker464( MetallicMap464 , Metallic464 , Smoothness464 , LuhAcceptor464 );
				float4 break465 = localChannelPacker464;
				
				#ifdef _VERTEXOCCLUSION_ON
				float staticSwitch300 = pow( i.ase_color.r , 2.0 );
				#else
				float staticSwitch300 = 1.0;
				#endif
				#ifdef _USEOCCLUSION_ON
				float staticSwitch82 = tex2D( _OcclusionMap, UV_Main492 ).g;
				#else
				float staticSwitch82 = break465.y;
				#endif
				float3 vNormalTs458 = temp_output_460_0;
				float NormalToOcclusion458 = _NormalToOcclusion;
				float localNormaltoOcclusion458 = NormaltoOcclusion458( vNormalTs458 , NormalToOcclusion458 );
				float lerpResult468 = lerp( 1.0 , ( staticSwitch300 * staticSwitch82 * localNormaltoOcclusion458 ) , _OcclusionStrength);
				float Occlusion490 = lerpResult468;
				
				#ifdef VERTEXILLUMINATION_ON
				float staticSwitch305 = i.ase_color.a;
				#else
				float staticSwitch305 = 0.0;
				#endif
				
			
			//--------------------------------------------------------------------------------------------------------------------------
			//--Read Input Data---------------------------------------------------------------------------------------------------------
			//--------------------------------------------------------------------------------------------------------------------------
			
				//float2 uv_main = mad(float2(i.uv0XY_bitZ_fog.xy), _BaseMap_ST.xy, _BaseMap_ST.zw);
				//float2 uv_detail = mad(float2(i.uv0XY_bitZ_fog.xy), _DetailMap_ST.xy, _DetailMap_ST.zw);
				//half4 albedo = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, uv_main);
				//half4 mas = SAMPLE_TEXTURE2D(_MetallicGlossMap, sampler_BaseMap, uv_main);
			
			
			
				//albedo *= _BaseColor;
				//half metallic = mas.r;
				//half ao = mas.g;
				//half smoothness = mas.b;
			
			
			//---------------------------------------------------------------------------------------------------------------------------
			//---Sample Normal Map-------------------------------------------------------------------------------------------------------
			//---------------------------------------------------------------------------------------------------------------------------
			
				//half3 normalTS = half3(0, 0, 1);
				//half  geoSmooth = 1;
				//half4 normalMap = half4(0, 0, 1, 0);
			
				half3 albedo3 = AlbedoDetails488.rgb;
				half3 normalTS = Normals486;
				half3 emission = Emission484.rgb;
				half3 emissionbaked = BakedEmission482.rgb;
			
			// Begin Injection NORMAL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				//normalMap = SAMPLE_TEXTURE2D(_BumpMap, sampler_BaseMap, uv_main);
				//normalTS = UnpackNormal(normalMap);
				//normalTS = _Normals ? normalTS : half3(0, 0, 1);
				//geoSmooth = _Normals ? normalMap.b : 1.0;
				//smoothness = saturate(smoothness + geoSmooth - 1.0);
			// End Injection NORMAL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				half metallic = break465.x;
				half3 specular = half3(0.5, 0.5, 0.5);
				half smoothness = ( break465.z * _Specmod );
				half ao = Occlusion490;
				half alpha = ( ( _Cull * 0.0 ) + ( staticSwitch305 + ( tex2DNode9.a * _Color.a ) ) );
				half alphaclip = _Cutoff;
				half alphaclipthresholdshadow = half(0);
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif
			
				#if defined(_ALPHATEST_ON)
					clip(alpha - alphaclip);
				#endif
			
				#if defined(_ISTRANSPARENT)
					_SSRTemporalMul = 0.0;
				#endif
				half4 albedo = half4(albedo3.rgb, alpha);
			
			//---------------------------------------------------------------------------------------------------------------------------
			//---Read Detail Map---------------------------------------------------------------------------------------------------------
			//---------------------------------------------------------------------------------------------------------------------------
			
				//#if defined(_DETAILS_ON) 
			
			// Begin Injection DETAIL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
					//half4 detailMap = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, uv_detail);
					//half3 detailTS = half3(2.0 * detailMap.ag - 1.0, 1.0);
					//normalTS = BlendNormal(normalTS, detailTS);
			// End Injection DETAIL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				   
					//smoothness = saturate(2.0 * detailMap.b * smoothness);
					//albedo.rgb = OverlayBlendDetail(detailMap.r, albedo.rgb);
			
				//#endif
			
			
			//---------------------------------------------------------------------------------------------------------------------------
			//---Transform Normals To Worldspace-----------------------------------------------------------------------------------------
			//---------------------------------------------------------------------------------------------------------------------------
			
			// Begin Injection NORMAL_TRANSFORM from Injection_NormalMaps.hlsl ----------------------------------------------------------
				half3 normalWS = i.normXYZ_tanX.xyz;
				half3x3 TStoWS = half3x3(
					i.normXYZ_tanX.w, i.tanYZ_bitXY.z, normalWS.x,
					i.tanYZ_bitXY.x, i.tanYZ_bitXY.w, normalWS.y,
					i.tanYZ_bitXY.y, i.uv0XY_bitZ_fog.z, normalWS.z
					);
				normalWS = mul(TStoWS, normalTS);
				normalWS = normalize(normalWS);
			// End Injection NORMAL_TRANSFORM from Injection_NormalMaps.hlsl ----------------------------------------------------------
				
				
			//---------------------------------------------------------------------------------------------------------------------------//
			//---Lighting Calculations---------------------------------------------------------------------------------------------------//
			//---------------------------------------------------------------------------------------------------------------------------//
				
			// Begin Injection SPEC_AA from Injection_NormalMaps.hlsl ----------------------------------------------------------
				#if !defined(SHADER_API_MOBILE) && !defined(LITMAS_FEATURE_TP) // Specular antialiasing based on normal derivatives. Only on PC to avoid cost of derivatives on Quest
					smoothness = min(smoothness, SLZGeometricSpecularAA(normalWS));
				#endif
			// End Injection SPEC_AA from Injection_NormalMaps.hlsl ----------------------------------------------------------
				
				
				#if defined(LIGHTMAP_ON)
					SLZFragData fragData = SLZGetFragData(i.vertex, i.wPos, normalWS, i.uv1.xy, i.uv1.zw, i.SHVertLights.xyz);
				#else
					SLZFragData fragData = SLZGetFragData(i.vertex, i.wPos, normalWS, float2(0, 0), float2(0, 0), i.SHVertLights.xyz);
				#endif
				
				//half4 emission = half4(0,0,0,0);
				
			// Begin Injection EMISSION from Injection_Emission.hlsl ----------------------------------------------------------
				//UNITY_BRANCH if (_Emission)
				//{
					//emission += SAMPLE_TEXTURE2D(_EmissionMap, sampler_BaseMap, uv_main) * _EmissionColor;
					//emission.rgb *= lerp(albedo.rgb, half3(1, 1, 1), emission.a);
					//emission.rgb *= pow(abs(fragData.NoV), _EmissionFalloff);
				//}
			// End Injection EMISSION from Injection_Emission.hlsl ----------------------------------------------------------
				
				
				#if !defined(_SLZ_SPECULAR_SETUP)
				SLZSurfData surfData = SLZGetSurfDataMetallicGloss(albedo.rgb, saturate(metallic), saturate(smoothness), ao, emission.rgb, albedo.a);
				#else
				SLZSurfData surfData;
			    surfData.albedo = albedo.rgb;
			    surfData.specular = specular.rgb;
			    surfData.perceptualRoughness = half(1.0) - saturate(smoothness);
			    surfData.reflectivity = (specular.r + specular.g + specular.b) / half(3.0);
			    surfData.roughness = max(surfData.perceptualRoughness * surfData.perceptualRoughness, 1.0e-3h);
			    surfData.emission = emission.rgb;
			    surfData.occlusion = ao;
			    surfData.alpha = alpha;
				#endif
				
				half4 color = half4(1, 1, 1, 1);
				
				#if defined(_SurfaceOpaque)
				int _Surface = 0;
				#elif defined(_SurfaceTransparent)
				int _Surface = 1;
				#elif defined(_SurfaceFade)
				int _Surface = 2;
				#else
				int _Surface = 0;
				#endif
				
			// Begin Injection LIGHTING_CALC from Injection_SSR.hlsl ----------------------------------------------------------
				#if defined(_SSR_ENABLED)
					half4 noiseRGBA = GetScreenNoiseRGBA(fragData.screenUV);
				
					SSRExtraData ssrExtra;
					ssrExtra.meshNormal = i.normXYZ_tanX.xyz;
					ssrExtra.lastClipPos = i.lastVertex;
					ssrExtra.temporalWeight = _SSRTemporalMul;
					ssrExtra.depthDerivativeSum = 0;
					ssrExtra.noise = noiseRGBA;
					ssrExtra.fogFactor = i.uv0XY_bitZ_fog.w;
				
					color = SLZPBRFragmentSSR(fragData, surfData, ssrExtra, _Surface);
					color.rgb = max(0, color.rgb);
				#else
					color = SLZPBRFragment(fragData, surfData, _Surface);
				#endif
			// End Injection LIGHTING_CALC from Injection_SSR.hlsl ----------------------------------------------------------
				
				
			// Begin Injection VOLUMETRIC_FOG from Injection_SSR.hlsl ----------------------------------------------------------
				#if !defined(_SSR_ENABLED)
					color = MixFogSurf(color, -fragData.viewDir, i.uv0XY_bitZ_fog.w, _Surface);
					
					color = VolumetricsSurf(color, fragData.position, _Surface);
				#endif
			// End Injection VOLUMETRIC_FOG from Injection_SSR.hlsl ----------------------------------------------------------
				#ifdef ASE_DEPTH_WRITE_ON
				outputDepth = DepthValue;
				#endif
				
				return color;
			}
			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			ENDHLSL
		}

		
		Pass
		{
			

			Name "DepthOnly"
			Tags { "Lightmode"="DepthOnly" }
			
			
			ColorMask 0

			HLSLPROGRAM
			#define _ISTRANSPARENT
			#define _SurfaceFade
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _ALPHATEST_ON 1
			#define ASE_SRP_VERSION 999999

			#pragma vertex vert
			#pragma fragment frag
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			//DepthOnly------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Packing.hlsl"

			#pragma shader_feature_local _BRDFMAP
			#pragma shader_feature_local VERTEXILLUMINATION_ON


			struct appdata
			{
			    float4 vertex : POSITION;
			
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				float3 ase_normal : NORMAL;
			    UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
			    float4 vertex : SV_POSITION;
			
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
			    UNITY_VERTEX_INPUT_INSTANCE_ID
			    UNITY_VERTEX_OUTPUT_STEREO
			};
			sampler2D _MainTex;
			sampler2D _ParallaxMap;
			CBUFFER_START( UnityPerMaterial )
			float4 _MainTex_ST;
			float4 _ParallaxMap_ST;
			float4 _Color;
			float4 _ColorShift1;
			float4 _ColorShift2;
			float4 _ColorShift3;
			float4 _DetailAlbedoMap_ST;
			float4 _EmissionColor;
			float _OcclusionStrength;
			float _NormalToOcclusion;
			float _Specmod;
			float _Glossiness;
			float _Metallic;
			float _BumpScale;
			float _EmissionFalloff;
			float _Cull;
			float _DetailNormalMapScale;
			float _Parallax;
			float _BakedMutiplier;
			float _Cutoff;
			CBUFFER_END


			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = 2;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
			}
			

			v2f vert(appdata v )
			{
			    v2f o;
			    UNITY_SETUP_INSTANCE_ID(v);
			    UNITY_TRANSFER_INSTANCE_ID(v, o);
			    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

			    float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
			    o.ase_texcoord1.xyz = ase_worldTangent;
			    float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
			    o.ase_texcoord2.xyz = ase_worldNormal;
			    float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
			    float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
			    o.ase_texcoord3.xyz = ase_worldBitangent;
			    float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
			    o.ase_texcoord4.xyz = ase_worldPos;
			    
			    o.ase_color = v.ase_color;
			    o.ase_texcoord = v.ase_texcoord;
			    
			    //setting value to unused interpolator channels and avoid initialization warnings
			    o.ase_texcoord1.w = 0;
			    o.ase_texcoord2.w = 0;
			    o.ase_texcoord3.w = 0;
			    o.ase_texcoord4.w = 0;
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
			
			    o.vertex = TransformObjectToHClip(v.vertex.xyz);
			    return o;
			}
			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
			    #define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
			    #define ASE_SV_DEPTH SV_Depth
			#endif

			half4 frag(v2f i 
			    #ifdef ASE_DEPTH_WRITE_ON
			    , out float outputDepth : ASE_SV_DEPTH
			    #endif
			     ) : SV_Target
			{
			    UNITY_SETUP_INSTANCE_ID(i);
			    UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
			    #ifdef VERTEXILLUMINATION_ON
			    float staticSwitch305 = i.ase_color.a;
			    #else
			    float staticSwitch305 = 0.0;
			    #endif
			    float4 uvs4_MainTex = i.ase_texcoord;
			    uvs4_MainTex.xy = i.ase_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
			    float3 ase_worldTangent = i.ase_texcoord1.xyz;
			    float3 ase_worldNormal = i.ase_texcoord2.xyz;
			    float3 ase_worldBitangent = i.ase_texcoord3.xyz;
			    float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
			    float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
			    float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
			    float3 ase_worldPos = i.ase_texcoord4.xyz;
			    float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
			    ase_worldViewDir = normalize(ase_worldViewDir);
			    float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
			    ase_tanViewDir = normalize(ase_tanViewDir);
			    float2 OffsetPOM153 = POM( _ParallaxMap, uvs4_MainTex.xy, ddx(uvs4_MainTex.xy), ddy(uvs4_MainTex.xy), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, ( _Parallax * -1.0 ), 0, _ParallaxMap_ST.xy, float2(0,0), 0 );
			    float2 UV_Main492 = OffsetPOM153;
			    float4 tex2DNode9 = tex2D( _MainTex, UV_Main492 );
			    
			
				half alpha = ( ( _Cull * 0.0 ) + ( staticSwitch305 + ( tex2DNode9.a * _Color.a ) ) );
				half alphaclip = _Cutoff;
				half alphaclipthresholdshadow = half(0);
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif
				#if defined(_ALPHATEST_ON)
					clip(alpha - alphaclip);
				#endif
				#ifdef ASE_DEPTH_WRITE_ON
				outputDepth = DepthValue;
				#endif
			
			    return 0;
			}
			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "Lightmode"="DepthNormals" }
			
			
			
			

			HLSLPROGRAM
			#define _ISTRANSPARENT
			#define _SurfaceFade
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _ALPHATEST_ON 1
			#define ASE_SRP_VERSION 999999

			#pragma vertex vert
			#pragma fragment frag
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			//StandardDepthNormals-------------------------------------------------------------------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//
			//
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
					
			#define SHADERPASS SHADERPASS_DEPTHNORMALS
					
			#if defined(SHADER_API_MOBILE)
			#else
			#endif
					
					
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Packing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/EncodeNormalsTexture.hlsl"
					
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local _BRDFMAP
			#pragma shader_feature_local VERTEXILLUMINATION_ON

					
			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			// Begin Injection VERTEX_IN from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				float4 tangent : TANGENT;
				float2 uv0 : TEXCOORD0;
			// End Injection VERTEX_IN from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 normalWS : NORMAL;
				float2 uv0 : TEXCOORD0;
			// Begin Injection INTERPOLATORS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				float4 tanYZ_bitXY : TEXCOORD1;
				float4 uv0XY_bitZ_fog : TEXCOORD2;
			// End Injection INTERPOLATORS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			
			// Begin Injection UNIFORMS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				//TEXTURE2D(_BumpMap);
				//SAMPLER(sampler_BumpMap);
			// End Injection UNIFORMS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
			
			CBUFFER_START(UnityPerMaterial)
				float4 _MainTex_ST;
				float4 _ParallaxMap_ST;
				float4 _Color;
				float4 _ColorShift1;
				float4 _ColorShift2;
				float4 _ColorShift3;
				float4 _DetailAlbedoMap_ST;
				float4 _EmissionColor;
				float _OcclusionStrength;
				float _NormalToOcclusion;
				float _Specmod;
				float _Glossiness;
				float _Metallic;
				float _BumpScale;
				float _EmissionFalloff;
				float _Cull;
				float _DetailNormalMapScale;
				float _Parallax;
				float _BakedMutiplier;
				float _Cutoff;
				//float4 _BaseMap_ST;
				//half4 _BaseColor;
			// Begin Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			//float4 _DetailMap_ST;
			//half  _Details;
			//half  _Normals;
			// End Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
				float _SSRTemporalMul;
			// End Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//half  _Emission;
				//half4 _EmissionColor;
				//half  _EmissionFalloff;
				//half  _BakedMutiplier;
			// End Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//int _Surface;
			CBUFFER_END
			sampler2D _DetailNormalMap;
			sampler2D _MainTex;
			sampler2D _ParallaxMap;
			sampler2D _DetailAlbedoMap;
			sampler2D _BumpMap;

				
			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = 2;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
			}
			
			float2 ReturnDetailAlbedo446( float In0 )
			{
				return _DetailAlbedoMap_ST.xy;
			}
			
			
			v2f vert(appdata v  )
			{
			
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
			
			
				float3 ase_worldTangent = TransformObjectToWorldDir(v.tangent.xyz);
				o.ase_texcoord3.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normal);
				o.ase_texcoord4.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord5.xyz = ase_worldBitangent;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				o.ase_texcoord6.xyz = ase_worldPos;
				
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;
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
				o.vertex = TransformObjectToHClip(v.vertex.xyz);
				v.normal = v.normal;
			
			// Begin Injection VERTEX_NORMAL from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				VertexNormalInputs ntb = GetVertexNormalInputs(v.normal, v.tangent);
				o.normalWS = float4(ntb.normalWS, ntb.tangentWS.x);
				o.tanYZ_bitXY = float4(ntb.tangentWS.yz, ntb.bitangentWS.xy);
				o.uv0XY_bitZ_fog.zw = ntb.bitangentWS.zz;
				o.uv0XY_bitZ_fog.xy = v.uv0.xy;
			// End Injection VERTEX_NORMAL from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				o.uv0 = v.uv0;
			
				return o;
			}
			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif
			
			half4 frag(v2f i
				#ifdef ASE_DEPTH_WRITE_ON
				, out float outputDepth : ASE_SV_DEPTH
				#endif
				) : SV_Target
			{
			   UNITY_SETUP_INSTANCE_ID(i);
			   UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
			   float4 uvs4_MainTex = float4(i.uv0.xy,0,0);
			   uvs4_MainTex.xy = float4(i.uv0.xy,0,0).xy * _MainTex_ST.xy + _MainTex_ST.zw;
			   float3 ase_worldTangent = i.ase_texcoord3.xyz;
			   float3 ase_worldNormal = i.ase_texcoord4.xyz;
			   float3 ase_worldBitangent = i.ase_texcoord5.xyz;
			   float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
			   float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
			   float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
			   float3 ase_worldPos = i.ase_texcoord6.xyz;
			   float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
			   ase_worldViewDir = normalize(ase_worldViewDir);
			   float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
			   ase_tanViewDir = normalize(ase_tanViewDir);
			   float2 OffsetPOM153 = POM( _ParallaxMap, uvs4_MainTex.xy, ddx(uvs4_MainTex.xy), ddy(uvs4_MainTex.xy), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, ( _Parallax * -1.0 ), 0, _ParallaxMap_ST.xy, float2(0,0), 0 );
			   float In0446 = 0.0;
			   float2 localReturnDetailAlbedo446 = ReturnDetailAlbedo446( In0446 );
			   float4 uvs4_DetailAlbedoMap = float4(i.uv0.xy,0,0);
			   uvs4_DetailAlbedoMap.xy = float4(i.uv0.xy,0,0).xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
			   float4 DetailAlbedoUV499 = ( ( ( float4( OffsetPOM153, 0.0 , 0.0 ) - uvs4_MainTex ) * float4( localReturnDetailAlbedo446, 0.0 , 0.0 ) ) + uvs4_DetailAlbedoMap );
			   float3 unpack99 = UnpackNormalScale( tex2D( _DetailNormalMap, DetailAlbedoUV499.xy ), _DetailNormalMapScale );
			   unpack99.z = lerp( 1, unpack99.z, saturate(_DetailNormalMapScale) );
			   float3 DetailNormal480 = unpack99;
			   float2 UV_Main492 = OffsetPOM153;
			   float clampResult73 = clamp( _BumpScale , 0.0 , 1.0 );
			   float3 unpack70 = UnpackNormalScale( tex2D( _BumpMap, UV_Main492 ), clampResult73 );
			   unpack70.z = lerp( 1, unpack70.z, saturate(clampResult73) );
			   float3 NormalMap477 = unpack70;
			   float3 temp_output_460_0 = BlendNormal( DetailNormal480 , NormalMap477 );
			   float3 Normals486 = temp_output_460_0;
			   
			   #ifdef VERTEXILLUMINATION_ON
			   float staticSwitch305 = i.ase_color.a;
			   #else
			   float staticSwitch305 = 0.0;
			   #endif
			   float4 tex2DNode9 = tex2D( _MainTex, UV_Main492 );
			   
			
			
			   half4 normals = half4(0, 0, 0, 1);
			   half3 normalTS = Normals486;
			
			// Begin Injection FRAG_NORMALS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				//half4 normalMap = SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, i.uv0XY_bitZ_fog.xy);
				//half3 normalTS = UnpackNormal(normalMap);
				//normalTS = _Normals ? normalTS : half3(0, 0, 1);
			
			
				half3x3 TStoWS = half3x3(
					i.normalWS.w, i.tanYZ_bitXY.z, i.normalWS.x,
					i.tanYZ_bitXY.x, i.tanYZ_bitXY.w, i.normalWS.y,
					i.tanYZ_bitXY.y, i.uv0XY_bitZ_fog.z, i.normalWS.z
					);
				half3 normalWS = mul(TStoWS, normalTS);
				normalWS = normalize(normalWS);
				
				normals = half4(EncodeWSNormalForNormalsTex(normalWS),0);
			// End Injection FRAG_NORMALS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				half alpha = ( ( _Cull * 0.0 ) + ( staticSwitch305 + ( tex2DNode9.a * _Color.a ) ) );
				half alphaclip = _Cutoff;
				half alphaclipthresholdshadow = half(0);
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif
				
				#if defined(_ALPHATEST_ON)
					clip(alpha - alphaclip);
				#endif
				
				#ifdef ASE_DEPTH_WRITE_ON
				outputDepth = DepthValue;
				#endif
				
				return normals;
			}
			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			ENDHLSL
		}

		
		Pass
		{
			
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			
			
			
			
			ColorMask 0

			HLSLPROGRAM
			#define _ISTRANSPARENT
			#define _SurfaceFade
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _ALPHATEST_ON 1
			#define ASE_SRP_VERSION 999999

			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			//ShadowCaster---------------------------------------------------------------------------------------------------------------------------------------------------------------------
			#define SHADERPASS SHADERPASS_SHADOWCASTER


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZExtentions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local _BRDFMAP
			#pragma shader_feature_local VERTEXILLUMINATION_ON

			// Shadow Casting Light geometric parameters. These variables are used when applying the shadow Normal Bias and are set by UnityEngine.Rendering.Universal.ShadowUtils.SetupShadowCasterConstantBuffer in com.unity.render-pipelines.universal/Runtime/ShadowUtils.cs
			// For Directional lights, _LightDirection is used when applying shadow Normal Bias.
			// For Spot lights and Point lights, _LightPosition is used to compute the actual light direction because it is different at each shadow caster geometry vertex.
			float3 _LightDirection;
			float3 _LightPosition;

			struct Attributes
			{
			    float4 positionOS   : POSITION;
			    float3 normalOS     : NORMAL;
			    float4 ase_color : COLOR;
			    float4 ase_texcoord : TEXCOORD0;
			    float4 ase_tangent : TANGENT;
			    UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct Varyings
			{
			    float4 positionCS   : SV_POSITION;
			    float4 ase_color : COLOR;
			    float4 ase_texcoord1 : TEXCOORD1;
			    float4 ase_texcoord2 : TEXCOORD2;
			    float4 ase_texcoord3 : TEXCOORD3;
			    float4 ase_texcoord4 : TEXCOORD4;
			    float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			sampler2D _MainTex;
			sampler2D _ParallaxMap;
			CBUFFER_START( UnityPerMaterial )
			float4 _MainTex_ST;
			float4 _ParallaxMap_ST;
			float4 _Color;
			float4 _ColorShift1;
			float4 _ColorShift2;
			float4 _ColorShift3;
			float4 _DetailAlbedoMap_ST;
			float4 _EmissionColor;
			float _OcclusionStrength;
			float _NormalToOcclusion;
			float _Specmod;
			float _Glossiness;
			float _Metallic;
			float _BumpScale;
			float _EmissionFalloff;
			float _Cull;
			float _DetailNormalMapScale;
			float _Parallax;
			float _BakedMutiplier;
			float _Cutoff;
			CBUFFER_END


			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = 2;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
			}
			

			float4 GetShadowPositionHClip(Attributes input)
			{
			    float3 positionWS = TransformObjectToWorld(input.positionOS.xyz);
			    float3 normalWS = TransformObjectToWorldNormal(input.normalOS);
			
			#if _CASTING_PUNCTUAL_LIGHT_SHADOW
			    float3 lightDirectionWS = normalize(_LightPosition - positionWS);
			#else
			    float3 lightDirectionWS = _LightDirection;
			#endif
			    float2 vShadowOffsets = GetShadowOffsets(normalWS, lightDirectionWS);
			    //positionWS.xyz -= vShadowOffsets.x * normalWS.xyz * .01;
			    positionWS.xyz -= vShadowOffsets.y * lightDirectionWS.xyz * .01;
			    float4 positionCS = TransformObjectToHClip(float4(mul(unity_WorldToObject, float4(positionWS.xyz, 1.0)).xyz, 1.0));
			    //float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, lightDirectionWS));
			
			#if UNITY_REVERSED_Z
			    positionCS.z = min(positionCS.z, UNITY_NEAR_CLIP_VALUE);
			#else
			    positionCS.z = max(positionCS.z, UNITY_NEAR_CLIP_VALUE);
			#endif
			
			    return positionCS;
			}

			Varyings vert(Attributes input )
			{
			    Varyings output;
			    UNITY_SETUP_INSTANCE_ID(input);
			    float3 ase_worldTangent = TransformObjectToWorldDir(input.ase_tangent.xyz);
			    output.ase_texcoord2.xyz = ase_worldTangent;
			    float3 ase_worldNormal = TransformObjectToWorldNormal(input.normalOS);
			    output.ase_texcoord3.xyz = ase_worldNormal;
			    float ase_vertexTangentSign = input.ase_tangent.w * unity_WorldTransformParams.w;
			    float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
			    output.ase_texcoord4.xyz = ase_worldBitangent;
			    float3 ase_worldPos = mul(GetObjectToWorldMatrix(), input.positionOS).xyz;
			    output.ase_texcoord5.xyz = ase_worldPos;
			    
			    output.ase_color = input.ase_color;
			    output.ase_texcoord1 = input.ase_texcoord;
			    
			    //setting value to unused interpolator channels and avoid initialization warnings
			    output.ase_texcoord2.w = 0;
			    output.ase_texcoord3.w = 0;
			    output.ase_texcoord4.w = 0;
			    output.ase_texcoord5.w = 0;
			
			    input.normalOS.xyz = input.normalOS.xyz;
			    #ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif
			
			    output.positionCS = GetShadowPositionHClip(input);
			
			    return output;
			}
			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif

			half4 frag(Varyings input 
			    #ifdef ASE_DEPTH_WRITE_ON
			    , out float outputDepth : ASE_SV_DEPTH
			    #endif
			    ) : SV_TARGET
			{
			    UNITY_SETUP_INSTANCE_ID( input );
			    #ifdef VERTEXILLUMINATION_ON
			    float staticSwitch305 = input.ase_color.a;
			    #else
			    float staticSwitch305 = 0.0;
			    #endif
			    float4 uvs4_MainTex = input.ase_texcoord1;
			    uvs4_MainTex.xy = input.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
			    float3 ase_worldTangent = input.ase_texcoord2.xyz;
			    float3 ase_worldNormal = input.ase_texcoord3.xyz;
			    float3 ase_worldBitangent = input.ase_texcoord4.xyz;
			    float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
			    float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
			    float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
			    float3 ase_worldPos = input.ase_texcoord5.xyz;
			    float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
			    ase_worldViewDir = normalize(ase_worldViewDir);
			    float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
			    ase_tanViewDir = normalize(ase_tanViewDir);
			    float2 OffsetPOM153 = POM( _ParallaxMap, uvs4_MainTex.xy, ddx(uvs4_MainTex.xy), ddy(uvs4_MainTex.xy), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, ( _Parallax * -1.0 ), 0, _ParallaxMap_ST.xy, float2(0,0), 0 );
			    float2 UV_Main492 = OffsetPOM153;
			    float4 tex2DNode9 = tex2D( _MainTex, UV_Main492 );
			    

				half alpha = ( ( _Cull * 0.0 ) + ( staticSwitch305 + ( tex2DNode9.a * _Color.a ) ) );
				half alphaclip = _Cutoff;
				half alphaclipthresholdshadow = half(0);
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif
				#if defined(_ALPHATEST_ON)
					#ifdef _ALPHATEST_SHADOW_ON
						clip(alpha - alphaclipthresholdshadow);
					#else
						clip(alpha - alphaclip);
					#endif
				#endif
			
			    #ifdef ASE_DEPTH_WRITE_ON
			        outputDepth = DepthValue;
			    #endif
			
			    return 0;
			}

			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }
			
			
			Cull Off

			HLSLPROGRAM
			#define _ISTRANSPARENT
			#define _SurfaceFade
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _ALPHATEST_ON 1
			#define ASE_SRP_VERSION 999999
			#ifdef UNITY_COLORSPACE_GAMMA//ASE Color Space Def
			#define unity_ColorSpaceDouble half4(2.0, 2.0, 2.0, 2.0)//ASE Color Space Def
			#else // Linear values//ASE Color Space Def
			#define unity_ColorSpaceDouble half4(4.59479380, 4.59479380, 4.59479380, 2.0)//ASE Color Space Def
			#endif//ASE Color Space Def

			#define _NORMAL_DROPOFF_TS 1
			#define _EMISSION
			#define _NORMALMAP 1

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_META
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			//StandardMeta.hlsl---------------------------------------------------------------------------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//
			//
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------

			#define SHADERPASS SHADERPASS_META
			#define PASS_META

			#if defined(SHADER_API_MOBILE)


			#else


			#endif

			//#pragma shader_feature _ EDITOR_VISUALIZATION


			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _BRDFMAP
			#pragma shader_feature_local _HMMMDETAIL_ON
			#pragma shader_feature_local _COLORSHIFT
			#pragma shader_feature_local _VERTEXTINT_ON
			#pragma shader_feature_local _EMITALBEDO_ON
			#pragma shader_feature_local VERTEXILLUMINATION_ON


			//TEXTURE2D(_BaseMap);
			//SAMPLER(sampler_BaseMap);

			// Begin Injection UNIFORMS from Injection_Emission_Meta.hlsl ----------------------------------------------------------
			//TEXTURE2D(_EmissionMap);
			// End Injection UNIFORMS from Injection_Emission_Meta.hlsl ----------------------------------------------------------

			CBUFFER_START(UnityPerMaterial)
				float4 _MainTex_ST;
				float4 _ParallaxMap_ST;
				float4 _Color;
				float4 _ColorShift1;
				float4 _ColorShift2;
				float4 _ColorShift3;
				float4 _DetailAlbedoMap_ST;
				float4 _EmissionColor;
				float _OcclusionStrength;
				float _NormalToOcclusion;
				float _Specmod;
				float _Glossiness;
				float _Metallic;
				float _BumpScale;
				float _EmissionFalloff;
				float _Cull;
				float _DetailNormalMapScale;
				float _Parallax;
				float _BakedMutiplier;
				float _Cutoff;
				//float4 _BaseMap_ST;
				//half4 _BaseColor;
			// Begin Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			//float4 _DetailMap_ST;
			//half  _Details;
			//half  _Normals;
			// End Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
				float _SSRTemporalMul;
			// End Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//half  _Emission;
				//half4 _EmissionColor;
				//half  _EmissionFalloff;
				//half  _BakedMutiplier;
			// End Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//int _Surface;
			CBUFFER_END
			sampler2D _MainTex;
			sampler2D _ParallaxMap;
			sampler2D _ColorMask;
			sampler2D _DetailAlbedoMap;
			sampler2D _DetailMask;
			sampler2D _EmissionMap;


			struct appdata
			{
				float4 vertex : POSITION;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				float4 ase_tangent : TANGENT;
				float3 ase_normal : NORMAL;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			
				#ifdef EDITOR_VISUALIZATION
				float4 VizUV : TEXCOORD1;
				float4 LightCoord : TEXCOORD2;
				#endif
			
			
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = 2;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
			}
			
			float3 ColorShift454( float4 ColorMask, float4 ColorShift1, float4 ColorShift2, float4 ColorShift3 )
			{
				#if ( _COLORSHIFT )
				float3 ColorMaskTex = 1 - ColorMask.rgb ;
				float3 ColorShifter = max(ColorShift1.rgb, ColorMaskTex.rrr) * max(ColorShift2.rgb, ColorMaskTex.ggg) * max(ColorShift3.rgb, ColorMaskTex.bbb);
				return ColorShifter;
				#else
				return float3(0, 0, 0);
				#endif
			}
			
			float2 ReturnDetailAlbedo446( float In0 )
			{
				return _DetailAlbedoMap_ST.xy;
			}
			

			v2f vert(appdata v  )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord3.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord4.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord5.xyz = ase_worldBitangent;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				o.ase_texcoord6.xyz = ase_worldPos;
				
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;
				float3 vertexValue = float3(0,0,0);
				v.vertex.xyz += vertexValue;
			
				o.vertex = UnityMetaVertexPosition(v.vertex.xyz, v.uv1.xy, v.uv2.xy);
				//o.uv = TRANSFORM_TEX(v.uv0.xy, _BaseMap);
			
				o.uv = v.uv0.xy;
				#ifdef EDITOR_VISUALIZATION
					float2 vizUV = 0;
					float4 lightCoord = 0;
					UnityEditorVizData(v.vertex.xyz, v.uv0.xy, v.uv1.xy, v.uv2.xy, vizUV, lightCoord);
					o.VizUV = float4(vizUV, 0, 0);
					o.LightCoord = lightCoord;
				#endif
			
			
				return o;
			}

			half4 frag(v2f i  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				float4 uvs4_MainTex = float4(i.uv,0,0);
				uvs4_MainTex.xy = float4(i.uv,0,0).xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float3 ase_worldTangent = i.ase_texcoord3.xyz;
				float3 ase_worldNormal = i.ase_texcoord4.xyz;
				float3 ase_worldBitangent = i.ase_texcoord5.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 ase_worldPos = i.ase_texcoord6.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = normalize(ase_tanViewDir);
				float2 OffsetPOM153 = POM( _ParallaxMap, uvs4_MainTex.xy, ddx(uvs4_MainTex.xy), ddy(uvs4_MainTex.xy), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, ( _Parallax * -1.0 ), 0, _ParallaxMap_ST.xy, float2(0,0), 0 );
				float2 UV_Main492 = OffsetPOM153;
				float4 tex2DNode9 = tex2D( _MainTex, UV_Main492 );
				float4 color297 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				#ifdef _VERTEXTINT_ON
				float4 staticSwitch296 = i.ase_color;
				#else
				float4 staticSwitch296 = color297;
				#endif
				float4 temp_output_178_0 = ( tex2DNode9 * _Color * staticSwitch296 );
				float4 tex2DNode282 = tex2D( _ColorMask, UV_Main492 );
				float4 ColorMask454 = tex2DNode282;
				float4 ColorShift1454 = _ColorShift1;
				float4 ColorShift2454 = _ColorShift2;
				float4 ColorShift3454 = _ColorShift3;
				float3 localColorShift454 = ColorShift454( ColorMask454 , ColorShift1454 , ColorShift2454 , ColorShift3454 );
				float3 ColorMask473 = localColorShift454;
				#ifdef _COLORSHIFT
				float4 staticSwitch293 = ( temp_output_178_0 * float4( ColorMask473 , 0.0 ) );
				#else
				float4 staticSwitch293 = temp_output_178_0;
				#endif
				float4 ColorMaskAlbedo501 = staticSwitch293;
				float In0446 = 0.0;
				float2 localReturnDetailAlbedo446 = ReturnDetailAlbedo446( In0446 );
				float4 uvs4_DetailAlbedoMap = float4(i.uv,0,0);
				uvs4_DetailAlbedoMap.xy = float4(i.uv,0,0).xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
				float4 DetailAlbedoUV499 = ( ( ( float4( OffsetPOM153, 0.0 , 0.0 ) - uvs4_MainTex ) * float4( localReturnDetailAlbedo446, 0.0 , 0.0 ) ) + uvs4_DetailAlbedoMap );
				float temp_output_9_0_g135 = tex2D( _DetailMask, DetailAlbedoUV499.xy ).r;
				float temp_output_18_0_g135 = ( 1.0 - temp_output_9_0_g135 );
				float3 appendResult16_g135 = (float3(temp_output_18_0_g135 , temp_output_18_0_g135 , temp_output_18_0_g135));
				#ifdef _HMMMDETAIL_ON
				float4 staticSwitch199 = float4( ( ColorMaskAlbedo501.rgb * ( ( ( tex2D( _DetailAlbedoMap, DetailAlbedoUV499.xy ).rgb * (unity_ColorSpaceDouble).rgb ) * temp_output_9_0_g135 ) + appendResult16_g135 ) ) , 0.0 );
				#else
				float4 staticSwitch199 = staticSwitch293;
				#endif
				float4 AlbedoDetails488 = staticSwitch199;
				
				#ifdef _EMITALBEDO_ON
				float4 staticSwitch391 = staticSwitch293;
				#else
				float4 staticSwitch391 = float4(1,1,1,1);
				#endif
				float4 temp_output_249_0 = ( tex2D( _EmissionMap, UV_Main492 ) * _EmissionColor * staticSwitch391 );
				float dotResult3_g134 = dot( ase_worldViewDir , ase_worldNormal );
				float4 Emission484 = ( temp_output_249_0 * saturate( pow( abs( dotResult3_g134 ) , _EmissionFalloff ) ) );
				
				float4 BakedEmission482 = ( temp_output_249_0 * _BakedMutiplier );
				
				#ifdef VERTEXILLUMINATION_ON
				float staticSwitch305 = i.ase_color.a;
				#else
				float staticSwitch305 = 0.0;
				#endif
				

				MetaInput metaInput = (MetaInput)0;
			
				float2 uv_main = i.uv;
			
				//half4 albedo = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv) * _BaseColor;
				//metaInput.Albedo = albedo.rgb;
			
			
				///half4 emission = half4(0, 0, 0, 0);
			
			// Begin Injection EMISSION from Injection_Emission_Meta.hlsl ----------------------------------------------------------
				//if (_Emission)
				//{
					//half4 emissionDefault = _EmissionColor * SAMPLE_TEXTURE2D(_EmissionMap, sampler_BaseMap, i.uv);
					//emissionDefault.rgb *= _BakedMutiplier * _Emission;
					//emissionDefault.rgb *= lerp(albedo.rgb, half3(1, 1, 1), emissionDefault.a);
					//emission += emissionDefault;
				//}
			// End Injection EMISSION from Injection_Emission_Meta.hlsl ----------------------------------------------------------
			
				//metaInput.Emission = emission.rgb;
			
				metaInput.Albedo = AlbedoDetails488.rgb;
				half3 emission = Emission484.rgb;
				half3 bakedemission = BakedEmission482.rgb;
				metaInput.Emission = bakedemission.rgb;
				#ifdef EDITOR_VISUALIZATION
					metaInput.VizUV = i.VizUV.xy;
					metaInput.LightCoord = i.LightCoord;
				#endif
			
				half alpha = ( ( _Cull * 0.0 ) + ( staticSwitch305 + ( tex2DNode9.a * _Color.a ) ) );
				half alphaclip = _Cutoff;
				half alphaclipthresholdshadow = half(0);
				#if defined(_ALPHATEST_ON)
					clip(alpha - alphaclip);
				#endif
				return MetaFragment(metaInput);
			}
			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			ENDHLSL
		}

		/*ase_pass*/
		Pass
		{
			
			
			Name "BakedRaytrace"
			Tags{ "LightMode" = "BakedRaytrace" }
			HLSLPROGRAM
			/*ase_pragma_before*/
			#pragma multi_compile _ _EMISSION_ON
			//StandardBakedRT------------------------------------------------------------------------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//
			//
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
					
					
			#define SHADERPASS SHADERPASS_RAYTRACE
					
			#include "UnityRaytracingMeshUtils.cginc"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
					
			/*ase_pragma*/
					
			#pragma raytracing BakeHit
					
			struct RayPayload
			{
			    float4 color;
				float3 dir;
			};
			
			struct AttributeData
			{
			    float2 barycentrics;
			};
			
			struct Vertex
			{
			    float2 texcoord;
			    float3 normal;
			};
			
			// Begin Injection UNIFORMS from Injection_Emission_BakedRT.hlsl ----------------------------------------------------------
			//Texture2D<float4> _BaseMap;
			//SamplerState sampler_BaseMap;
			//Texture2D<float4> _EmissionMap;
			//SamplerState sampler_EmissionMap;
			// End Injection UNIFORMS from Injection_Emission_BakedRT.hlsl ----------------------------------------------------------
			
			CBUFFER_START( UnityPerMaterial )
				/*ase_srp_batcher*/
				//float4 _BaseMap_ST;
				//half4 _BaseColor;
			// Begin Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			//float4 _DetailMap_ST;
			//half  _Details;
			//half  _Normals;
			// End Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
				float _SSRTemporalMul;
			// End Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//half  _Emission;
				//half4 _EmissionColor;
				//half  _EmissionFalloff;
				//half  _BakedMutiplier;
			// End Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//int _AlphaPreMult;
			CBUFFER_END
			/*ase_globals*/
			
			/*ase_funcs*/
			
			
			//https://coty.tips/raytracing-in-unity/
			[shader("closesthit")]
			void MyClosestHit(inout RayPayload payload, AttributeData attributes : SV_IntersectionAttributes) {
			
				payload.color = float4(0,0,0,1); //Intializing
				payload.dir = float3(1,0,0);
			
			// Begin Injection CLOSEST_HIT from Injection_Emission_BakedRT.hlsl ----------------------------------------------------------
			uint2 launchIdx = DispatchRaysIndex();
			
			uint primitiveIndex = PrimitiveIndex();
			uint3 triangleIndicies = UnityRayTracingFetchTriangleIndices(primitiveIndex);
			Vertex v0, v1, v2;
			
			v0.texcoord = UnityRayTracingFetchVertexAttribute2(triangleIndicies.x, kVertexAttributeTexCoord0);
			v1.texcoord = UnityRayTracingFetchVertexAttribute2(triangleIndicies.y, kVertexAttributeTexCoord0);
			v2.texcoord = UnityRayTracingFetchVertexAttribute2(triangleIndicies.z, kVertexAttributeTexCoord0);
			
			// v0.normal = UnityRayTracingFetchVertexAttribute3(triangleIndicies.x, kVertexAttributeNormal);
			// v1.normal = UnityRayTracingFetchVertexAttribute3(triangleIndicies.y, kVertexAttributeNormal);
			// v2.normal = UnityRayTracingFetchVertexAttribute3(triangleIndicies.z, kVertexAttributeNormal);
			
			float3 barycentrics = float3(1.0 - attributes.barycentrics.x - attributes.barycentrics.y, attributes.barycentrics.x, attributes.barycentrics.y);
			
			Vertex vInterpolated;
			vInterpolated.texcoord = v0.texcoord * barycentrics.x + v1.texcoord * barycentrics.y + v2.texcoord * barycentrics.z;
			//TODO: Extract normal direction to ignore the backside of emissive objects
			//vInterpolated.normal = v0.normal * barycentrics.x + v1.normal * barycentrics.y + v2.normal * barycentrics.z;
			// if ( dot(vInterpolated.normal, float3(1,0,0) < 0) ) payload.color =  float4(0,10,0,1) ;
			// else payload.color =  float4(10,0,0,1) ;
			
			
			//float4 albedo = float4(_BaseMap.SampleLevel(sampler_BaseMap, vInterpolated.texcoord.xy * _BaseMap_ST.xy + _BaseMap_ST.zw, 0).rgb, 1) * _BaseColor;
			
			//float4 emission = _Emission * _EmissionMap.SampleLevel(sampler_EmissionMap, vInterpolated.texcoord * _BaseMap_ST.xy + _BaseMap_ST.zw, 0) * _EmissionColor;
			
			half3 albedo = /*ase_frag_out:Albedo;Float3;_Albedo*/half3(0.5, 0.5, 0.5)/*end*/;
			half3 emission = /*ase_frag_out:Emission;Float3;_Emission*/half3(0,0,0)/*end*/;
			half3 baked_emission = /*ase_frag_out:Baked Emission;Float3;_EmissionBaked*/emission/*end*/;
			//emission.rgb *= lerp(albedo.rgb, 1, emission.a);
			
			//payload.color.rgb = emission.rgb * _BakedMutiplier;
			// End Injection CLOSEST_HIT from Injection_Emission_BakedRT.hlsl ----------------------------------------------------------
			payload.color.rgb = baked_emission.rgb;
			}
			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			ENDHLSL
		}
		
	}
	/*ase_lod*/

	CustomEditor "UnityEditor.ShaderGraphLitGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=18800
402;73;995;564;2998.168;1050.219;2.310779;True;True
Node;AmplifyShaderEditor.CommentaryNode;209;-3154.088,590.5229;Inherit;False;1291.838;1340.76;;10;165;148;155;120;153;164;154;434;446;492;Height Map;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-2734.739,1011.063;Inherit;False;Property;_Parallax;Height Scale;13;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;148;-2765.333,1270.258;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;434;-2493.347,672.8641;Inherit;False;0;9;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;154;-2800.55,788.4324;Inherit;True;Property;_ParallaxMap;Height Map;12;2;[Header];[NoScaleOffset];Create;False;1;Parallax;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;155;-2434.335,1007.85;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxOcclusionMappingNode;153;-2232.636,779.4778;Inherit;False;0;8;False;-1;16;False;-1;2;0.02;0;False;1,1;False;0,0;8;0;FLOAT2;0,0;False;1;SAMPLER2D;;False;7;SAMPLERSTATE;;False;2;FLOAT;0.02;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT2;0,0;False;6;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;492;-1933.1,736.5001;Inherit;False;UV_Main;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;292;-3155.025,-2907.068;Inherit;False;1151.364;1015.291;;9;285;282;287;289;286;283;281;454;457;Color Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;496;-3278.083,-2578.229;Inherit;False;492;UV_Main;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;283;-2948.931,-2267.301;Float;False;Property;_ColorShift3;_ColorShift3;42;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;285;-2947.629,-2600.101;Float;False;Property;_ColorShift1;_ColorShift1;40;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;281;-2947.631,-2435.001;Float;False;Property;_ColorShift2;_ColorShift2;41;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;205;-3162.78,-1267.459;Inherit;False;1103.113;591.1926;;7;178;9;12;296;295;297;494;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;282;-2948.264,-2809.055;Inherit;True;Property;_ColorMask;Color Tint;39;2;[Header];[NoScaleOffset];Create;False;1;Color Mask;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;494;-3126.903,-1054.101;Inherit;False;492;UV_Main;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;297;-2865.294,-844.5146;Inherit;False;Constant;_Color1;color;5;0;Create;False;0;0;0;False;0;False;1,1,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;295;-2609.446,-858.4081;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;454;-2247.812,-2564.459;Inherit;False;#if ( _COLORSHIFT )$float3 ColorMaskTex = 1 - ColorMask.rgb @$float3 ColorShifter = max(ColorShift1.rgb, ColorMaskTex.rrr) * max(ColorShift2.rgb, ColorMaskTex.ggg) * max(ColorShift3.rgb, ColorMaskTex.bbb)@$return ColorShifter@$#else$return float3(0, 0, 0)@$#endif;3;False;4;True;ColorMask;FLOAT4;0,0,0,0;In;;Inherit;False;True;ColorShift1;FLOAT4;0,0,0,0;In;;Inherit;False;True;ColorShift2;FLOAT4;0,0,0,0;In;;Inherit;False;True;ColorShift3;FLOAT4;0,0,0,0;In;;Inherit;False;Color Shift;True;False;0;4;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;9;-2823.493,-1225.229;Inherit;True;Property;_MainTex;Main Tex;2;0;Create;True;0;0;0;False;0;False;-1;None;f0693289b36b5b44fb158e274831235f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;446;-2013.158,1122.034;Inherit;False;return _DetailAlbedoMap_ST.xy@;2;False;1;True;In0;FLOAT;0;In;;Inherit;False;ReturnDetailAlbedo;True;False;0;1;0;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;12;-2605.528,-1040.802;Inherit;False;Property;_Color;Main Color;3;0;Create;False;0;0;0;False;0;False;1,1,1,0;1,1,1,0.6313726;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;473;-1991.761,-2558.163;Inherit;False;ColorMask;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;296;-2315.782,-898.0261;Inherit;False;Property;_VertexTint;Vertex Tint;43;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;444;-1970.32,978.302;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;474;-1699.859,-734.1887;Inherit;False;473;ColorMask;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;445;-1817.235,1084.338;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;164;-2510.268,1124.199;Inherit;False;0;165;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;178;-2194.929,-1186.395;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;447;-1618.495,1133.725;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;476;-1424.705,-723.4329;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;294;-1155.531,-916.7139;Inherit;False;272.8773;135.1985;;1;293;Use ColorMask;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;499;-1527.07,1016.261;Inherit;False;DetailAlbedoUV;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;293;-1174.737,-922.4857;Inherit;False;Property;_UseColorMask;Use ColorMask;46;0;Create;False;0;0;0;False;0;False;0;0;0;True;_COLORSHIFT;Toggle;2;Key0;Key1;Create;True;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;204;-975.5339,-2274.037;Inherit;False;1390.087;847.3003;;11;116;110;249;391;392;394;472;436;484;482;493;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;206;464.34,-569.5273;Inherit;False;716.1443;1063.664;;7;100;99;81;179;15;480;500;Detail Maps;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;501;-893.9087,-798.2788;Inherit;False;ColorMaskAlbedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;394;-668.9765,-1617.327;Inherit;False;Constant;_Vector0;Vector 0;44;0;Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;500;454.4299,-94.21191;Inherit;False;499;DetailAlbedoUV;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;493;-955.6061,-2131.239;Inherit;False;492;UV_Main;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;165;-2939.392,1074.75;Inherit;True;Property;_DetailAlbedoMap;Detail Albedo X2;28;0;Create;False;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;15;769.862,-271.0169;Inherit;True;Property;_DetailMask;Detail Mask;23;2;[Header];[NoScaleOffset];Create;True;1;Detail;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;110;-926.0058,-1940.968;Inherit;True;Property;_EmissionMap;Emission Map;14;2;[Header];[NoScaleOffset];Create;True;1;Emission;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;391;-355.7426,-1602.896;Inherit;False;Property;_EmitAlbedo;Emit Albedo;19;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;502;510.7967,-611.6404;Inherit;True;501;ColorMaskAlbedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;116;-872.9279,-1725.9;Inherit;False;Property;_EmissionColor;Emission Color;17;1;[HDR];Create;True;0;0;0;True;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;81;766.9305,-69.22673;Inherit;True;Property;_DetailAlbedoMapp;Detail Albedo X2;14;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;179;809.2394,-419.44;Inherit;False;Detail Albedo;24;;135;29e5a290b15a7884983e27c8f1afaa8c;0;3;12;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;9;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;436;-376.3258,-1509.103;Inherit;False;Property;_BakedMutiplier;Emission Baked Multiplier;18;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;211;-1597.859,-51.86446;Inherit;False;1223.75;733.5038;;10;21;157;170;23;26;465;464;467;469;470;Metallic/MAS/RMA;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;472;-110.2606,-1876.451;Inherit;False;Emission Falloff;15;;134;3a5dde37e3e68544cae9547efecae79c;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;249;-132.2633,-1743.51;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;212;-1186.497,-694.4531;Inherit;False;396.3319;441.0793;;1;199;Use Detail?;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;306;-1692.667,-375.6542;Inherit;False;Constant;_Float3;Float 3;38;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;469;-1202.868,492.9542;Inherit;False;Property;_Cull;cull;50;1;[HideInInspector];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;199;-1107.838,-601.0787;Inherit;False;Property;_hmmmdetail;hmmm detail?;22;0;Create;True;0;0;0;False;0;False;0;1;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;435;-148.5945,-1524.25;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;305;-1448.92,-321.1237;Inherit;False;Property;VertexIllumination;VertexIllumination;44;0;Create;False;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;392;119.5364,-1674.651;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;503;-1180.263,-239.6287;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;484;221.7563,-1534.88;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;208;-3759.321,-350.0678;Inherit;False;1061.394;516.7698;;5;73;72;70;477;495;Normal Map;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;203;-1701.365,-5035.179;Inherit;False;1894.306;888.598;;8;183;184;186;187;190;185;189;188;Fluorescence;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;213;389.208,-1065.896;Inherit;False;309;190;;1;181;BRDF;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;210;-1299.77,1318.596;Inherit;False;939.1121;659.9141;;2;27;498;Occlusion;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;85;-320.736,714.5835;Inherit;False;837.3777;312.6591;;4;172;82;468;300;Occlusion Switch;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;470;-1007.79,473.8737;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;482;12.827,-1502.345;Inherit;False;BakedEmission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;488;-888.4023,-590.2401;Inherit;False;AlbedoDetails;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;307;-580.1635,-123.0403;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;477;-2901.41,-223.1111;Inherit;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StickyNoteNode;459;222.0083,1304.823;Inherit;False;150;100;Credit to Evro;;1,1,1,1;;0;0
Node;AmplifyShaderEditor.RangedFloatNode;163;-42.0144,349.5994;Inherit;False;Property;_Cutoff;Alpha Clipping;1;0;Create;False;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;460;-139.3573,1126.209;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;298;-3.463843,806.1526;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;468;362.5499,788.8353;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;471;-113.6479,270.5881;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;172;148.5029,925.1698;Inherit;False;Property;_OcclusionStrength;_OcclusionStrength;31;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;489;-117.0102,-105.1084;Inherit;False;488;AlbedoDetails;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;485;-103.4956,-42.45569;Inherit;False;484;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;185;-524.3834,-4440.48;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;483;-121.3346,28.26952;Inherit;False;482;BakedEmission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;302;-458.926,776.6791;Inherit;False;Constant;_Float2;Float 2;37;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;515.1421,289.3925;Inherit;False;Property;_DetailNormalMapScale;Detail Normal Scale;30;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;425;-1949.795,-19.73352;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;495;-3325.134,-205.3512;Inherit;False;492;UV_Main;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;82;-279.6406,778.673;Inherit;False;Property;_UseOcclusion;Use Occlusion;21;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;498;-1236.729,1492.121;Inherit;False;492;UV_Main;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;481;-321.0389,1158.995;Inherit;False;480;DetailNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;190;-40.2145,-4356.368;Inherit;False;Property;_Absorbance;Absorbance;38;0;Create;True;0;0;0;False;0;False;0.5882353,0.7843137,0.8666667,0;0.09999994,0.25,0.5,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;487;-91.0712,-171.5394;Inherit;False;486;Normals;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;491;-96.22797,105.1589;Inherit;False;490;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;300;-277.1963,893.3211;Inherit;False;Property;_VertexOcclusion;Vertex Occlusion;45;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;324;-169.7838,1380.89;Inherit;False;Property;_NormalToOcclusion;Normal To Occlusion;6;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1209.736,116.2378;Inherit;False;Property;_Glossiness;Smoothnes;10;0;Create;False;0;0;0;False;0;False;1;0.89;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;287;-2575.281,-2384.065;Inherit;False;3;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;21;-1497.572,173.5851;Inherit;True;Property;_MetallicGlossMap;Metallic Map;8;1;[NoScaleOffset];Create;False;0;0;0;False;0;False;-1;bfeb91aff4ad47443a4ab34d16f4ff0a;facd2e643248fb64d8f1ed994d6e9ce9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;497;-1709.817,227.816;Inherit;False;492;UV_Main;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;88.93304,1126;Inherit;False;Normals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;289;-2588.824,-2537.492;Inherit;False;3;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;480;963.9174,418.9401;Inherit;False;DetailNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StickyNoteNode;308;2217.018,-876.5578;Inherit;False;172.2473;100;Made by;shortstakxxx@gmail.com ;1,1,1,1;;0;0
Node;AmplifyShaderEditor.CustomExpressionNode;504;-2299.861,-407.8489;Inherit;False;#ifdef UNITY_PASS_FORWARDBASE$    // Check if the keyword _SURFACE_TYPE_TRANSPARENT is defined$    #if defined(_SURFACE_TYPE_TRANSPARENT)$        // Set up for Transparent mode$        Tags { "RenderType" = "Transparent" }$        Blend SrcAlpha OneMinusSrcAlpha$        ZWrite Off$        // Disable backface culling for transparency if needed$        Cull Off$    #else$        // Set up for Opaque mode$        Tags { "RenderType" = "Opaque" }$        Blend One Zero$        ZWrite On$        Cull Back$    #endif$#endif$;1;False;1;True;_SURFACE_TYPE_TRANSPARENT;FLOAT;0;In;;Inherit;False;My Custom Expression;True;False;0;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;374;1479.491,-4407.201;Float;False;Global;globalScreenScaler;globalScreenScaler;15;0;Create;True;0;0;0;False;0;False;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;490;372.0649,749.9076;Inherit;False;Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;478;-322.9422,1215.235;Inherit;False;477;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;183;-1007.251,-4922.509;Inherit;True;Property;_FluoresenceMap;Fluoresence Map;36;2;[Header];[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;99;781.5314,137.8232;Inherit;True;Property;_DetailNormalMap;Detail Normal;29;1;[NoScaleOffset];Create;False;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;70;-3040.937,-122.3313;Inherit;True;Property;_BumpMap;Normal Map;4;1;[NoScaleOffset];Create;False;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;188;-235.9603,-4653.013;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;363;475.9205,-4725.899;Inherit;True;Property;_CubeBG;CubeBG;47;1;[Header];Create;True;1;Holographic Wall;0;0;False;0;False;-1;None;None;True;0;False;black;LockedToCube;False;Object;-1;MipLevel;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;184;-1039.949,-4450.524;Inherit;False;Property;_Intensity;Intensity;37;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;367;1119.757,-4519.908;Inherit;True;Property;_EmissionMask;Emission Mask;49;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;458;-189.062,1281.882;Inherit;False;float2 normalABS =  abs(vNormalTs.xy * vNormalTs.xy) @$return lerp(1,   (1 - (normalABS.x + normalABS.y) ) * (vNormalTs.z ), NormalToOcclusion)@;1;False;2;True;vNormalTs;FLOAT3;0,0,0;In;;Inherit;False;True;NormalToOcclusion;FLOAT;0;In;;Inherit;False;Normal to Occlusion;True;False;0;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-3567.229,-65.336;Inherit;False;Property;_BumpScale;Normal Scale;5;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;186;-1043.968,-4667.94;Inherit;False;Property;_FluoresenceTint;Fluoresence Tint;35;1;[Header];Create;True;1;Fluoresence;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;467;-670.4387,339.6627;Inherit;False;Property;_Specmod;Smoothness Scale;11;0;Create;False;0;0;0;False;0;False;1;1.035;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;181;411.0699,-1003.488;Inherit;False;BRDFMap;32;;136;1affaac2d6e57354aaa8d6573a2b32b8;0;1;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;189;-722.5849,-4377.072;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;27;-992.9797,1505.002;Inherit;True;Property;_OcclusionMap;Occlusion Map;20;2;[Header];[NoScaleOffset];Create;True;1;Occlusion;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;157;-1192.338,332.418;Inherit;False;Property;_MetallicType;Metallic Type;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;4;MAS;MetallicSmoothness;RMA;MASK;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;73;-3251.922,-80.03079;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;187;-586.8293,-4785.235;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode;464;-917.3185,151.0355;Inherit;False; #if (_METALLICTYPE_MAS)$return MetallicMap@$#elif (_METALLICTYPE_RMA)$return float4(MetallicMap.g, MetallicMap.b, (1 - MetallicMap.r), 0)@$#elif (_METALLICTYPE_MAES)$return MetallicMap.rgab@$#elif (_METALLICTYPE_FLOATS)$return float4(Metallic, 1, Smoothness, 0)@$#else$return float4(MetallicMap.r, 1, MetallicMap.a, 0)@$#endif;4;False;4;False;MetallicMap;FLOAT4;0,0,0,0;In;;Inherit;False;True;Metallic;FLOAT;0;In;;Inherit;False;True;Smoothness;FLOAT;0;In;;Inherit;False;True;LuhAcceptor;FLOAT;0;In;;Inherit;False;ChannelPacker;True;False;0;4;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;457;-2276.186,-2367.737;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1213.853,43.15961;Inherit;False;Property;_Metallic;Metallic;9;0;Create;True;0;0;0;False;0;False;1;0.991;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;170;-1334.972,11.95669;Inherit;False;Constant;_Float1;Float 1;19;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;286;-2579.731,-2264.701;Inherit;False;3;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;366;678.7845,-4266.075;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;466;-482.4113,224.2823;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;465;-632.1284,155.709;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;362;534.0555,-4505.396;Float;False;Property;_ScreenColor;ScreenColor;48;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;506;-2040.877,-307.7174;Inherit;False;Property;_SurfaceType;Surface Type;0;0;Create;True;0;0;0;False;0;False;0;0;0;True;_SURFACE_TYPE_TRANSPARENT;Toggle;2;Key0;Key1;Create;True;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;400;113.2767,-59.96434;Float;False;True;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;Valve/VRStandard Transparent V3;623634af11bd9ab448550ee777f3493e;True;Forward;0;0;Forward;14;True;1;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;True;469;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;3;False;-1;True;True;1;False;-1;1;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;True;1;Lightmode=UniversalForward;True;7;0;Hidden/InternalErrorShader;0;0;Standard;24;Workflow;1;Surface;2;Two Sided;1;Cast Shadows;1;  Use Shadow Threshold;0;GPU Instancing;0;Built-in Fog;1;Lightmaps;1;Volumetrics;1;Decals;0;Write Depth;0;  Early Z (broken);0;Vertex Position,InvertActionOnDeselection;1;Emission;1;PC Reflection Probe;3;PC Receive Shadows;1;PC Vertex Lights;0;PC SSAO;1;Q Reflection Probe;0;Q Receive Shadows;0;Q Vertex Lights;1;Q SSAO;0;Environment Reflections;1;Meta Pass;1;0;5;True;True;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;404;113.2767,-59.96434;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;Meta;0;4;Meta;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;0;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;401;113.2767,-59.96434;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;DepthOnly;0;1;DepthOnly;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;0;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;True;1;Lightmode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;402;113.2767,-59.96434;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;DepthNormals;0;2;DepthNormals;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;Lightmode=DepthNormals;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;403;113.2767,-59.96434;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;ShadowCaster;0;3;ShadowCaster;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;0;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
WireConnection;155;0;120;0
WireConnection;153;0;434;0
WireConnection;153;1;154;0
WireConnection;153;7;154;1
WireConnection;153;2;155;0
WireConnection;153;3;148;0
WireConnection;492;0;153;0
WireConnection;282;1;496;0
WireConnection;454;0;282;0
WireConnection;454;1;285;0
WireConnection;454;2;281;0
WireConnection;454;3;283;0
WireConnection;9;1;494;0
WireConnection;473;0;454;0
WireConnection;296;1;297;0
WireConnection;296;0;295;0
WireConnection;444;0;153;0
WireConnection;444;1;434;0
WireConnection;445;0;444;0
WireConnection;445;1;446;0
WireConnection;178;0;9;0
WireConnection;178;1;12;0
WireConnection;178;2;296;0
WireConnection;447;0;445;0
WireConnection;447;1;164;0
WireConnection;476;0;178;0
WireConnection;476;1;474;0
WireConnection;499;0;447;0
WireConnection;293;1;178;0
WireConnection;293;0;476;0
WireConnection;501;0;293;0
WireConnection;15;1;500;0
WireConnection;110;1;493;0
WireConnection;391;1;394;0
WireConnection;391;0;293;0
WireConnection;81;0;165;0
WireConnection;81;1;500;0
WireConnection;179;12;502;0
WireConnection;179;11;81;0
WireConnection;179;9;15;0
WireConnection;249;0;110;0
WireConnection;249;1;116;0
WireConnection;249;2;391;0
WireConnection;199;1;293;0
WireConnection;199;0;179;0
WireConnection;435;0;249;0
WireConnection;435;1;436;0
WireConnection;305;1;306;0
WireConnection;305;0;295;4
WireConnection;392;0;249;0
WireConnection;392;1;472;0
WireConnection;503;0;9;4
WireConnection;503;1;12;4
WireConnection;484;0;392;0
WireConnection;470;0;469;0
WireConnection;482;0;435;0
WireConnection;488;0;199;0
WireConnection;307;0;305;0
WireConnection;307;1;503;0
WireConnection;477;0;70;0
WireConnection;460;0;481;0
WireConnection;460;1;478;0
WireConnection;298;0;300;0
WireConnection;298;1;82;0
WireConnection;298;2;458;0
WireConnection;468;1;298;0
WireConnection;468;2;172;0
WireConnection;471;0;470;0
WireConnection;471;1;307;0
WireConnection;185;0;183;0
WireConnection;185;1;186;0
WireConnection;185;2;189;0
WireConnection;425;0;295;1
WireConnection;82;1;465;1
WireConnection;82;0;27;2
WireConnection;300;1;302;0
WireConnection;300;0;425;0
WireConnection;287;1;281;0
WireConnection;287;2;282;2
WireConnection;21;1;497;0
WireConnection;486;0;460;0
WireConnection;289;1;285;0
WireConnection;289;2;282;1
WireConnection;480;0;99;0
WireConnection;490;0;468;0
WireConnection;99;1;500;0
WireConnection;99;5;100;0
WireConnection;70;1;495;0
WireConnection;70;5;73;0
WireConnection;188;0;185;0
WireConnection;188;2;187;0
WireConnection;458;0;460;0
WireConnection;458;1;324;0
WireConnection;189;2;184;0
WireConnection;27;1;498;0
WireConnection;73;0;72;0
WireConnection;187;0;184;0
WireConnection;187;1;183;0
WireConnection;464;0;21;0
WireConnection;464;1;23;0
WireConnection;464;2;26;0
WireConnection;464;3;157;0
WireConnection;457;0;282;0
WireConnection;457;1;289;0
WireConnection;457;2;287;0
WireConnection;457;3;286;0
WireConnection;286;1;283;0
WireConnection;286;2;282;3
WireConnection;466;0;465;2
WireConnection;466;1;467;0
WireConnection;465;0;464;0
WireConnection;506;1;504;0
WireConnection;506;0;504;0
WireConnection;400;0;489;0
WireConnection;400;1;487;0
WireConnection;400;2;485;0
WireConnection;400;3;483;0
WireConnection;400;4;465;0
WireConnection;400;6;466;0
WireConnection;400;7;491;0
WireConnection;400;8;471;0
WireConnection;400;9;163;0
ASEEND*/
//CHKSM=7493B62FD95FEA4801300A5FC558CF3A5A141D77