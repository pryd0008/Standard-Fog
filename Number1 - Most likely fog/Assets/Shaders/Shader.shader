Shader "Unlit/Shader"
{
	Properties
	{
		_Colour("Colour", Color) = (1,1,1,0)
		_FogColour("Fog", Color) = (0.5,0.6,0.7)
		_CameraPos("Camera", Vector) = (1,1,1,1)
	}
	SubShader
	{
		Cull Off 
		ZWrite Off 
		ZTest Always
		Blend OneMinusSrcAlpha SrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			struct vertAttrib
			{
				float4 pos : POSITION0;
				float4 col : COLOR0;
				float2 depth : TEXCOORD0;
			};

			struct fragAttrib
			{
				float4 pos : POSITION0;
				float4 globalPos : POSITION1;
				float4 col : COLOR0;
				float2 depth : TEXCOORD0;
			};

			float4 _Colour;
			float4 _FogColour;
			float4 _CameraPos;

			fragAttrib vert(vertAttrib vertIn)
			{
				fragAttrib val;
				val.globalPos = mul(_Object2World, vertIn.pos);
				val.pos = mul(UNITY_MATRIX_MVP, vertIn.pos);
				val.col = _Colour;
				UNITY_TRANSFER_DEPTH(val.depth);
				return val;
			}

			float4 frag(fragAttrib vertOut) : COLOR0
			{
				UNITY_OUTPUT_DEPTH(vertOut.depth);
				float4 fragOut = vertOut.col;
				



				/*float depth = vertOut.depth;
				float4 H = float4((vertOut.pos.x) * 2 - 1, (vertOut.pos.y) * 2 - 1, depth, 1);
				float4 D = mul((UNITY_MATRIX_P * -_World2Object), (_CameraPos, H)); // passed from your script
				return D / D.w;
				*/





				float4 vec;
				vec.x = vertOut.globalPos.x - _CameraPos.x;
				vec.y = vertOut.globalPos.y - _CameraPos.y;
				vec.z = vertOut.globalPos.z - _CameraPos.z;

				float beta = 0.5f;
				float distance = sqrt((vec.x * vec.x) + (vec.y * vec.y) + (vec.z * vec.z));
				//float fogAmount = 1.0 - exp(-distance* beta);
				fragOut = vertOut.col*(1.0 - exp(-distance*beta)) + _FogColour*exp(-distance*beta);

				return fragOut;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
