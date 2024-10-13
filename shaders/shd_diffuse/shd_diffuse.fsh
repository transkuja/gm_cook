// Normal Lighting system
// Run this shader for each light using additive blending to surface
// (that surface should be cleared first with ambience color/image)
// Then using multiply blending, draw that surface to screen.
// Input tex: Normal map.
//
const float PI = 3.14159265358979323844;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 res;
uniform vec3 lightPos;
uniform vec3 lightDir;
uniform vec2 spot; //spot.x = cosCutoff, spot.y = spot attenuation power
uniform vec4 lightColor;
uniform float lightRad;
uniform float type;
uniform bool shadows;

uniform sampler2D depthMap;

vec3 saturate(in vec3 rgb,in float adjustment)
{
    // Algorithm from Chapter 16 of OpenGL Shading Language
    const vec3 W = vec3(0.2125, 0.7154, 0.0721);
    vec3 intensity = vec3(dot(rgb, W));
    return mix(intensity, rgb, adjustment);
}

float atan2(in float yy, in float xx)
{
    if(abs(xx) > abs(yy)){
		return atan(yy,xx);
	} else {
		return PI/2.0-atan(xx,yy);
	}
}

float inShadows(vec3 rayDir, float texCoordDepth)
{
	if(shadows){
		float rayLength = length(rayDir);
		rayDir = rayDir.xyz/rayLength;
		for(float ray = 1.0; ray < rayLength; ray+=1.0){
			
			vec3 rayPos = rayDir*vec3(ray);
			float depthTest = texture2D( depthMap, v_vTexcoord+(rayPos.xy/res.xy) ).r;
			if(depthTest == 0.0){ continue; }
			depthTest = depthTest*res.z;
			if(depthTest > texCoordDepth+rayPos.z){
				discard;
				return 0.0;
			}
		}
	}
	
	return 1.0;	
}

void main()
{
    vec4 normal = texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 depth = texture2D( depthMap, v_vTexcoord );
    //vec3 lightDir;
    float D;
    float normD;
	float spotAtt = 1.0;
	float cutoff = 1.0;
	vec3 texDir;
    if(type == 0.0){
		//pointLight - lightDir not used
        texDir.xy = (lightPos.xy - v_vTexcoord) * res.xy;
        texDir.z = lightPos.z - depth.r*res.z;
		cutoff = inShadows(texDir,depth.r*res.z);
		D = length(texDir);
        normD = D / lightRad;
		texDir.y = -texDir.y;
    } else {
	if(type == 1.0){
		//directional light - lightPos not used
        //lightDir = lightPos;
		texDir = lightDir;
		texDir.y = -texDir.y;
		cutoff = inShadows(texDir*100.0,depth.r*res.z);
        D = 1.0;
        normD = 0.0;
		texDir.y = -texDir.y;
    } else {
	if(type == 2.0){
		//testing spot light
		texDir.xy = (lightPos.xy - v_vTexcoord) * res.xy;
		texDir.z = lightPos.z - depth.r*res.z;
		D = length(texDir);
		normD = D / lightRad;
		float spotCos = dot(lightDir,texDir/D);
		if(spotCos<spot.x){ discard; }
		spotAtt = pow(max(spotCos-spot.x,0.0),spot.y);
		cutoff = inShadows(lightDir*D,depth.r*res.z);
	}}}
	//vec3 finalLight = vec3(0.0);
	vec3 N = normalize(normal.rgb * 2.0 - 1.0);
	vec3 L = texDir.xyz/D;
        
	vec3 Diffuse = (lightColor.rgb * lightColor.a) * max(dot(N, L), 0.0);
	float attenuation = max((1.0 - normD*normD), 0.0);
	attenuation = attenuation*attenuation * spotAtt;
	vec3 finalLight = saturate(Diffuse * attenuation , (2.0-attenuation)*(2.0-attenuation));
	
    gl_FragColor = v_vColour * vec4(vec3(cutoff)*finalLight.rgb, normal.a);
}