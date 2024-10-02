/*-----------------------------------------------------------------------------------------------------*
 *-----------------------------------------------------------------------------------------------------*
 * WARNING: THIS FILE WAS CREATED WITH SHADERINJECTOR, AND SHOULD NOT BE EDITED DIRECTLY. MODIFY THE   *
 * BASE INCLUDE AND INJECTED FILES INSTEAD, AND REGENERATE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   *
 * i dont care unc :laughing: :trol:
 *-----------------------------------------------------------------------------------------------------*
 *-----------------------------------------------------------------------------------------------------*/

#pragma shader_feature	_VERTEXTINT
#pragma shader_feature _ALPHATEST_ON
#pragma shader_feature _ALPHABLEND_ON
#pragma shader_feature _ALPHAPREMULTIPLY_ON
#pragma shader_feature _ALPHAMULTIPLY_ON
#pragma shader_feature _ALPHAMOD2X_ON

#pragma shader_feature _EMISSION
#if defined (_EMISSION)
	#pragma shader_feature S_EMISSIVE_MULTI		
#endif
#pragma shader_feature _DETAIL
#if defined (_DETAIL)
 	#pragma shader_feature _DETAIL_MULX2 
	#pragma shader_feature _DETAIL_MUL  
	#pragma shader_feature	_DETAIL_ADD
	#pragma shader_feature	_DETAIL_LERP
#endif

#pragma shader_feature _PARALLAXMAP
#pragma shader_feature _COLORSHIFT

#pragma shader_feature D_CASTSHADOW
#pragma shader_feature S_WORLD_ALIGNED_TEXTURE
#pragma shader_feature S_RENDER_BACKFACES
		
#pragma shader_feature S_UNLIT
#if defined( S_UNLIT ) 
#else  
	#pragma shader_feature _NORMALMAP
	#pragma shader_feature _FLUORESCENCEMAP		
	#pragma shader_feature S_SPECULAR_NONE
	#pragma shader_feature	S_SPECULAR_BLINNPHONG
	#pragma shader_feature	S_SPECULAR_METALLIC
	#pragma shader_feature	S_ANISOTROPIC_GLOSS
	#pragma shader_feature	S_RETROREFLECTIVE
	#if defined(S_SPECULAR_METALLIC) || (S_RETROREFLECTIVE) || (S_ANISOTROPIC_GLOSS )
		#pragma shader_feature _METALLICGLOSSMAP 
		#if defined(S_SPECULAR_METALLIC)
		#pragma shader_feature  S_PACKING_RMA 
		#pragma shader_feature	S_PACKING_MAES
		#pragma shader_feature S_PACKING_MAS
		#endif
	#elif defined(S_SPECULAR_BLINNPHONG)
		#pragma shader_feature _SPECGLOSSMAP
	#endif

	#pragma shader_feature S_OCCLUSION
	#pragma shader_feature S_OVERRIDE_LIGHTMAP
	#pragma shader_feature _BRDFMAP
	#pragma shader_feature S_RECEIVE_SHADOWS
	#pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
	
	#pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
	#pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
	#pragma shader_feature  D_VALVE_SHADOWING_POINT_LIGHTS
	#pragma shader_feature  Z_SHAPEAO
#endif

#pragma shader_feature  MATRIX_PALETTE_SKINNING_1BONE
#pragma shader_feature  D_VALVE_FOG

#pragma skip_variants SHADOWS_SOFT

// Dynamic combo skips (Static combo skips happen in ValveShaderGUI.cs in SetMaterialKeywords())
#if ( S_UNLIT )
	#undef LIGHTMAP_OFF
	#define LIGHTMAP_OFF 1
	#undef LIGHTMAP_ON

	#undef DIRLIGHTMAP_OFF
	#define DIRLIGHTMAP_OFF 1
	#undef DIRLIGHTMAP_COMBINED
	#undef DIRLIGHTMAP_SEPARATE

	#undef DYNAMICLIGHTMAP_OFF
	#define DYNAMICLIGHTMAP_OFF 1
	#undef DYNAMICLIGHTMAP_ON
#endif

#define SHADERPASS SHADERPASS_FORWARD
#define _NORMAL_DROPOFF_TS 1
#define _EMISSION
#define _NORMALMAP 1

#if defined(SHADER_API_MOBILE)
	#define _ADDITIONAL_LIGHTS_VERTEX
#else              
	#pragma multi_compile_fragment  _  _MAIN_LIGHT_SHADOWS_CASCADE

//#define DYNAMIC_SCREEN_SPACE_OCCLUSION
#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
	
//#define DYNAMIC_ADDITIONAL_LIGHTS
#pragma multi_compile_fragment _ _ADDITIONAL_LIGHTS


//#define DYNAMIC_ADDITIONAL_LIGHT_SHADOWS
#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS

	#define _SHADOWS_SOFT 1
	
	#define _REFLECTION_PROBE_BLENDING
	//#pragma shader_feature_fragment _REFLECTION_PROBE_BOX_PROJECTION
	// We don't need a keyword for this! the w component of the probe position already branches box vs non-box, & so little cost on pc it doesn't matter
	#define _REFLECTION_PROBE_BOX_PROJECTION 

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
#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
#pragma multi_compile_fog
#pragma skip_variants FOG_LINEAR FOG_EXP
//#pragma multi_compile_fragment _ DEBUG_DISPLAY
#pragma multi_compile_fragment _DETAILS_OFF _DETAILS_DEFAULT _DETAILS_MASKALBEDONORMAL 
#pragma multi_compile _METALLICTYPE_MAS _METALLICTYPE_METALLICSMOOTHNESS _METALLICTYPE_RMA _METALLICTYPE_MASK _METALLICTYPE_FLOATS
//#pragma multi_compile_fragment _ _EMISSION_ON
#pragma multi_compile_fragment _ _COLORMASK_ON

#if defined(LITMAS_FEATURE_LIGHTMAPPING)
	#pragma multi_compile _ LIGHTMAP_ON
	#pragma multi_compile _ DYNAMICLIGHTMAP_ON
	#pragma multi_compile _ DIRLIGHTMAP_COMBINED
	#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
#endif

#ifdef UNITY_COLORSPACE_GAMMA//ASE Color Space Def
#define unity_ColorSpaceDouble half4(2.0, 2.0, 2.0, 2.0)//ASE Color Space Def
#else // Linear values//ASE Color Space Def
#define unity_ColorSpaceDouble half4(4.59479380, 4.59479380, 4.59479380, 2.0)//ASE Color Space Def
#endif//ASE Color Space Def


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

// Begin Injection INCLUDES from Injection_SSR.hlsl ----------------------------------------------------------
#if !defined(SHADER_API_MOBILE)
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZLightingSSR.hlsl"
#endif
// End Injection INCLUDES from Injection_SSR.hlsl ----------------------------------------------------------

struct VertIn
{
	float4 vertex   : POSITION;
	float4 vertexColor : COLOR;
	float3 normal    : NORMAL;
	float4 tangent   : TANGENT;
	float4 uv0 : TEXCOORD0;
	float4 uv1 : TEXCOORD1;
	float4 uv2 : TEXCOORD2;

	#if ( _NORMALMAP || _PARALLAXMAP )
		float4 vTangentUOs_flTangentVSign : TANGENT;
	#endif

	#if ( MATRIX_PALETTE_SKINNING )
		float4 vBoneIndices : COLOR;
	#endif

	UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct VertOut
{
	float4 vertex       : SV_POSITION;
	float4 vertexColor  : COLOR;
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

	UNITY_VERTEX_INPUT_INSTANCE_ID
		UNITY_VERTEX_OUTPUT_STEREO
};

TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);

TEXTURE2D(_DetailAlbedoMap);
SAMPLER(sampler_DetailAlbedoMap);

TEXTURE2D(_BumpMap);

TEXTURE2D(_DetailMask);
TEXTURE2D(_DetailNormalMap);

TEXTURE2D(_MetallicGlossMap);
TEXTURE2D(_SpecGlossMap);

TEXTURE2D(_OcclusionMap);

TEXTURE2D(_ParallaxMap);

TEXTURE2D(_EmissionMap);

TEXTURE2D(_FluorescenceMap);
TEXTURE2D(_ColorMask);

CBUFFER_START(UnityPerMaterial)
	half4 		_Color;
	float4 		_MainTex_ST;
	float4 		_DetailAlbedoMap_ST;
	half 		_BumpScale;
	half        _DetailNormalMapScale;
	half        _Metallic;
	half        _Glossiness;
	half        _GlossMapScale;
	half        _OcclusionStrength;
	half        _Parallax;
	half        _UVSec;
	half4       _EmissionColor;
	float4		_FluorescenceColor;
	float4 		_Absorbance;
	//float		_Glossiness2;
	float3		_ColorShift1;
	float3		_ColorShift2;
	float3		_ColorShift3;
	float		_EmissionFalloff;
	float		g_flFresnelExponent;
	float 		Dotfresnel;
	float 		_NormalToOcclusion;
	float		_SpecMod;
	float		_ParallaxIterations;
	float		_ParallaxOffset;
	float 		_ColorMultiplier;
	float4 _SpecColor;
	float _SSRTemporalMul;
    // End Injection MATERIAL_CBUFFER from Injection_Emission.hlsl ----------------------------------------------------------
	int _Surface;
CBUFFER_END

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

float2 PremeczParallax( sampler2D hMap , float2 UVs , float2 View , int ITERATION , float BIAS, float SCALE )
{
	for(int i = 0; i < ITERATION; i++) 
	{
		float Normal = 1 - tex2D(hMap, UVs).b;
		float h = (Normal * SCALE) + BIAS;
		UVs += (h * Normal)  * View;
	}
	return UVs;
}

float3 Vec3TsToWs( float3 vVectorTs, float3 vNormalWs, float3 vTangentUWs, float3 vTangentVWs )
{
	float3 vVectorWs;
	vVectorWs.xyz = vVectorTs.x * vTangentUWs.xyz;
	vVectorWs.xyz += vVectorTs.y * vTangentVWs.xyz;
	vVectorWs.xyz += vVectorTs.z * vNormalWs.xyz;
	return vVectorWs.xyz; // Return without normalizing
}

float3 Vec3TsToWsNormalized( float3 vVectorTs, float3 vNormalWs, float3 vTangentUWs, float3 vTangentVWs )
{
	return normalize( Vec3TsToWs( vVectorTs.xyz, vNormalWs.xyz, vTangentUWs.xyz, vTangentVWs.xyz ) );
}

float3 BlendNormals(float3 n1, float3 n2)
{
    return normalize(float3(n1.xy + n2.xy, n1.z * n2.z));
}

VertOut vert(VertIn v)
{
	VertOut o = (VertOut)0;
	UNITY_SETUP_INSTANCE_ID(v);
	UNITY_TRANSFER_INSTANCE_ID(v, o);
	UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

	o.wPos = TransformObjectToWorld(v.vertex.xyz);
	o.vertex = TransformWorldToHClip(o.wPos);
	o.vertexColor = v.vertexColor;
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
	// EVRONOTE: Do worldalignedtexture stuff
    // End Injection VERTEX_END from Injection_SSR.hlsl ----------------------------------------------------------
	return o;
}

half4 frag(VertOut i) : SV_Target
{
	UNITY_SETUP_INSTANCE_ID(i);
	UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

	/*---------------------------------------------------------------------------------------------------------------------------*/
	/*---Read Input Data---------------------------------------------------------------------------------------------------------*/
	/*---------------------------------------------------------------------------------------------------------------------------*/
	
	float2 uv_main = mad(float2(i.uv0XY_bitZ_fog.xy), _MainTex_ST.xy, _MainTex_ST.zw);
	float2 uv_detail = mad(float2(i.uv0XY_bitZ_fog.xy), _DetailAlbedoMap_ST.xy, _DetailAlbedoMap_ST.zw);
	
	//---------------//
	// Tangent Space //
	//---------------//
	float3 vTangentUWs = float3( 1.0, 0.0, 0.0 );
	float3 vTangentVWs = float3( 0.0, 1.0, 0.0 );
	#if ( _NORMALMAP || _PARALLAXMAP )
	{
		//vTangentUWs.xyz = i.vTangentUWs.xyz;
		//vTangentVWs.xyz = i.vTangentVWs.xyz;
	}
	#endif

	
	//-----------------------//
	//		Parallaxing		//
	//---------------------//

	#if (_PARALLAXMAP)

	float3  CamDirTs =  CalculatePositionToCameraDirTs( i.vPositionWs.xyz, vTangentUWs, vTangentVWs, i.vNormalWs.xyz ) ;
	float2 planes = CamDirTs.zx / CamDirTs.y;
	float ite = round(_ParallaxIterations);
	float4 zTextureCoords = float4(0,0,0,0);
	//float2 tempUVs = IterativeParallax27_g1(  g_tParallax ,  uv_main , planes.xy  , ite , 0.0 , g_fParallaxScale / ite );
	zTextureCoords.xy = PremeczParallax(  g_tParallax ,  uv_main , planes.xy  , ite , _ParallaxOffset , g_fParallaxScale / ite );

	//Add parallaxing to detail maps //FIXIT!_!_!_!_!_!_!_!_!
	#if ( _DETAIL )
	 	zTextureCoords.zw = (( zTextureCoords.xy - uv_main) * _DetailAlbedoMap_ST.xy + i.vTextureCoords.zw) ;  
	#else
		zTextureCoords.zw = uv_main ;
	#endif			
	//Attempting to fix world pos for shadows
	// float3 tempt = float3(( -( zTextureCoords - uv_main ) ).xy, 0) + CamDirTs  ;
	// i.vPositionWs = Vec3TsToWsNormalized(tempt, i.vNormalWs.xyz, vTangentUWs, vTangentVWs );	
	#else 	
		#if ( _DETAIL )
		float4 zTextureCoords = float4(uv_main, uv_detail);
		#else
		float2 zTextureCoords = uv_main;
		#endif	
	#endif

	//---------------//
	// MAS Unpacking //
	//---------------//

	#if (S_PACKING_MAES)
	// R,G,B,A = Metallic, AO, Smoothness, Emission
	//Unpack  M A E S to R G A B	// Shifting smoothness to B compress to float3 in RMA 
	float4 unPackedTexture = SAMPLE_TEXTURE2D(_MetallicGlossMap, sampler_BaseMap, zTextureCoords.xy).rgab;

	#elif (S_PACKING_RMA)
	//Unpack R M A to B R G    R, G, B = Metallic, AO, 1-Roughness
	float3 unPackedTexture = SAMPLE_TEXTURE2D(_MetallicGlossMap, sampler_BaseMap, zTextureCoords.xy).gbr * float3( 1.0, 1.0, -1.0 ) + float3( 0.0, 0.0, 1.0 );

	#elif (S_PACKING_MAS)
	//Unpack M A S to 
	float3 unPackedTexture = SAMPLE_TEXTURE2D(_MetallicGlossMap, sampler_BaseMap, zTextureCoords.xy).rgb;	
	#endif

	//--------//
	// Normal //
	//--------//
	float3 vGeometricNormalWs = float3( 0.0, 0.0, 1.0 );
	#if ( !S_UNLIT )
	{
		vGeometricNormalWs.xyz = normalize(i.normXYZ_tanX.xyz);
	}
	#endif

	float3 vNormalWs = vGeometricNormalWs.xyz;
	float3 vNormalTs = float3( 0.0, 0.0, 1.0 );
	#if ( _NORMALMAP )
	{
		vNormalTs.xyz = UnpackNormalScale( SAMPLE_TEXTURE2D( _BumpMap, sampler_MainTex, zTextureCoords.xy ), _BumpScale );
		//vNormalTs.y = -vNormalTs.y;

		// Apply detail to tangent normal
		#if ( _DETAIL )
		{
			float flDetailMask = SAMPLE_TEXTURE2D(_DetailMask, sampler_DetailAlbedoMap, zTextureCoords.xy).a;
			float3 vDetailNormalTs = UnpackNormalScale( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_DetailAlbedoMap, zTextureCoords.zw ), _DetailNormalMapScale );
			#if ( _DETAIL_LERP )
			{
				vNormalTs.xyz = lerp( vNormalTs.xyz, vDetailNormalTs.xyz, flDetailMask );
			}
			#else				
			{
				vNormalTs.xyz = lerp( vNormalTs.xyz, BlendNormals( vNormalTs.xyz, vDetailNormalTs.xyz ), flDetailMask );
			}
			#endif
		}
		#endif

		// Convert to world space
		//vNormalWs.xyz = Vec3TsToWsNormalized( vNormalTs.xyz, vGeometricNormalWs.xyz, vTangentUWs.xyz, vTangentVWs.xyz  );

		// LitMAS Normal TsToWs
		half3 normalWS = i.normXYZ_tanX.xyz;
		half3x3 TStoWS = half3x3(
			i.normXYZ_tanX.w, i.tanYZ_bitXY.z, normalWS.x,
			i.tanYZ_bitXY.x, i.tanYZ_bitXY.w, normalWS.y,
			i.tanYZ_bitXY.y, i.uv0XY_bitZ_fog.z, normalWS.z
			);
		vNormalWs.xyz = normalize(mul(TStoWS, vNormalTs));

		//vNormalWs.xyz += ScreenSpaceDither( i.vPositionPs.xy ).xyz * 30.2;

	}
	#endif

	//--------//
	// Albedo //
	//--------//

	float4 vAlbedoTexel = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, zTextureCoords.xy ) * _Color;
	float3 vAlbedo = vAlbedoTexel.rgb;

	#if ( _DETAIL )
	{
		float flDetailMask = SAMPLE_TEXTURE2D(_DetailMask, sampler_DetailAlbedoMap, zTextureCoords.xy).a;
		float3 vDetailAlbedo = SAMPLE_TEXTURE2D( _DetailAlbedoMap, sampler_DetailAlbedoMap, zTextureCoords.zw ).rgb;
		#if ( _DETAIL_MULX2 )
			vAlbedo.rgb *= LerpWhiteTo( vDetailAlbedo.rgb * unity_ColorSpaceDouble, flDetailMask );
		#elif ( _DETAIL_MUL )
			vAlbedo.rgb *= LerpWhiteTo( vDetailAlbedo.rgb, flDetailMask );
		#elif ( _DETAIL_ADD )
			vAlbedo.rgb += vDetailAlbedo.rgb * flDetailMask;
		#elif ( _DETAIL_LERP )
			vAlbedo.rgb = lerp( vAlbedo.rgb, vDetailAlbedo.rgb, flDetailMask );
		#endif
	}
	#endif

	#if ( !S_UNLIT || _ALPHAPREMULTIPLY_ON  )
		float3 cameraPos = _WorldSpaceCameraPos; // Unity provides the camera's world position
		float3 viewDir = normalize(cameraPos - i.wPos.xyz);
		Dotfresnel = saturate(dot( vNormalWs.xyz , viewDir ));	
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
    float metallicSenderBalls = 0;
	#if ( S_SPECULAR_METALLIC )
	{
		float2 vMetallicGloss;// = MetallicGloss( i.vTextureCoords.xy );
		#ifdef _METALLICGLOSSMAP
			#if ( S_PACKING_MAES ||  S_PACKING_RMA || S_PACKING_MAS )
			vMetallicGloss.xy = unPackedTexture.rb;
			#else
			vMetallicGloss.xy = SAMPLE_TEXTURE2D(_MetallicGlossMap, sampler_MainTex, zTextureCoords.xy).ra;
			#endif

		#else
			vMetallicGloss.xy = half2(_Metallic, _Glossiness);
		#endif

		//TEMPCOMMENT - This should happen automatically in slz fragment pbr stuff
		//float flOneMinusReflectivity;
		//float3 vSpecColor;
		//float3 diffColor = SLZAlbedoSpecularFromMetallic( vAlbedo.rgb, vMetallicGloss.x, /*out*/ vSpecColor, /*out*/ flOneMinusReflectivity);
		//vAlbedo.rgb = diffColor.rgb;
		//vReflectance.rgb = vSpecColor.rgb;
		metallicSenderBalls = vMetallicGloss.x;
		flGloss.x = vMetallicGloss.y;
	}
	#elif ( S_SPECULAR_BLINNPHONG )
	{
		float4 vReflectanceGloss; // = SpecularGloss( i.vTextureCoords.xy );
		#ifdef _SPECGLOSSMAP
			vReflectanceGloss.rgba = SAMPLE_TEXTURE2D(_SpecGlossMap, sampler_MainTex, zTextureCoords.xy);
		#else
			vReflectanceGloss.rgba = float4(_SpecColor.rgb, _Glossiness);
		#endif

		// Yea i do not know what this does
		//vReflectanceGloss.rgb = ( vReflectanceGloss.rgb * g_flReflectanceScale.xxx ) + g_flReflectanceBias.xxx;
		
		vReflectance.rgb = vReflectanceGloss.rgb;
		flGloss.x = vReflectanceGloss.a;
	}

	#elif ( S_ANISOTROPIC_GLOSS  )
	{
		//x = Metallic, y = Gloss, z = Rotation, w = Ratio
		float4 vMetallicGloss;// = MetallicGloss( i.vTextureCoords.xy );
		#ifdef _METALLICGLOSSMAP
			vMetallicGloss.xyzw = SAMPLE_TEXTURE2D(_MetallicGlossMap, sampler_MainTex, zTextureCoords.xy ).ragb;	
			vMetallicGloss.z = frac(vMetallicGloss.z + _AnisotropicRotation);
			//+ ScreenSpaceDither( zTextureCoords.xy * 256 ).xy * 0.2 

		#else
			vMetallicGloss.xyzw = half4(_Metallic, _Glossiness, _AnisotropicRotation, _AnisotropicRatio);
		#endif

		// TEMPCOMMENT - This should happen automatically in slz fragment pbr stuff
		// float flOneMinusReflectivity;
		// float3 vSpecColor;
		// float3 diffColor = DiffuseAndSpecularFromMetallic( vAlbedo.rgb, vMetallicGloss.x, /*out*/ vSpecColor, /*out*/ flOneMinusReflectivity);
		// vAlbedo.rgb = diffColor.rgb;

		// vReflectance.rgb = vSpecColor.rgb;
		metallicSenderBalls = vMetallicGloss.x;
		flGloss.xyz = vMetallicGloss.yzw;
	}

	#elif ( S_RETROREFLECTIVE )
	{
		float normalBlend = saturate( Dotfresnel );
		normalBlend = pow (normalBlend , 0.25);

		float2 vMetallicGloss;
		#ifdef _METALLICGLOSSMAP
			vMetallicGloss.xy = SAMPLE_TEXTURE2D(_MetallicGlossMap, sampler_MainTex  zTextureCoords.xy).ra;
		#else
			vMetallicGloss.xy = half2(_Metallic, _Glossiness);
		#endif

		// TEMPCOMMENT
		// float flOneMinusReflectivity;
		// float3 vSpecColor;
		// float3 diffColor = DiffuseAndSpecularFromMetallic( vAlbedo.rgb, vMetallicGloss.x, /*out*/ vSpecColor, /*out*/ flOneMinusReflectivity);
		// vAlbedo.rgb = diffColor.rgb;

		// vReflectance.rgb = vSpecColor.rgb;
		metallicSenderBalls = vMetallicGloss.x;
		flGloss.x = vMetallicGloss.y ;//* normalBlend;
	}


	#endif

	// TEMPCOMMENT
	vRoughness.xyz = float3( ( 1.0 - saturate(flGloss.x * _SpecMod) ), flGloss.y, flGloss.z );

	// #if ( !S_SPECULAR_NONE )
	// {
	// 	vRoughness.x = AdjustRoughnessByGeometricNormal( vRoughness.x, vGeometricNormalWs.xyz );
	// }
	// #endif

	#if ( _COLORMASK_ON )
	{
		float3 ColorMaskTex = 1 - SAMPLE_TEXTURE2D(_ColorMask, sampler_MainTex, uv_main).rgb ;
		float3 ColorShifter = max(_ColorShift1.rgb, ColorMaskTex.rrr) * max(_ColorShift2.rgb, ColorMaskTex.ggg) * max(_ColorShift3.rgb, ColorMaskTex.bbb);
		vAlbedo.rgb *= ColorShifter;
	}
	#endif


	/*---------------------------------------------------------------------------------------------------------------------------*/
	/*---Sample Normal Map-------------------------------------------------------------------------------------------------------*/
	/*---------------------------------------------------------------------------------------------------------------------------*/

	half3 normalTS = half3(0, 0, 1);
	half  geoSmooth = 1;
	half4 normalMap = half4(0, 0, 1, 0);

	// Begin Injection NORMAL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
	//normalMap = SAMPLE_TEXTURE2D(_BumpMap, sampler_MainTex, uv_main);
	//normalTS = UnpackNormal(normalMap);
	//normalTS = _Normals ? normalTS : half3(0, 0, 1);
	//geoSmooth = _Normals ? normalMap.b : 1.0;
	//smoothness = saturate(smoothness + geoSmooth - 1.0);


	/*---------------------------------------------------------------------------------------------------------------------------*/
	/*---Transform Normals To Worldspace-----------------------------------------------------------------------------------------*/
	/*---------------------------------------------------------------------------------------------------------------------------*/

	// Begin Injection NORMAL_TRANSFORM from Injection_NormalMaps.hlsl ----------------------------------------------------------
	//half3 normalWS = i.normXYZ_tanX.xyz;
	//half3x3 TStoWS = half3x3(
	//	i.normXYZ_tanX.w, i.tanYZ_bitXY.z, normalWS.x,
	//	i.tanYZ_bitXY.x, i.tanYZ_bitXY.w, normalWS.y,
	//	i.tanYZ_bitXY.y, i.uv0XY_bitZ_fog.z, normalWS.z
	//	);
	//normalWS = mul(TStoWS, normalTS);
	//normalWS = normalize(normalWS);
	// End Injection NORMAL_TRANSFORM from Injection_NormalMaps.hlsl ----------------------------------------------------------


	/*---------------------------------------------------------------------------------------------------------------------------*/
	/*---Lighting Calculations---------------------------------------------------------------------------------------------------*/
	/*---------------------------------------------------------------------------------------------------------------------------*/
	
	// Begin Injection SPEC_AA from Injection_NormalMaps.hlsl ----------------------------------------------------------
	//#if !defined(SHADER_API_MOBILE) && !defined(LITMAS_FEATURE_TP) // Specular antialiasing based on normal derivatives. Only on PC to avoid cost of derivatives on Quest
	//    vMetallicGloss.y = min(vMetallicGloss.y, SLZGeometricSpecularAA(normalWS));
	//#endif
	// End Injection SPEC_AA from Injection_NormalMaps.hlsl ----------------------------------------------------------


	#if defined(LIGHTMAP_ON)
		SLZFragData fragData = SLZGetFragData(i.vertex, i.wPos, vNormalWs, i.uv1.xy, i.uv1.zw, i.SHVertLights.xyz);
	#else
		SLZFragData fragData = SLZGetFragData(i.vertex, i.wPos, vNormalWs, float2(0, 0), float2(0, 0), i.SHVertLights.xyz);
	#endif

	

	//---------------------//
	// VRStandard Emission //
	//---------------------//
	#ifdef S_PACKING_MAES
		float3 vEmission = unPackedTexture.a * _EmissionColor ;
	#else
		float3 vEmission = SAMPLE_TEXTURE2D(_EmissionMap, sampler_MainTex, zTextureCoords.xy ) * _EmissionColor;
	#endif
	#if (!S_UNLIT)					
		vEmission *= saturate( pow(Dotfresnel , _EmissionFalloff * 2));	
	#endif
	#if (S_EMISSIVE_MULTI)
		vEmission.rgb *= AlbedoPreMetal.rgb;
	#endif
	

	SLZSurfData surfData = SLZGetSurfDataMetallicGloss(vAlbedo.rgb, saturate(metallicSenderBalls), saturate(flGloss.x), 1, vEmission.rgb, 1.0 /*albedo.a*/);
	half4 color = half4(1, 1, 1, 1);

	#if ( S_ANISOTROPIC_GLOSS )
		SLZSurfDataAddAniso(surfData, _AnisotropicRatio)
		SLZFragDataAddAniso(fragData, TStoWS._m00_m10_m20, TStoWS._m01_m11_m21, surfData.roughnessT, surfData.roughnessB)
	#endif

	//---------------------------//
	// SSR Lighting Calculations //
	//---------------------------//
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

	//----------------//
	// Vertex Tinting //
	//----------------//
	#if ( _VERTEXTINT )
		outputColor.rgb *= i.vertexColor.xyz;
	#endif

	// Begin Injection VOLUMETRIC_FOG from Injection_SSR.hlsl ----------------------------------------------------------
	#if !defined(_SSR_ENABLED)
		color = MixFogSurf(color, -fragData.viewDir, i.uv0XY_bitZ_fog.w, _Surface);
		
		color = VolumetricsSurf(color, fragData.position, _Surface);
	#endif
	
	return color;
}
