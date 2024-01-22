// Camera check
var _cam = tg_oManager.mainCamera;

if (_cam != -1) {
	var _camX = camera_get_view_x(_cam);
	var _camY = camera_get_view_y(_cam);
	var _camW = camera_get_view_width(_cam);
	var _camH = camera_get_view_height(_cam);
	if (!rectangle_in_rectangle(x, y - (bladeHeight + bladeHeightJitter), x + sprite_width, y + sprite_height, _camX, _camY, _camX + _camW, _camY + _camH)) {
		exit;
	}
}

// Draw grass
shader_set(tg_shGrass);

shader_set_uniform_f(uniTime, (current_time / 1000) * 60);

// Collider uniforms
if (instance_exists(playerInst)) {
	shader_set_uniform_f(uniPlayerPos, playerInst.x + collisionXOffset, playerInst.bbox_bottom + collisionYOffset);
	shader_set_uniform_f(uniPlayerRadius, playerRadius);
	shader_set_uniform_f(uniCollisionBend, collisionBend);
	shader_set_uniform_f(uniYOffset, collisionYBend);
}

// Wind 1 uniforms
texture_set_stage(uniWind1Texture, wind1Texture);
shader_set_uniform_f(uniWind1Uvs, wind1Uvs[0], wind1Uvs[1], wind1Uvs[2], wind1Uvs[3]);
shader_set_uniform_f_array(uniWind1Texels, wind1Texels);
shader_set_uniform_f(uniWind1Power, wind1Power);
shader_set_uniform_f(uniWind1Speed, lengthdir_x(wind1Speed, wind1Direction), lengthdir_y(wind1Speed, wind1Direction));
shader_set_uniform_f(uniWind1Scale, wind1Scale);

vertex_submit(vbMain, pr_trianglelist, -1);

shader_reset();