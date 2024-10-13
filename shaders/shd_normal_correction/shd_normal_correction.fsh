// Rotate and flip normal map
// Inputs: rotation- cos(angle),sin(angle) signScale- sign(xscale),sign(yscale),(no zero)
// Default tex: normal map
// Output: Fixed normal map
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 rotation;    //x=cos(angle),y=sin(angle)
uniform vec2 signScale;   //x=sign(xscale),y=sign(yscale)

void main()
{
    vec4 normColor = texture2D( gm_BaseTexture, v_vTexcoord );
    vec3 normal = normColor.rgb;
    vec2 tempNorm = vec2(0.0, 0.0);
    //change scale to -1.0 to 1.0
    normal.rgb = normalize(normal.rgb * 2.0 - 1.0);
    //flip normals for negative scale
    normal.x = normal.x * signScale.x;
    normal.y = normal.y * signScale.y;
    //rotate normals for rotated sprites
    tempNorm.x = normal.x * rotation.x - normal.y * rotation.y;
    tempNorm.y = normal.x * rotation.y + normal.y * rotation.x;
    normal.x = tempNorm.x;
    normal.y = tempNorm.y;
    //change scale to 0.0 to 1.0
    normal.rgb = (normal.rgb + 1.0) / 2.0;
    
    gl_FragColor = v_vColour * vec4(normal.rgb,normColor.a);
}