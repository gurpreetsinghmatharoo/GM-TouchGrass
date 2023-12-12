gpu_set_ztestenable(true);

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
_bladeInfo.topThickness = bladeTopThickness;
_bladeInfo.height = bladeHeight;
_bladeInfo.divs = bladeDivs;
_bladeInfo.baseColour = bladeBaseColour;
_bladeInfo.tipColour = bladeTipColour;
_bladeInfo.bend = bladeBend;

var _x2 = x + sprite_width, _y2 = y + sprite_height;
for (var _x = x; _x <= _x2; _x += bladeDist * xToYDistRatio) {
	for (var _y = y; _y <= _y2; _y += bladeDist) {
		_bladeInfo.bend = bladeBend + random_range(-bladeBendJitter / 2, bladeBendJitter / 2);
		_bladeInfo.baseThickness = bladeBaseThickness + random_range(-bladeBaseJitter / 2, bladeBaseJitter / 2);
		_bladeInfo.height = bladeHeight + random_range(-bladeHeightJitter / 2, bladeHeightJitter / 2);
		
		VertexCreateBlade(vbMain,
			_x + random_range(-bladePositionJitter / 2, bladePositionJitter / 2),
			_y + random_range(-bladePositionJitter / 2, bladePositionJitter / 2),
			_bladeInfo);
	}
}

vertex_end(vbMain);

vertex_freeze(vbMain);