//
// Takes 2 textures and runs through the normal fixing for spine sprites
//
varying vec2 v_vBTexcoord;
varying vec2 v_vNTexcoord;
varying vec4 v_vColour;

uniform sampler2D boneMapTex;
uniform sampler2D normalMapTex;
uniform float xscale[31];
uniform float yscale[31];
uniform float xrot[31];
uniform float yrot[31];

void main()
{
    int attachmentID = int( floor(255.0 * texture2D( boneMapTex, v_vBTexcoord ).r + 0.5) );
    vec2 signScale = vec2( xscale[attachmentID] , yscale[attachmentID] );
    vec2 rotation = vec2( xrot[attachmentID] , yrot[attachmentID] );
    vec4 normColor = texture2D( normalMapTex, v_vNTexcoord );
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
