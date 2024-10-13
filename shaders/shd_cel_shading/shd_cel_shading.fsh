//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

const float numColors = 3.0;

void main()
{   
    vec3 myColor = texture2D( gm_BaseTexture, v_vTexcoord ).rgb;
    float L = 0.5 * ( min( myColor.r, min( myColor.g, myColor.b)) + max( myColor.r, max( myColor.g, myColor.b)) );
    float newL = floor( L * numColors + 0.5 ) / numColors;
    float deltaL = newL - L;
    vec3 myNewColor;
    if(deltaL > 0.0){
        myNewColor.rgb = (1.0 - myColor.rgb) * deltaL + myColor.rgb;
    } else {
        myNewColor.rgb = myColor.rgb * deltaL + myColor.rgb;
    }
    gl_FragColor = v_vColour * vec4(myNewColor.rgb,1.0);
}
