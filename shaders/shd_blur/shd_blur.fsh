//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform vec2 offset;

float luminance(in vec3 rgb)
{
    // Algorithm from Chapter 16 of OpenGL Shading Language
    const vec3 W = vec3(0.2125, 0.7154, 0.0721);
    return dot(rgb, W);
}

void main()
{
	vec4 base = texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 col = base * 0.2270270270;
	col += texture2D( gm_BaseTexture, v_vTexcoord + vec2(1.3846153846) * offset ) * 0.3162162162;
	col += texture2D( gm_BaseTexture, v_vTexcoord - vec2(1.3846153846) * offset ) * 0.3162162162;
	col += texture2D( gm_BaseTexture, v_vTexcoord + vec2(3.2307692308) * offset ) * 0.0702702703;
	col += texture2D( gm_BaseTexture, v_vTexcoord - vec2(3.2307692308) * offset ) * 0.0702702703;
	float lumi = luminance(base.rgb);
	gl_FragColor = col; //mix(col,base,lumi*lumi*lumi*lumi);
}
