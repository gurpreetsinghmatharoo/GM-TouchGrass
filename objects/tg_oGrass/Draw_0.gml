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

if (instance_exists(playerInst)) {
	shader_set_uniform_f(uniPlayerPos, playerInst.x, playerInst.bbox_bottom);
	shader_set_uniform_f(uniPlayerRadius, playerRadius);
	shader_set_uniform_f(uniCollisionBend, collisionBend);
}

vertex_submit(vbMain, pr_trianglelist, -1);

shader_reset();