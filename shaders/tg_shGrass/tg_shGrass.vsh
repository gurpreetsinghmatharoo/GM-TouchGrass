//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Normal;                  // (x,y,z)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float playerRadius;
uniform vec2 playerPos;
uniform float bend;

void main()
{
	vec2 bottomPos = vec2(in_Normal.x, in_Normal.y);
    float dist = distance(bottomPos, playerPos);
	float distNorm = max(0., 1. - (dist / playerRadius));
	
	vec2 offsetToPlayer = playerPos - bottomPos;
	vec2 offsetToPlayerNorm = offsetToPlayer / playerRadius;
	
	vec2 bladeOffset = -offsetToPlayerNorm * distNorm * bend;
	
	vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
	object_space_pos.xy += bladeOffset;
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;//vec4(distNorm, distNorm, distNorm, 1.);
    v_vTexcoord = in_TextureCoord;
}
