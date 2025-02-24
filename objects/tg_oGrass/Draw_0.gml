// Camera check
var _cam = tg_oManager.mainCamera;

if (_cam != -1) {
	var _camX = camera_get_view_x(_cam);
	var _camY = camera_get_view_y(_cam);
	var _camW = camera_get_view_width(_cam);
	var _camH = camera_get_view_height(_cam);
	if (!rectangle_in_rectangle(cullX1, cullY1 - (bladeHeight + bladeHeightJitter), cullX2, cullY2, _camX, _camY, _camX + _camW, _camY + _camH)) {
		exit;
	}
}

// Draw grass
shader_set(tg_shGrass);

shader_set_uniform_f(uniTime, grassTime * 60);

// Collider uniforms
if (instance_exists(playerInst)) {
	shader_set_uniform_f(uniPlayerPos, playerInst.x + collisionXOffset, playerInst.bbox_bottom + collisionYOffset);
	shader_set_uniform_f(uniPlayerRadius, playerRadius);
	shader_set_uniform_f(uniCollisionBend, collisionBend);
	shader_set_uniform_f(uniYOffset, collisionYBend);
}
else {
	shader_set_uniform_f(uniPlayerPos, -10000, -10000);
	shader_set_uniform_f(uniPlayerRadius, 1);
	shader_set_uniform_f(uniCollisionBend, 1);
	shader_set_uniform_f(uniYOffset, 1);
}

// Wind 1 uniforms
shader_set_uniform_f(uniWind1Power, wind1Power);
shader_set_uniform_f(uniWind1Speed, lengthdir_x(wind1Speed, wind1Direction), lengthdir_y(wind1Speed, wind1Direction), wind1Speed);
shader_set_uniform_f(uniWind1Scale, wind1Scale);

vertex_submit(vbMain, pr_trianglelist, -1);

shader_reset();