//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;                  // (x,y,z)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Collider uniforms
uniform float playerRadius;
uniform vec2 playerPos;
uniform float bend;
uniform float yOffset;

// Wind uniforms

uniform sampler2D wind1Texture;
uniform vec4 wind1Uvs;
uniform vec2 wind1Texels;
uniform float wind1Power;
uniform vec2 wind1Speed;
uniform float wind1Scale;


float rand(vec2 c){
	return fract(sin(dot(c.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float noise(vec2 p, float freq ){
	float unit = 1./freq;
	vec2 ij = floor(p/unit);
	vec2 xy = mod(p,unit)/unit;
	//xy = 3.*xy*xy-2.*xy*xy*xy;
	xy = .5*(1.-cos(3.14 * xy));
	float a = rand((ij+vec2(0.,0.)));
	float b = rand((ij+vec2(1.,0.)));
	float c = rand((ij+vec2(0.,1.)));
	float d = rand((ij+vec2(1.,1.)));
	float x1 = mix(a, b, xy.x);
	float x2 = mix(c, d, xy.x);
	return mix(x1, x2, xy.y);
}

float pNoise(vec2 p, int res){
	float persistance = .5;
	float n = 0.;
	float normK = 0.;
	float f = 4.;
	float amp = 1.;
	int iCount = 0;
	for (int i = 0; i<50; i++){
		n+=amp*noise(p, f);
		f*=2.;
		normK+=amp;
		amp*=persistance;
		if (iCount == res) break;
		iCount++;
	}
	float nf = n/normK;
	return nf*nf*nf*nf;
}

void main()
{
	// Blade properties
	vec2 bottomPos = vec2(in_Normal.x, in_Normal.y);
	float height = (in_Position.y - in_Normal.y) / in_Normal.z;
	
	// Get wind1 colour
	vec2 wind1Pos = in_Position.xy / wind1Scale;
	wind1Pos = mod(wind1Pos, 1.);
	wind1Pos.x = min(0.9, wind1Pos.x) - max(0., wind1Pos.x - 0.9);
	wind1Pos.y = min(0.9, wind1Pos.y) - max(0., wind1Pos.y - 0.9);
	//wind1Pos = wind1Uvs.xy + wind1Pos * (wind1Uvs.zw - wind1Uvs.xy);
	//vec4 wind1Frag = texture2DLod(wind1Texture, wind1Pos, 1.);
	float wind1Noise = pNoise(wind1Pos * 4., 2);
	
	// Wind
	vec2 windOffset = vec2(wind1Noise * sign(wind1Speed.x), wind1Noise * sign(wind1Speed.y)) * wind1Power * height;
	
	// Collider
	// Calculate offset to move
    float dist = distance(bottomPos, playerPos);
	float distNorm = max(0., 1. - (dist / playerRadius));
	
	vec2 offsetToPlayer = playerPos - bottomPos;
	vec2 offsetToPlayerNorm = ceil(abs(offsetToPlayer / playerRadius)) * sign(offsetToPlayer);
	offsetToPlayerNorm.y /= 2.;
	
	vec2 bladeOffset = offsetToPlayerNorm * distNorm * bend;
	
	// Factor in height
	bladeOffset *= height;
	
	// Y offset
	bladeOffset.y = -distNorm * yOffset * height * in_Normal.z;
	
	// Apply offset
	//in_TextureCoord.x = bladeOffset.x;
	
	// Apply the rest
	vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
	object_space_pos.xy += bladeOffset + windOffset;
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour + vec4(wind1Noise, wind1Noise, wind1Noise, 1.) * 0.4;
    v_vTexcoord = in_TextureCoord;
}