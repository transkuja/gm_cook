//
// Draw spine image using a second texture
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D altTex;


void main()
{    
	vec4 texColor = texture2D( altTex, v_vTexcoord );
	gl_FragColor = vec4(vec3(v_vColour.r) * texColor.rgb + vec3(v_vColour.g),texColor.a);
}