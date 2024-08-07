// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
// Force reimport: 2
Shader "Valve/VRStandard"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[ASEBegin]_Cutoff("Alpha Clipping", Range( 0 , 1)) = 0.5
		_MainTex("Main Tex", 2D) = "white" {}
		_Color("Main Color", Color) = (1,1,1,0)
		_BumpMap("Normal Map", 2D) = "bump" {}
		_BumpScale("Normal Scale", Range( 0 , 1)) = 1
		[KeywordEnum(MAS,MetallicSmoothness,RMA,MASK)] _MetallicType("Metallic Type", Float) = 0
		_MetallicGlossMap("Metallic Map", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 1
		_Glossiness("Smoothnes", Range( 0 , 1.5)) = 1
		[Header(Parallax)]_ParallaxMap("Height Map", 2D) = "white" {}
		_Parallax("Height Scale", Float) = 0
		[Header(Emission)]_EmissionMap("Emission Map", 2D) = "white" {}
		_EmissionFalloff("Emission Falloff", Float) = 0
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		[Toggle(_EMITALBEDO_ON)] _EmitAlbedo("Emit Albedo", Float) = 0
		[Header(Occlusion)]_OcclusionMap("Occlusion Map", 2D) = "white" {}
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
		_ColorShift4("_ColorShift4", Color) = (1,1,1,1)
		[Toggle(_VERTEXTINT_ON)] _VertexTint("Vertex Tint", Float) = 0
		[Toggle(VERTEXILLUMINATION_ON)] VertexIllumination("VertexIllumination", Float) = 0
		[Toggle(_VERTEXOCCLUSION_ON)] _VertexOcclusion("Vertex Occlusion", Float) = 0
		[ASEEnd][Toggle(_USECOLORMASK_ON)] _UseColorMask("Use ColorMask", Float) = 0

		[Space(30)][Header(Screen Space Reflections)][Space(10)][Toggle(_NO_SSR)] _SSROff("Disable SSR", Float) = 0
		[Header(This should be 0 for skinned meshes)]
		_SSRTemporalMul("Temporal Accumulation Factor", Range(0, 2)) = 1.0
		//[Toggle(_SM6_QUAD)] _SM6_Quad("Quad-avg SSR", Float) = 0


	}
	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		
		Blend One Zero
		ZWrite On
		Cull Back
		ZTest LEqual
		Offset 0 , 0
		ColorMask RGBA
		//LOD 100
		

		
		Pass
		{

			

			Name "Forward"
			Tags { "Lightmode"="UniversalForward" }
			
			HLSLPROGRAM
			#define _SurfaceOpaque
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
			#pragma shader_feature_local _USECOLORMASK_ON
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
				float4 _ParallaxMap_ST;
				float4 _Color;
				float4 _ColorShift1;
				float4 _ColorShift2;
				float4 _ColorShift3;
				float4 _ColorShift4;
				float4 _DetailAlbedoMap_ST;
				float4 _EmissionColor;
				float _Parallax;
				float _DetailNormalMapScale;
				float _BumpScale;
				float _EmissionFalloff;
				float _Metallic;
				float _Glossiness;
				float _OcclusionStrength;
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
				float2 uv_ParallaxMap = i.uv0XY_bitZ_fog.xy * _ParallaxMap_ST.xy + _ParallaxMap_ST.zw;
				float temp_output_155_0 = ( _Parallax * -1.0 );
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
				float2 OffsetPOM153 = POM( _ParallaxMap, uv_ParallaxMap, ddx(uv_ParallaxMap), ddy(uv_ParallaxMap), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, temp_output_155_0, 0, _ParallaxMap_ST.xy, float2(0,0), 0 );
				float4 tex2DNode9 = tex2D( _MainTex, OffsetPOM153 );
				float4 color297 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				#ifdef _VERTEXTINT_ON
				float4 staticSwitch296 = i.ase_color;
				#else
				float4 staticSwitch296 = color297;
				#endif
				float2 texCoord290 = i.uv0XY_bitZ_fog.xy * float2( 1,1 ) + float2( 0,0 );
				float4 tex2DNode282 = tex2D( _ColorMask, texCoord290 );
				float4 lerpResult289 = lerp( float4( 1,1,1,1 ) , _ColorShift1 , tex2DNode282.r);
				float4 lerpResult287 = lerp( float4( 1,1,1,1 ) , _ColorShift2 , tex2DNode282.g);
				float4 lerpResult286 = lerp( float4( 1,1,1,1 ) , _ColorShift3 , tex2DNode282.b);
				float4 lerpResult288 = lerp( float4( 1,1,1,1 ) , _ColorShift4 , tex2DNode282.a);
				#ifdef _USECOLORMASK_ON
				float4 staticSwitch293 = ( lerpResult289 * lerpResult287 * lerpResult286 * lerpResult288 );
				#else
				float4 staticSwitch293 = ( tex2DNode9 * _Color * staticSwitch296 );
				#endif
				float2 uv_DetailAlbedoMap = i.uv0XY_bitZ_fog.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
				float2 OffsetPOM398 = POM( _DetailAlbedoMap, uv_DetailAlbedoMap, ddx(uv_DetailAlbedoMap), ddy(uv_DetailAlbedoMap), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, temp_output_155_0, 0, _DetailAlbedoMap_ST.xy, float2(0,0), 0 );
				float temp_output_9_0_g94 = tex2D( _DetailMask, OffsetPOM398 ).r;
				float temp_output_18_0_g94 = ( 1.0 - temp_output_9_0_g94 );
				float3 appendResult16_g94 = (float3(temp_output_18_0_g94 , temp_output_18_0_g94 , temp_output_18_0_g94));
				#ifdef _HMMMDETAIL_ON
				float4 staticSwitch199 = float4( ( staticSwitch293.rgb * ( ( ( tex2D( _DetailAlbedoMap, OffsetPOM398 ).rgb * (unity_ColorSpaceDouble).rgb ) * temp_output_9_0_g94 ) + appendResult16_g94 ) ) , 0.0 );
				#else
				float4 staticSwitch199 = staticSwitch293;
				#endif
				
				float3 unpack99 = UnpackNormalScale( tex2D( _DetailNormalMap, OffsetPOM398 ), _DetailNormalMapScale );
				unpack99.z = lerp( 1, unpack99.z, saturate(_DetailNormalMapScale) );
				float clampResult73 = clamp( _BumpScale , 0.0 , 1.0 );
				float3 unpack70 = UnpackNormalScale( tex2D( _BumpMap, OffsetPOM153 ), clampResult73 );
				unpack70.z = lerp( 1, unpack70.z, saturate(clampResult73) );
				float3 tex2DNode70 = unpack70;
				
				#ifdef _EMITALBEDO_ON
				float4 staticSwitch391 = staticSwitch293;
				#else
				float4 staticSwitch391 = float4(1,1,1,1);
				#endif
				float4 temp_output_249_0 = ( tex2D( _EmissionMap, OffsetPOM153 ) * _EmissionColor * staticSwitch391 );
				float dotResult276 = dot( ase_worldViewDir , ase_worldNormal );
				
				float4 tex2DNode21 = tex2D( _MetallicGlossMap, OffsetPOM153 );
				#if defined(_METALLICTYPE_MAS)
				float staticSwitch177 = tex2DNode21.r;
				#elif defined(_METALLICTYPE_METALLICSMOOTHNESS)
				float staticSwitch177 = tex2DNode21.r;
				#elif defined(_METALLICTYPE_RMA)
				float staticSwitch177 = tex2DNode21.g;
				#elif defined(_METALLICTYPE_MASK)
				float staticSwitch177 = tex2DNode21.r;
				#else
				float staticSwitch177 = tex2DNode21.r;
				#endif
				
				#if defined(_METALLICTYPE_MAS)
				float staticSwitch157 = tex2DNode21.b;
				#elif defined(_METALLICTYPE_METALLICSMOOTHNESS)
				float staticSwitch157 = tex2DNode21.a;
				#elif defined(_METALLICTYPE_RMA)
				float staticSwitch157 = ( 1.0 - tex2DNode21.r );
				#elif defined(_METALLICTYPE_MASK)
				float staticSwitch157 = tex2DNode21.a;
				#else
				float staticSwitch157 = tex2DNode21.b;
				#endif
				
				#ifdef _VERTEXOCCLUSION_ON
				float staticSwitch300 = pow( i.ase_color.r , 2.0 );
				#else
				float staticSwitch300 = 1.0;
				#endif
				#if defined(_METALLICTYPE_MAS)
				float staticSwitch169 = tex2DNode21.g;
				#elif defined(_METALLICTYPE_METALLICSMOOTHNESS)
				float staticSwitch169 = 1.0;
				#elif defined(_METALLICTYPE_RMA)
				float staticSwitch169 = tex2DNode21.b;
				#elif defined(_METALLICTYPE_MASK)
				float staticSwitch169 = tex2DNode21.g;
				#else
				float staticSwitch169 = tex2DNode21.g;
				#endif
				float4 tex2DNode27 = tex2D( _OcclusionMap, OffsetPOM153 );
				#ifdef _USEOCCLUSION_ON
				float staticSwitch82 = (( 1.0 - _OcclusionStrength ) + (tex2DNode27.g - 0.0) * (1.0 - ( 1.0 - _OcclusionStrength )) / (1.0 - 0.0));
				#else
				float staticSwitch82 = staticSwitch169;
				#endif
				float temp_output_298_0 = ( staticSwitch300 * staticSwitch82 );
				
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
			
				half3 albedo3 = staticSwitch199.rgb;
				half3 normalTS = ( unpack99 + tex2DNode70 );
				half3 emission = ( temp_output_249_0 * saturate( pow( abs( dotResult276 ) , ( _EmissionFalloff * 1.0 ) ) ) ).rgb;
				half3 emissionbaked = temp_output_249_0.rgb;
			
			// Begin Injection NORMAL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				//normalMap = SAMPLE_TEXTURE2D(_BumpMap, sampler_BaseMap, uv_main);
				//normalTS = UnpackNormal(normalMap);
				//normalTS = _Normals ? normalTS : half3(0, 0, 1);
				//geoSmooth = _Normals ? normalMap.b : 1.0;
				//smoothness = saturate(smoothness + geoSmooth - 1.0);
			// End Injection NORMAL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				half metallic = ( staticSwitch177 + _Metallic );
				half3 specular = half3(0.5, 0.5, 0.5);
				half smoothness = ( staticSwitch157 * _Glossiness );
				half ao = temp_output_298_0;
				half alpha = ( staticSwitch305 + tex2DNode9.a );
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
			#define _SurfaceOpaque
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
			float4 _ParallaxMap_ST;
			float4 _Color;
			float4 _ColorShift1;
			float4 _ColorShift2;
			float4 _ColorShift3;
			float4 _ColorShift4;
			float4 _DetailAlbedoMap_ST;
			float4 _EmissionColor;
			float _Parallax;
			float _DetailNormalMapScale;
			float _BumpScale;
			float _EmissionFalloff;
			float _Metallic;
			float _Glossiness;
			float _OcclusionStrength;
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
			    o.ase_texcoord.xy = v.ase_texcoord.xy;
			    
			    //setting value to unused interpolator channels and avoid initialization warnings
			    o.ase_texcoord.zw = 0;
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
			    float2 uv_ParallaxMap = i.ase_texcoord.xy * _ParallaxMap_ST.xy + _ParallaxMap_ST.zw;
			    float temp_output_155_0 = ( _Parallax * -1.0 );
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
			    float2 OffsetPOM153 = POM( _ParallaxMap, uv_ParallaxMap, ddx(uv_ParallaxMap), ddy(uv_ParallaxMap), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, temp_output_155_0, 0, _ParallaxMap_ST.xy, float2(0,0), 0 );
			    float4 tex2DNode9 = tex2D( _MainTex, OffsetPOM153 );
			    
			
				half alpha = ( staticSwitch305 + tex2DNode9.a );
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
			#define _SurfaceOpaque
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
				float4 _ParallaxMap_ST;
				float4 _Color;
				float4 _ColorShift1;
				float4 _ColorShift2;
				float4 _ColorShift3;
				float4 _ColorShift4;
				float4 _DetailAlbedoMap_ST;
				float4 _EmissionColor;
				float _Parallax;
				float _DetailNormalMapScale;
				float _BumpScale;
				float _EmissionFalloff;
				float _Metallic;
				float _Glossiness;
				float _OcclusionStrength;
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
			sampler2D _DetailAlbedoMap;
			sampler2D _BumpMap;
			sampler2D _ParallaxMap;
			sampler2D _MainTex;

				
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
			   float2 uv_DetailAlbedoMap = i.uv0.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
			   float temp_output_155_0 = ( _Parallax * -1.0 );
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
			   float2 OffsetPOM398 = POM( _DetailAlbedoMap, uv_DetailAlbedoMap, ddx(uv_DetailAlbedoMap), ddy(uv_DetailAlbedoMap), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, temp_output_155_0, 0, _DetailAlbedoMap_ST.xy, float2(0,0), 0 );
			   float3 unpack99 = UnpackNormalScale( tex2D( _DetailNormalMap, OffsetPOM398 ), _DetailNormalMapScale );
			   unpack99.z = lerp( 1, unpack99.z, saturate(_DetailNormalMapScale) );
			   float2 uv_ParallaxMap = i.uv0.xy * _ParallaxMap_ST.xy + _ParallaxMap_ST.zw;
			   float2 OffsetPOM153 = POM( _ParallaxMap, uv_ParallaxMap, ddx(uv_ParallaxMap), ddy(uv_ParallaxMap), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, temp_output_155_0, 0, _ParallaxMap_ST.xy, float2(0,0), 0 );
			   float clampResult73 = clamp( _BumpScale , 0.0 , 1.0 );
			   float3 unpack70 = UnpackNormalScale( tex2D( _BumpMap, OffsetPOM153 ), clampResult73 );
			   unpack70.z = lerp( 1, unpack70.z, saturate(clampResult73) );
			   float3 tex2DNode70 = unpack70;
			   
			   #ifdef VERTEXILLUMINATION_ON
			   float staticSwitch305 = i.ase_color.a;
			   #else
			   float staticSwitch305 = 0.0;
			   #endif
			   float4 tex2DNode9 = tex2D( _MainTex, OffsetPOM153 );
			   
			
			
			   half4 normals = half4(0, 0, 0, 1);
			   half3 normalTS = ( unpack99 + tex2DNode70 );
			
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
				half alpha = ( staticSwitch305 + tex2DNode9.a );
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
			#define _SurfaceOpaque
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
			float4 _ParallaxMap_ST;
			float4 _Color;
			float4 _ColorShift1;
			float4 _ColorShift2;
			float4 _ColorShift3;
			float4 _ColorShift4;
			float4 _DetailAlbedoMap_ST;
			float4 _EmissionColor;
			float _Parallax;
			float _DetailNormalMapScale;
			float _BumpScale;
			float _EmissionFalloff;
			float _Metallic;
			float _Glossiness;
			float _OcclusionStrength;
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
			    output.ase_texcoord1.xy = input.ase_texcoord.xy;
			    
			    //setting value to unused interpolator channels and avoid initialization warnings
			    output.ase_texcoord1.zw = 0;
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
			    float2 uv_ParallaxMap = input.ase_texcoord1.xy * _ParallaxMap_ST.xy + _ParallaxMap_ST.zw;
			    float temp_output_155_0 = ( _Parallax * -1.0 );
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
			    float2 OffsetPOM153 = POM( _ParallaxMap, uv_ParallaxMap, ddx(uv_ParallaxMap), ddy(uv_ParallaxMap), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, temp_output_155_0, 0, _ParallaxMap_ST.xy, float2(0,0), 0 );
			    float4 tex2DNode9 = tex2D( _MainTex, OffsetPOM153 );
			    

				half alpha = ( staticSwitch305 + tex2DNode9.a );
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
			#define _SurfaceOpaque
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
			#pragma shader_feature_local _USECOLORMASK_ON
			#pragma shader_feature_local _VERTEXTINT_ON
			#pragma shader_feature_local _EMITALBEDO_ON
			#pragma shader_feature_local VERTEXILLUMINATION_ON


			//TEXTURE2D(_BaseMap);
			//SAMPLER(sampler_BaseMap);

			// Begin Injection UNIFORMS from Injection_Emission_Meta.hlsl ----------------------------------------------------------
			//TEXTURE2D(_EmissionMap);
			// End Injection UNIFORMS from Injection_Emission_Meta.hlsl ----------------------------------------------------------

			CBUFFER_START(UnityPerMaterial)
				float4 _ParallaxMap_ST;
				float4 _Color;
				float4 _ColorShift1;
				float4 _ColorShift2;
				float4 _ColorShift3;
				float4 _ColorShift4;
				float4 _DetailAlbedoMap_ST;
				float4 _EmissionColor;
				float _Parallax;
				float _DetailNormalMapScale;
				float _BumpScale;
				float _EmissionFalloff;
				float _Metallic;
				float _Glossiness;
				float _OcclusionStrength;
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
				float2 uv_ParallaxMap = i.uv * _ParallaxMap_ST.xy + _ParallaxMap_ST.zw;
				float temp_output_155_0 = ( _Parallax * -1.0 );
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
				float2 OffsetPOM153 = POM( _ParallaxMap, uv_ParallaxMap, ddx(uv_ParallaxMap), ddy(uv_ParallaxMap), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, temp_output_155_0, 0, _ParallaxMap_ST.xy, float2(0,0), 0 );
				float4 tex2DNode9 = tex2D( _MainTex, OffsetPOM153 );
				float4 color297 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				#ifdef _VERTEXTINT_ON
				float4 staticSwitch296 = i.ase_color;
				#else
				float4 staticSwitch296 = color297;
				#endif
				float2 texCoord290 = i.uv * float2( 1,1 ) + float2( 0,0 );
				float4 tex2DNode282 = tex2D( _ColorMask, texCoord290 );
				float4 lerpResult289 = lerp( float4( 1,1,1,1 ) , _ColorShift1 , tex2DNode282.r);
				float4 lerpResult287 = lerp( float4( 1,1,1,1 ) , _ColorShift2 , tex2DNode282.g);
				float4 lerpResult286 = lerp( float4( 1,1,1,1 ) , _ColorShift3 , tex2DNode282.b);
				float4 lerpResult288 = lerp( float4( 1,1,1,1 ) , _ColorShift4 , tex2DNode282.a);
				#ifdef _USECOLORMASK_ON
				float4 staticSwitch293 = ( lerpResult289 * lerpResult287 * lerpResult286 * lerpResult288 );
				#else
				float4 staticSwitch293 = ( tex2DNode9 * _Color * staticSwitch296 );
				#endif
				float2 uv_DetailAlbedoMap = i.uv * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
				float2 OffsetPOM398 = POM( _DetailAlbedoMap, uv_DetailAlbedoMap, ddx(uv_DetailAlbedoMap), ddy(uv_DetailAlbedoMap), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 8, 8, temp_output_155_0, 0, _DetailAlbedoMap_ST.xy, float2(0,0), 0 );
				float temp_output_9_0_g94 = tex2D( _DetailMask, OffsetPOM398 ).r;
				float temp_output_18_0_g94 = ( 1.0 - temp_output_9_0_g94 );
				float3 appendResult16_g94 = (float3(temp_output_18_0_g94 , temp_output_18_0_g94 , temp_output_18_0_g94));
				#ifdef _HMMMDETAIL_ON
				float4 staticSwitch199 = float4( ( staticSwitch293.rgb * ( ( ( tex2D( _DetailAlbedoMap, OffsetPOM398 ).rgb * (unity_ColorSpaceDouble).rgb ) * temp_output_9_0_g94 ) + appendResult16_g94 ) ) , 0.0 );
				#else
				float4 staticSwitch199 = staticSwitch293;
				#endif
				
				#ifdef _EMITALBEDO_ON
				float4 staticSwitch391 = staticSwitch293;
				#else
				float4 staticSwitch391 = float4(1,1,1,1);
				#endif
				float4 temp_output_249_0 = ( tex2D( _EmissionMap, OffsetPOM153 ) * _EmissionColor * staticSwitch391 );
				float dotResult276 = dot( ase_worldViewDir , ase_worldNormal );
				
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
			
				metaInput.Albedo = staticSwitch199.rgb;
				half3 emission = ( temp_output_249_0 * saturate( pow( abs( dotResult276 ) , ( _EmissionFalloff * 1.0 ) ) ) ).rgb;
				half3 bakedemission = temp_output_249_0.rgb;
				metaInput.Emission = bakedemission.rgb;
				#ifdef EDITOR_VISUALIZATION
					metaInput.VizUV = i.VizUV.xy;
					metaInput.LightCoord = i.LightCoord;
				#endif
			
				half alpha = ( staticSwitch305 + tex2DNode9.a );
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
360;73;1103;514;2442.654;1365.534;2.93138;True;True
Node;AmplifyShaderEditor.CommentaryNode;209;-3154.088,590.5229;Inherit;False;1291.838;1340.76;;9;165;148;155;147;120;153;164;154;398;Height Map;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;154;-2800.55,788.4324;Inherit;True;Property;_ParallaxMap;Height Map;10;1;[Header];Create;False;1;Parallax;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;120;-2734.739,1011.063;Inherit;False;Property;_Parallax;Height Scale;11;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;292;-3077.066,-2895.074;Inherit;False;1151.364;1015.291;;11;285;282;287;291;289;288;286;284;283;281;290;Color Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;148;-2765.333,1270.258;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;155;-2434.335,1007.85;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;147;-2498.085,802.7722;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;205;-3125.834,-744.05;Inherit;False;1103.113;591.1926;;5;178;9;12;296;295;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;290;-3074.046,-2774.425;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;281;-2869.672,-2423.007;Float;False;Property;_ColorShift2;_ColorShift2;38;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,0.7795243,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;295;-2572.5,-334.9993;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;284;-2857.07,-2063.394;Float;False;Property;_ColorShift4;_ColorShift4;40;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;204;-1070.681,-1815.603;Inherit;False;1390.087;847.3003;;14;116;110;249;273;274;275;276;277;278;279;280;391;392;394;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;282;-2870.305,-2797.061;Inherit;True;Property;_ColorMask;Color Tint;36;2;[Header];[NoScaleOffset];Create;False;1;Color Mask;0;0;False;0;False;-1;None;efbe9dc596a419e48bad8b6e03497f3e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;297;-2797.982,-416.1646;Inherit;False;Constant;_Color1;color;5;0;Create;False;0;0;0;False;0;False;1,1,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;285;-2869.67,-2588.107;Float;False;Property;_ColorShift1;_ColorShift1;37;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxOcclusionMappingNode;153;-2213.686,841.0707;Inherit;False;0;8;False;-1;16;False;-1;2;0.02;0;False;1,1;False;0,0;8;0;FLOAT2;0,0;False;1;SAMPLER2D;;False;7;SAMPLERSTATE;;False;2;FLOAT;0.02;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT2;0,0;False;6;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;283;-2870.972,-2255.307;Float;False;Property;_ColorShift3;_ColorShift3;39;0;Create;True;0;0;0;False;0;False;1,1,1,1;0.7075471,0.3961179,0.2569862,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;12;-2568.582,-517.3932;Inherit;False;Property;_Color;Main Color;2;0;Create;False;0;0;0;False;0;False;1,1,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;288;-2484.089,-2125.573;Inherit;False;3;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;296;-2278.836,-374.6173;Inherit;False;Property;_VertexTint;Vertex Tint;41;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;287;-2497.322,-2372.071;Inherit;False;3;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;279;-555.9316,-1603.3;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TexturePropertyNode;165;-2972.001,1133.855;Inherit;True;Property;_DetailAlbedoMap;Detail Albedo X2;24;0;Create;False;0;0;0;False;0;False;None;26ce2d530a1beb04cb2d7f5824041347;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.LerpOp;289;-2510.865,-2525.498;Inherit;False;3;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;9;-2786.547,-701.8194;Inherit;True;Property;_MainTex;Main Tex;1;0;Create;True;0;0;0;False;0;False;-1;None;fc0bcbf39317b7643923deadd92e8e4e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;273;-590.0478,-1797.808;Float;True;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;286;-2501.772,-2252.707;Inherit;False;3;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;277;-597.6643,-1438.521;Float;False;Property;_EmissionFalloff;Emission Falloff;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;178;-2173.185,-607.2475;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;291;-2192.416,-2382.064;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;164;-2546.366,1132.436;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;294;-1155.531,-916.7139;Inherit;False;272.8773;135.1985;;1;293;Use ColorMask;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;276;-338.0481,-1731.808;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;278;-273.4983,-1470.908;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxOcclusionMappingNode;398;-2193.09,1223.666;Inherit;False;0;8;False;-1;16;False;-1;2;0.02;0;False;1,1;False;0,0;8;0;FLOAT2;0,0;False;1;SAMPLER2D;;False;7;SAMPLERSTATE;;False;2;FLOAT;0.02;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT2;0,0;False;6;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;206;464.34,-569.5273;Inherit;False;716.1443;1063.664;;5;100;99;81;179;15;Detail Maps;1,1,1,1;0;0
Node;AmplifyShaderEditor.AbsOpNode;275;-101.9232,-1689.952;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;394;-764.1237,-1158.891;Inherit;False;Constant;_Vector0;Vector 0;44;0;Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;293;-1124.148,-906.5101;Inherit;False;Property;_UseColorMask;Use ColorMask;44;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;110;-1021.153,-1482.532;Inherit;True;Property;_EmissionMap;Emission Map;12;1;[Header];Create;True;1;Emission;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;306;-1692.667,-375.6542;Inherit;False;Constant;_Float3;Float 3;38;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;274;-17.73423,-1560.104;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;81;766.9305,-69.22673;Inherit;True;Property;_DetailAlbedoMapp;Detail Albedo X2;14;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;116;-968.0751,-1267.464;Inherit;False;Property;_EmissionColor;Emission Color;14;1;[HDR];Create;True;0;0;0;True;0;False;0,0,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;769.862,-271.0169;Inherit;True;Property;_DetailMask;Detail Mask;19;2;[Header];[NoScaleOffset];Create;True;1;Detail;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;391;-450.8895,-1144.46;Inherit;False;Property;_EmitAlbedo;Emit Albedo;15;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;208;-3030.823,-73.74058;Inherit;False;1061.394;516.7698;;3;73;72;70;Normal Map;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;249;-227.4102,-1285.074;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;179;778.5174,-404.6934;Inherit;False;Detail Albedo;20;;94;29e5a290b15a7884983e27c8f1afaa8c;0;3;12;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;9;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;203;-3209.844,-1665.173;Inherit;False;1894.306;888.598;;8;183;184;186;187;190;185;189;188;Fluorescence;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;212;-434.3903,-600.4395;Inherit;False;396.3319;441.0793;;1;199;Use Detail?;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;305;-1448.92,-321.1237;Inherit;False;Property;VertexIllumination;VertexIllumination;42;0;Create;False;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;85;-260.5248,725.2187;Inherit;False;309;190;;1;82;Occlusion Switch;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;280;97.50897,-1404.346;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;207;-1175.203,-692.2924;Inherit;False;609.7109;327.6749;;1;191;Fluorescence Switch;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;213;389.208,-1065.896;Inherit;False;309;190;;1;181;BRDF;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;211;-1544.092,14.44828;Inherit;False;1223.75;733.5038;;10;21;176;157;170;169;23;177;25;167;26;Metallic/MAS/RMA;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;210;-1299.77,1318.596;Inherit;False;939.1121;659.9141;;7;27;84;172;91;173;171;83;Occlusion;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;362;534.0555,-4505.396;Float;False;Property;_ScreenColor;ScreenColor;46;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;307;-580.1635,-123.0403;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;392;24.38941,-1216.216;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;82;-208.2761,770.043;Inherit;False;Property;_UseOcclusion;Use Occlusion;17;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;330;-1419.615,697.8862;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;389;195.1975,-396.5552;Inherit;False;Property;_ToggleSwitch0;Toggle Switch0;48;0;Create;True;0;0;0;False;0;False;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;176;-1069.243,477.3736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;374;1479.491,-4407.201;Float;False;Global;globalScreenScaler;globalScreenScaler;15;0;Create;True;0;0;0;False;0;False;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;186;-2552.448,-1297.934;Inherit;False;Property;_FluoresenceTint;Fluoresence Tint;31;1;[Header];Create;True;1;Fluoresence;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;173;-878.4939,1712.835;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;329;-1754.664,606.7496;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;331;-1638.224,748.7575;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-2838.732,210.9914;Inherit;False;Property;_BumpScale;Normal Scale;4;0;Create;False;0;0;0;False;0;False;1;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;366;678.7845,-4266.075;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;181;411.0699,-1003.488;Inherit;False;BRDFMap;28;;117;1affaac2d6e57354aaa8d6573a2b32b8;0;1;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;419;939.2321,1573.466;Inherit;False;Property;_g_flSpecularPower;g_flSpecularPower;52;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;183;-2515.73,-1552.504;Inherit;True;Property;_FluoresenceMap;Fluoresence Map;32;2;[Header];[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;332;290.4964,411.8444;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;363;475.9205,-4725.899;Inherit;True;Property;_CubeBG;CubeBG;45;1;[Header];Create;True;1;Holographic Wall;0;0;False;0;False;-1;None;None;True;0;False;black;LockedToCube;False;Object;-1;MipLevel;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;190;-1548.693,-986.3619;Inherit;False;Property;_Absorbance;Absorbance;34;0;Create;True;0;0;0;False;0;False;0.5882353,0.7843137,0.8666667,0;0.09999994,0.25,0.5,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;299;103.907,1027.484;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;172;-1180.676,1740.93;Inherit;False;Property;_OcclusionStrength;_OcclusionStrength;27;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;187;-2095.308,-1415.229;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;424;-2006.978,-144.4737;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;99;781.5314,137.8232;Inherit;True;Property;_DetailNormalMap;Detail Normal;25;1;[NoScaleOffset];Create;False;0;0;0;False;0;False;-1;None;a8677a9323155d043a784b0248ffe0dd;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-425.5753,480.7012;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;324;-1643.144,894.262;Inherit;False;Property;_NormalToOcclusion;Normal To Occlusion;5;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;302;-369.2906,646.9437;Inherit;False;Constant;_Float2;Float 2;37;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;27;-1142.964,1539.424;Inherit;True;Property;_OcclusionMap;Occlusion Map;16;1;[Header];Create;True;1;Occlusion;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;83;-697.4453,1452.25;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;368;-1217.024,-1534.953;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;322;-705.5233,-287.2177;Inherit;False;FLOAT;1;0;FLOAT;0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;328;-2157.288,421.1167;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;177;-802.1821,383.6985;Inherit;False;Property;_Keyword0;Keyword 0;6;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;157;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-795.6489,536.092;Inherit;False;Property;_Metallic;Metallic;8;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;70;-2312.439,153.9961;Inherit;True;Property;_BumpMap;Normal Map;3;0;Create;False;0;0;0;False;0;False;-1;None;48b951488ea4f9349aa03ab1ac1d2db1;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;100;515.1421,289.3925;Inherit;False;Property;_DetailNormalMapScale;Detail Normal Scale;26;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;167;-424.9536,245.0262;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;261;-3491.335,-407.7022;Inherit;False;Color Mask;-1;;116;eec747d987850564c95bde0e5a6d1867;0;4;1;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;1;False;5;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LuminanceNode;412;591.3859,1462.974;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;191;-899.1896,-516.7939;Inherit;False;Property;_UsingFluoresenceMap;Using Fluoresence Map;35;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;184;-2548.428,-1080.518;Inherit;False;Property;_Intensity;Intensity;33;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;298;112.2454,620.5475;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;323;-1883.316,382.1762;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;21;-1443.805,239.8978;Inherit;True;Property;_MetallicGlossMap;Metallic Map;7;0;Create;False;0;0;0;False;0;False;-1;bfeb91aff4ad47443a4ab34d16f4ff0a;f2002fd355190f849be6bdc98fead029;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;163;-210.1317,-44.59788;Inherit;False;Property;_Cutoff;Alpha Clipping;0;0;Create;False;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StickyNoteNode;308;2217.018,-876.5578;Inherit;False;172.2473;100;Made by;shortstakxxx@gmail.com ;1,1,1,1;;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;185;-2032.862,-1070.474;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;157;-822.8562,234.6634;Inherit;False;Property;_MetallicType;Metallic Type;6;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;4;MAS;MetallicSmoothness;RMA;MASK;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;84;-882.5567,1426.616;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;2.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;406;157.4496,1440.179;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;73;-2523.424,196.2966;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;169;-812.7413,106.8069;Inherit;False;Property;_MetallicType;Metallic Type;6;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;MAS;MetallicSmoothness;Reference;157;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-756.3005,623.4407;Inherit;False;Property;_Glossiness;Smoothnes;9;0;Create;False;0;0;0;False;0;False;1;1;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;91;-474.9757,1353.653;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;325;-519.2007,764.7163;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;409;275.3859,1428.974;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;189;-2231.064,-1007.066;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;410;422.3859,1513.974;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;188;-1744.439,-1283.007;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;367;1119.757,-4519.908;Inherit;True;Property;_EmissionMask;Emission Mask;47;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;407;-116.4294,1408.189;Inherit;False;Property;_vPositionToCameraDirWs;vPositionToCameraDirWs;50;0;Create;True;0;0;0;False;0;False;0,0,0;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;413;756.3859,1473.974;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;422;1334.974,1397.389;Inherit;False;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;411;244.3859,1690.974;Inherit;False;Constant;_vReflectance;vReflectance;46;0;Create;True;0;0;0;False;0;False;0.001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;170;-1067.929,90.81509;Inherit;False;Constant;_Float1;Float 1;19;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;415;703.8481,1598.776;Inherit;False;Property;_g_flReflectanceMax;g_flReflectanceMax;51;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;171;-713.8065,1559.213;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;300;-171.049,515.909;Inherit;False;Property;_VertexOcclusion;Vertex Occlusion;43;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;414;919.3619,1439.178;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;425;-1949.795,-19.73352;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;423;1273.974,1609.389;Inherit;False;Property;_g_flReflectanceMin;g_flReflectanceMin;53;0;Create;True;0;0;0;False;0;False;0,0,0;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;418;1122.73,1429.198;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;303;341.5018,581.8215;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;101;47.48265,293.8067;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;408;-104.6141,1579.974;Inherit;False;Property;_vNormalWs;vNormalWs;49;0;Create;True;0;0;0;False;0;False;0,0,0;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;199;-355.7313,-507.0652;Inherit;False;Property;_hmmmdetail;hmmm detail?;18;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;404;113.2767,-59.96434;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;Meta;0;4;Meta;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;0;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;403;113.2767,-59.96434;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;ShadowCaster;0;3;ShadowCaster;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;0;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;400;113.2767,-59.96434;Float;False;True;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;Valve/VRStandard;623634af11bd9ab448550ee777f3493e;True;Forward;0;0;Forward;14;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;True;1;Lightmode=UniversalForward;True;7;0;Hidden/InternalErrorShader;0;0;Standard;24;Workflow;1;Surface;0;Two Sided;1;Cast Shadows;1;  Use Shadow Threshold;0;GPU Instancing;0;Built-in Fog;1;Lightmaps;1;Volumetrics;1;Decals;0;Write Depth;0;  Early Z (broken);0;Vertex Position,InvertActionOnDeselection;1;Emission;1;PC Reflection Probe;3;PC Receive Shadows;1;PC Vertex Lights;0;PC SSAO;1;Q Reflection Probe;0;Q Receive Shadows;0;Q Vertex Lights;1;Q SSAO;0;Environment Reflections;1;Meta Pass;1;0;5;True;True;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;401;113.2767,-59.96434;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;DepthOnly;0;1;DepthOnly;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;0;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;True;1;Lightmode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;402;113.2767,-59.96434;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;DepthNormals;0;2;DepthNormals;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;Lightmode=DepthNormals;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
WireConnection;155;0;120;0
WireConnection;147;2;154;0
WireConnection;282;1;290;0
WireConnection;153;0;147;0
WireConnection;153;1;154;0
WireConnection;153;2;155;0
WireConnection;153;3;148;0
WireConnection;288;1;284;0
WireConnection;288;2;282;4
WireConnection;296;1;297;0
WireConnection;296;0;295;0
WireConnection;287;1;281;0
WireConnection;287;2;282;2
WireConnection;289;1;285;0
WireConnection;289;2;282;1
WireConnection;9;1;153;0
WireConnection;286;1;283;0
WireConnection;286;2;282;3
WireConnection;178;0;9;0
WireConnection;178;1;12;0
WireConnection;178;2;296;0
WireConnection;291;0;289;0
WireConnection;291;1;287;0
WireConnection;291;2;286;0
WireConnection;291;3;288;0
WireConnection;164;2;165;0
WireConnection;276;0;273;0
WireConnection;276;1;279;0
WireConnection;278;0;277;0
WireConnection;398;0;164;0
WireConnection;398;1;165;0
WireConnection;398;2;155;0
WireConnection;398;3;148;0
WireConnection;275;0;276;0
WireConnection;293;1;178;0
WireConnection;293;0;291;0
WireConnection;110;1;153;0
WireConnection;274;0;275;0
WireConnection;274;1;278;0
WireConnection;81;0;165;0
WireConnection;81;1;398;0
WireConnection;15;1;398;0
WireConnection;391;1;394;0
WireConnection;391;0;293;0
WireConnection;249;0;110;0
WireConnection;249;1;116;0
WireConnection;249;2;391;0
WireConnection;179;12;293;0
WireConnection;179;11;81;0
WireConnection;179;9;15;0
WireConnection;305;1;306;0
WireConnection;305;0;295;4
WireConnection;280;0;274;0
WireConnection;307;0;305;0
WireConnection;307;1;9;4
WireConnection;392;0;249;0
WireConnection;392;1;280;0
WireConnection;82;1;169;0
WireConnection;82;0;171;0
WireConnection;330;0;331;0
WireConnection;330;1;324;0
WireConnection;176;0;21;1
WireConnection;173;0;172;0
WireConnection;329;0;323;0
WireConnection;331;0;329;0
WireConnection;332;0;303;0
WireConnection;332;1;325;0
WireConnection;187;0;184;0
WireConnection;187;1;183;0
WireConnection;99;1;398;0
WireConnection;99;5;100;0
WireConnection;25;0;157;0
WireConnection;25;1;26;0
WireConnection;27;1;153;0
WireConnection;83;0;27;0
WireConnection;83;1;84;0
WireConnection;177;1;21;1
WireConnection;177;0;21;1
WireConnection;177;2;21;2
WireConnection;177;3;21;1
WireConnection;70;1;153;0
WireConnection;70;5;73;0
WireConnection;167;0;177;0
WireConnection;167;1;23;0
WireConnection;261;1;9;0
WireConnection;191;0;188;0
WireConnection;298;0;300;0
WireConnection;298;1;82;0
WireConnection;323;0;70;0
WireConnection;323;1;328;0
WireConnection;21;1;153;0
WireConnection;185;0;183;0
WireConnection;185;1;186;0
WireConnection;185;2;189;0
WireConnection;157;1;21;3
WireConnection;157;0;21;4
WireConnection;157;2;176;0
WireConnection;157;3;21;4
WireConnection;406;0;407;0
WireConnection;406;1;408;0
WireConnection;73;0;72;0
WireConnection;169;1;21;2
WireConnection;169;0;170;0
WireConnection;169;2;21;3
WireConnection;169;3;21;2
WireConnection;325;0;330;0
WireConnection;409;0;406;0
WireConnection;189;2;184;0
WireConnection;410;0;409;0
WireConnection;410;1;411;0
WireConnection;188;0;185;0
WireConnection;188;2;187;0
WireConnection;413;0;412;0
WireConnection;413;1;410;0
WireConnection;422;0;418;0
WireConnection;422;1;423;0
WireConnection;171;0;27;2
WireConnection;171;3;173;0
WireConnection;300;1;302;0
WireConnection;300;0;425;0
WireConnection;414;0;413;0
WireConnection;414;1;415;0
WireConnection;425;0;295;1
WireConnection;418;0;414;0
WireConnection;418;1;419;0
WireConnection;303;0;298;0
WireConnection;101;0;99;0
WireConnection;101;1;70;0
WireConnection;199;1;293;0
WireConnection;199;0;179;0
WireConnection;400;0;199;0
WireConnection;400;1;101;0
WireConnection;400;2;392;0
WireConnection;400;3;249;0
WireConnection;400;4;167;0
WireConnection;400;6;25;0
WireConnection;400;7;298;0
WireConnection;400;8;307;0
WireConnection;400;9;163;0
ASEEND*/
//CHKSM=A53AA5BF92456A1C09BC670FAC3E8735E6804EFB