// Force reimport: 2
Shader "SLZ/LitMAS/LitMAS VRStandard"
{
	Properties
	{
		[HideInInspector] [Toggle( S_UNLIT )] g_bUnlit( "g_bUnlit", Int ) = 0

		[HideInInspector] _Color( "Color", Color ) = ( 1, 1, 1, 1 )
		[HideInInspector] _MainTex( "Albedo", 2D ) = "white" {}

		[HideInInspector] g_tBRDFMap("BRDF Map", 2D) = "grey" {} 

		[HideInInspector] _ColorMask( "Color Mask", 2D ) = "white" {}
		[HideInInspector] _ColorShift1( "Color Shift 1", Color ) = ( 1, 1, 1 )
		[HideInInspector] _ColorShift2( "Color Shift 2", Color ) = ( 1, 1, 1 )
		[HideInInspector] _ColorShift3( "Color Shift 3", Color ) = ( 1, 1, 1 )

		[HideInInspector] _Cutoff( "Alpha Cutoff", Range( 0.0, 1.0 ) ) = 0.5

		[HideInInspector] _Glossiness("Smoothness", Range(0.0, 1.0)) = 0.5
	//	[HideInInspector] _Glossiness2("Anisotropic Smoothness", Range(0.0, 1.0)) = 0.5
		[HideInInspector] _AnisotropicRotation("Anisotropic Rotation" , Range(0.0, 1.0)) = 0.5
		[HideInInspector][Gamma] _AnisotropicRatio("Anisotropic Ratio" , range (0.0,1.0)   ) = 0.5
		[HideInInspector] _SpecColor("Specular", Color) = (0.2,0.2,0.2)
		[HideInInspector] _SpecGlossMap("Specular", 2D) = "white" {}

		[HideInInspector] g_flReflectanceMin( "g_flReflectanceMin", Range( 0.0, 1.0 ) ) = 0.0
		[HideInInspector] g_flReflectanceMax( "g_flReflectanceMax", Range( 0.0, 1.0 ) ) = 1.0
		[HideInInspector] g_flReflectanceScale( "g_flReflectanceScale", Range( 0.0, 1.0 ) ) = 1.0
		[HideInInspector] g_flReflectanceBias( "g_flReflectanceBias", Range( 0.0, 1.0 ) ) = 0.0

		[HideInInspector] [Gamma] _Metallic( "Metallic", Range( 0.0, 1.0 ) ) = 0.0
		[HideInInspector] _MetallicGlossMap( "Metallic", 2D ) = "black" {}

		[HideInInspector] _SpecMod( "Specular Mod", Range( 0.0, 2.0 ) ) = 1.0

		[HideInInspector] _BumpScale( "Scale", Float ) = 1.0
		[HideInInspector]  [Normal] _BumpMap( "Normal Map", 2D ) = "bump" {}

		[HideInInspector] _NormalToOcclusion("Normal To Occlusion", Range(0.0, 2.0)) = 1.0

		[HideInInspector] _Parallax ( "Height Scale", float ) = -0.02
		[HideInInspector] _ParallaxMap ( "Height Map", 2D ) = "black" {}
		[HideInInspector]_ParallaxIterations ("Parallax Iterations", Range(1.0,32.0) ) = 1.0
		[HideInInspector]_ParallaxOffset ("Parallax Offset", Float ) = 0.0 //Need to debug

		[HideInInspector] _OcclusionStrength( "Strength", Range( 0.0, 1.0 ) ) = 1.0
		[HideInInspector] _OcclusionMap( "Occlusion", 2D ) = "white" {}
		[HideInInspector] _OcclusionStrengthDirectDiffuse( "StrengthDirectDiffuse", Range( 0.0, 1.0 ) ) = 1.0
		[HideInInspector] _OcclusionStrengthDirectSpecular( "StrengthDirectSpecular", Range( 0.0, 1.0 ) ) = 1.0
		[HideInInspector] _OcclusionStrengthIndirectDiffuse( "StrengthIndirectDiffuse", Range( 0.0, 1.0 ) ) = 1.0
		[HideInInspector] _OcclusionStrengthIndirectSpecular( "StrengthIndirectSpecular", Range( 0.0, 1.0 ) ) = 1.0

		[HideInInspector] g_flFresnelFalloff ("Fresnel Falloff Scalar" , Range(0.0 , 2.0 ) ) = 1.0
		[HideInInspector] g_flFresnelExponent ( "Fresnel Exponent", Range( 0.5, 10.0 ) ) = 5.0
		[HideInInspector] g_flCubeMapScalar( "Cube Map Scalar", Range( 0.0, 2.0 ) ) = 1.0

		[HideInInspector] [HDR]_EmissionColor( "Emissive Color", Color ) = ( 0, 0, 0 )
		[HideInInspector] _EmissionMap( "Emission", 2D ) = "white" {}
		[HideInInspector] _EmissionFalloff("Emission Falloff" , Range( 0.0, 10.0 ) ) = 0.0

		[HideInInspector] _FluorescenceMap( "Fluorescence", 2D ) = "white" {}
		[HideInInspector] _FluorescenceColor("Fluorescence Color" , Color ) = (0,0,0)
		[HideInInspector] _Absorbance("Absorbance Color" , Color ) = (0.1,0.25,0.5,1.0)
		[HideInInspector] _DetailMask( "Detail Mask", 2D ) = "white" {}

		[HideInInspector] _DetailAlbedoMap( "Detail Albedo x2", 2D ) = "grey" {}
		[HideInInspector] _DetailNormalMapScale( "Scale", Float ) = 1.0
		[HideInInspector] _DetailNormalMap( "Normal Map", 2D ) = "bump" {}
			
		[HideInInspector] g_tOverrideLightmap( "Override Lightmap", 2D ) = "white" {}

		[HideInInspector] [Enum(UV0,0,UV1,1)] _UVSec ( "UV Set for secondary textures", Float ) = 0

		[HideInInspector] [Toggle( D_CASTSHADOW )] g_bCastShadows("g_bCastShadows", Int) = 1

		[HideInInspector] [Toggle( S_RECEIVE_SHADOWS )] g_bReceiveShadows( "g_bReceiveShadows", Int ) = 1

		[HideInInspector] [Toggle( S_RENDER_BACKFACES )] g_bRenderBackfaces( "g_bRenderBackfaces", Int ) = 0

		[HideInInspector] [Toggle( S_EMISSIVE_MULTI )] _EmissiveMode ("__emissiveMode", Int) = 0

		[HideInInspector] [Toggle( S_WORLD_ALIGNED_TEXTURE )] g_bWorldAlignedTexture( "g_bWorldAlignedTexture", Int ) = 0
		[HideInInspector] g_vWorldAlignedTextureSize( "g_vWorldAlignedTextureSize", Vector ) = ( 1.0, 1.0, 1.0, 0.0 )
		[HideInInspector] g_vWorldAlignedTextureNormal( "g_vWorldAlignedTextureNormal", Vector ) = ( 0.0, 1.0, 0.0, 0.0 )
		[HideInInspector] g_vWorldAlignedTexturePosition( "g_vWorldAlignedTexturePosition", Vector ) = ( 0.0, 0.0, 0.0, 0.0 )
		[HideInInspector] g_vWorldAlignedNormalTangentU( "g_vWorldAlignedNormalTangentU", Vector ) = ( -1.0, 0.0, 0.0, 0.0)
		[HideInInspector] g_vWorldAlignedNormalTangentV( "g_vWorldAlignedNormalTangentV", Vector ) = ( 0.0, 0.0, 1.0, 0.0)
		
		[HideInInspector] _SpecularMode( "__specularmode", Int ) = 1
		[HideInInspector] _Cull ( "__cull", Int ) = 2
		[HideInInspector] _VertexMode("__VetexMode", Int) = 0
		[HideInInspector] _PackingMode("__PackingMode", Int) = 0
		[HideInInspector] _DetailMode("__DetailMode", Int) = 0

		[HideInInspector] _Mode ( "__mode", Float ) = 0.0
		[HideInInspector] _SrcBlend ( "__src", Float ) = 1.0
		[HideInInspector] _DstBlend ( "__dst", Float ) = 0.0
		[HideInInspector] _ZWrite ( "__zw", Float ) = 1.0
		[HideInInspector] _FogMultiplier ( "__fogmult", Float ) = 1.0
		[HideInInspector] _Test ("__test", Int) = 0

		[HideInInspector] _OffsetFactor ( "__fac", Float ) = 0.0
		[HideInInspector] _OffsetUnits  ( "__units", Float ) = 0.0
		
		[HideInInspector] _ColorMultiplier ("target color", float) = 0.0

        [Space(30)][Header(Screen Space Reflections)][Space(10)][Toggle(_NO_SSR)] _SSROff("Disable SSR", Float) = 0
		[Header(This should be 0 for skinned meshes)]
		_SSRTemporalMul("Temporal Accumulation Factor", Range(0, 2)) = 1.0
		//[Toggle(_SM6_QUAD)] _SM6_Quad("Quad-avg SSR", Float) = 0

		[HideInInspector]_Surface ("Surface Type", float) = 0
		[HideInInspector]_BlendSrc ("Blend Source", float) = 1
		[HideInInspector]_BlendDst ("Blend Destination", float) = 0

	}
	SubShader
	{
		Tags {"RenderPipeline" = "UniversalPipeline"  "RenderType" = "Opaque" "Queue" = "Geometry" }
		
		ZTest LEqual
		Offset 0 , 0
		ColorMask RGBA
		//LOD 100

		Pass
		{
			Blend [_SrcBlend] [_DstBlend]
			ZWrite [_ZWrite]
			Cull [_Cull]
			Offset [_OffsetFactor] , [_OffsetUnits]
			
			AlphaToMask [_Test]

			Name "Forward"
			Tags {"Lightmode"="UniversalForward"}
			HLSLPROGRAM
			#pragma only_renderers vulkan
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0

			#define LITMAS_FEATURE_LIGHTMAPPING
			#define LITMAS_FEATURE_TS_NORMALS
			#define LITMAS_FEATURE_EMISSION
			#define LITMAS_FEATURE_SSR
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			#if defined(SHADER_API_DESKTOP)
			//#pragma require WaveVote
			//#pragma require QuadShuffle
			//#pragma shader_feature _SM6_QUAD
			//#define _SM6_QUAD 1
			#endif

			#include_with_pragmas "LitMASInclude/ShaderInjector/VRStandardForward.hlsl"

			ENDHLSL
		}

		Pass
		{

			Name "DepthOnly"
			Tags {"Lightmode"="DepthOnly"}
			ZWrite [_ZWrite]
			Cull [_Cull]
			ColorMask 0

			HLSLPROGRAM
			#pragma only_renderers vulkan
			#pragma vertex vert
			#pragma fragment frag
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			#include "LitMASInclude/DepthOnly.hlsl" 
			ENDHLSL
		}

		Pass
		{
			Name "DepthNormals"
			Tags {"Lightmode" = "DepthNormals"}
			ZWrite [_ZWrite]
			Cull [_Cull]
			//ZTest Off
			//ColorMask 0

			HLSLPROGRAM
			#pragma only_renderers vulkan
			#pragma vertex vert
			#pragma fragment frag
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			#include "LitMASInclude/ShaderInjector/StandardDepthNormals.hlsl" 
			ENDHLSL
		}

		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite [_ZWrite]
			ZTest LEqual
			
			Cull [_Cull]
			ColorMask 0

			HLSLPROGRAM
			#pragma only_renderers vulkan
			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			#include "LitMASInclude/ShadowCaster.hlsl"
			ENDHLSL
		}

		Pass
		{
			Name "Meta"
			Tags { "LightMode" = "Meta" }
			Blend [_BlendSrc] [_BlendDst]
			ZWrite [_ZWrite]
			Cull Off

			HLSLPROGRAM
			#pragma only_renderers vulkan
			#define _NORMAL_DROPOFF_TS 1
			#define _EMISSION
			#define _NORMALMAP 1

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_META
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			#include "LitMASInclude/ShaderInjector/StandardMeta.hlsl" 
			ENDHLSL
		}

		Pass
		{
			
			Name "BakedRaytrace"
			Tags{ "LightMode" = "BakedRaytrace" }
			HLSLPROGRAM
			#pragma only_renderers vulkan
			#pragma multi_compile _ _EMISSION_ON
			#include "LitMASInclude/ShaderInjector/StandardBakedRT.hlsl"

			ENDHLSL
		}
	}

 // Duplicate subshader for DX11, since using '#pragma require' automatically marks the whole subshader as invalid for dx11 even if its guarded by an API define
	SubShader
	{
		Tags {"RenderPipeline" = "UniversalPipeline"  "RenderType" = "Opaque" "Queue" = "Geometry" }
		
		ZTest LEqual
		Offset 0 , 0
		ColorMask RGBA
		//LOD 100

		HLSLINCLUDE
		//
		ENDHLSL

		Pass
		{
			Blend [_BlendSrc] [_BlendDst]
			ZWrite [_ZWrite]
			Cull [_Cull]
			Name "Forward"
			Tags {"Lightmode"="UniversalForward"}

			HLSLPROGRAM
			#pragma exclude_renderers vulkan
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0

			#define LITMAS_FEATURE_LIGHTMAPPING
			#define LITMAS_FEATURE_TS_NORMALS
			#define LITMAS_FEATURE_EMISSION
			#define LITMAS_FEATURE_SSR
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"

			//#if defined(SHADER_API_DESKTOP)
			//#pragma require QuadShuffle
			//#define _SM6_QUAD 1
			//#endif

			#include_with_pragmas "LitMASInclude/ShaderInjector/VRStandardForward.hlsl"

			ENDHLSL
		}

		Pass
		{

			Name "DepthOnly"
			Tags {"Lightmode"="DepthOnly"}
			ZWrite [_ZWrite]
			Cull [_Cull]
			ColorMask 0

			HLSLPROGRAM
			#pragma exclude_renderers vulkan
			#pragma vertex vert
			#pragma fragment frag
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			#include "LitMASInclude/DepthOnly.hlsl" 
			ENDHLSL
		}

		Pass
		{
			Name "DepthNormals"
			Tags {"Lightmode" = "DepthNormals"}
			ZWrite [_ZWrite]
			Cull [_Cull]
			//ZTest Off
			//ColorMask 0

			HLSLPROGRAM
			#pragma exclude_renderers vulkan
			#pragma vertex vert
			#pragma fragment frag
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			#include "LitMASInclude/ShaderInjector/StandardDepthNormals.hlsl" 
			ENDHLSL
		}

		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite [_ZWrite]
			ZTest LEqual
			
			Cull [_Cull]
			ColorMask 0

			HLSLPROGRAM
			#pragma exclude_renderers vulkan
			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			#include "LitMASInclude/ShadowCaster.hlsl"
			ENDHLSL
		}

		Pass
		{
			Name "Meta"
			Tags { "LightMode" = "Meta" }
			Blend [_BlendSrc] [_BlendDst]
			ZWrite [_ZWrite]
			Cull Off

			HLSLPROGRAM
			#pragma exclude_renderers vulkan
			#define _NORMAL_DROPOFF_TS 1
			#define _EMISSION
			#define _NORMALMAP 1

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_META
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			#include "LitMASInclude/ShaderInjector/StandardMeta.hlsl" 
			ENDHLSL
		}

		Pass
		{
			
			Name "BakedRaytrace"
			Tags{ "LightMode" = "BakedRaytrace" }
			HLSLPROGRAM
			#pragma exclude_renderers vulkan
			#pragma multi_compile _ _EMISSION_ON
			#include "LitMASInclude/ShaderInjector/StandardBakedRT.hlsl"

			ENDHLSL
		}
	}

	//CustomEditor "LitMASGUI"
	CustomEditor "ValveShaderGUI"
	//Fallback "Hidden/InternalErrorShader"
}