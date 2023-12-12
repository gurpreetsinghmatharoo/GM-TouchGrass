gpu_set_ztestenable(true)

// Define format
vertex_format_begin();

vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_custom(vertex_type_float2, vertex_usage_position); // Velocity

vfMain = vertex_format_end();

// Create vbuff
vbMain = vertex_create_buffer();

vertex_begin(vbMain, vfMain);

var _bladeInfo = new BladeInfo();
_bladeInfo.baseThickness = bladeBaseThickness;
_bladeInfo.height = bladeHeight;
_bladeInfo.divs = bladeDivs;
_bladeInfo.baseColour = bladeBaseColour;
_bladeInfo.tipColour = bladeTipColour;

var _x2 = x + sprite_width, _y2 = y + sprite_height;
for (var _x = x; _x <= _x2; _x += bladeDist) {
	for (var _y = y; _y <= _y2; _y += bladeDist) {
		VertexCreateBlade(vbMain,
			_x + random_range(-bladeSpread / 2, bladeSpread / 2),
			_y + random_range(-bladeSpread / 2, bladeSpread / 2),
			_bladeInfo);
	}
}

vertex_end(vbMain);

vertex_freeze(vbMain);