//
// Draw spine image using a second texture
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D altTex;

void main()
{    
    gl_FragColor = v_vColour * texture2D( altTex, v_vTexcoord );
}