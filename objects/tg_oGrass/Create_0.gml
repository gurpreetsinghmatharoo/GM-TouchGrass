// Define format
vertex_format_begin();

vertex_format_add_position();
vertex_format_add_color();
vertex_format_add_custom(vertex_type_float2, vertex_usage_position); // Velocity

vfMain = vertex_format_end();

// Create vbuff
vbMain = vertex_create_buffer();

var _bladeInfo = new BladeInfo();
_bladeInfo.baseThickness = bladeBaseThickness;
_bladeInfo.height = bladeHeight;
_bladeInfo.divs = bladeDivs;

var _x2 = x + sprite_width, _y2 = y + sprite_height;
for (var _x = x; _x <= _x2; x += bladeDist) {
	for (var _y = y; _y <= _y2; x += bladeDist) {
		VertexCreateBlade(vbMain, _x, _y, _bladeInfo);
	}
}




vertex_freeze(vbMain);