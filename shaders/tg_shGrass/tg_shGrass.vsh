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
uniform float time;
uniform float wind1Power;
uniform vec2 wind1Speed;
uniform float wind1Scale;


// Noise functions
// by Xor (https://gmshaders.com/tutorials/tips_and_tricks/)
float hash(vec2 p)
{
    p = mod(p, 7.31); //Bring 'p' to a useful range.
    //Generate a pseudo random number from 'p'.
    return fract(sin(p.x*12.9898 + p.y*78.233) * 43758.5453);
}
float value_noise(vec2 pos)
{
    vec2 cell = floor(pos); //Cell (whole number) coordinates.
    vec2 sub = pos-cell; //Sub-cell (fractional) coordinates.
    sub *= sub*(3.-2.*sub); //Cubic interpolation (comment out for linear interpolation).
    const vec2 off = vec2(0,1); //Offset vector.

    //Sample cell corners and interpolate between them.
    return mix( mix(hash(cell+off.xx), hash(cell+off.yx), sub.x),
                mix(hash(cell+off.xy), hash(cell+off.yy), sub.x), sub.y);
}
float fractal_noise(vec2 pos, int oct, float amp)
{
    float noise_sum = 0.; //Noise total.
    float weight_sum = 0.; //Weight total.
    float weight = 1.; //Octave weight.

    for(int i = 0; i < oct; i++) //Iterate through octaves
    {
        noise_sum += value_noise(pos) * weight; //Add noise octave.
        weight_sum += weight; //Add octave weight.
        weight *= amp; //Reduce octave amplitude by multiplier.
        pos *= mat2(1.6,1.2,-1.2,1.6); //Rotate and scale.
    }
    return noise_sum/weight_sum; //Compute average.
}

// Main
void main()
{
	// Blade properties
	vec2 bottomPos = vec2(in_Normal.x, in_Normal.y);
	float height = (in_Position.y - in_Normal.y) / in_Normal.z;
	
	// Get wind1 noise value
	vec2 wind1Pos = (in_Position.xy - wind1Speed * time) / wind1Scale;
	//wind1Pos = mod(wind1Pos, 1.);
	float wind1Noise = fractal_noise(wind1Pos * 4., 2, 0.5);
	
	// Wind
	float windEffect = wind1Power * -abs(height * height);
	vec2 windOffset = -vec2(wind1Noise * sign(wind1Speed.x), wind1Noise * sign(wind1Speed.y)) * windEffect;
	windOffset.y -= windEffect * wind1Noise;
	
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
	
	// Apply the rest
	vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
	object_space_pos.xy += bladeOffset + windOffset;
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;/*vec4(wind1Noise, wind1Noise, wind1Noise, 1.);*/
    v_vTexcoord = in_TextureCoord;
}