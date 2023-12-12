/// Feather disable GM2010

/// @func VertexCreateBlade
/// @param {Id.VertexBuffer} _vb
/// @param {Real} _x
/// @param {Real} _y
/// @param {BladeInfo} _bladeInfo
function VertexCreateBlade(_vb, _x, _y, _bladeInfo) {
	// Base
	// tri A
	vertex_position_3d(_vb, _x - _bladeInfo.baseThickness / 2, _y, -_y);
	vertex_color(_vb, _bladeInfo.baseColour, 1);
	vertex_position(_vb, 0, 0);
	
	vertex_position_3d(_vb, _x + _bladeInfo.baseThickness / 2, _y, -_y);
	vertex_color(_vb, _bladeInfo.baseColour, 1);
	vertex_position(_vb, 0, 0);
	
	// Divisions
	var _divs = _bladeInfo.divs, _p, _h, _w, _c, _lastX = _x + _bladeInfo.baseThickness / 2, _lastY = _y, _lastColour = _bladeInfo.baseColour;
	for (var d = 0; d < _divs; d ++) {
		_p = (1 + d) / (1 + _divs);					// 0-1 from base to tip (exclusive)
		_h = _bladeInfo.height * _p;				// height at this level
		_w = _bladeInfo.baseThickness * (1 - _p);	// width at this level
		_c = merge_color(_bladeInfo.baseColour, _bladeInfo.tipColour, _p);
		
		vertex_position_3d(_vb, _x - _w / 2, _y - _h, -_y);
		vertex_color(_vb, _c, 1);
		vertex_position(_vb, 0, 0);
	
		// tri B
		vertex_position_3d(_vb, _x - _w / 2, _y - _h, -_y);
		vertex_color(_vb, _c, 1);
		vertex_position(_vb, 0, 0);
	
		vertex_position_3d(_vb, _x + _w / 2, _y - _h, -_y);
		vertex_color(_vb, _c, 1);
		vertex_position(_vb, 0, 0);
	
		vertex_position_3d(_vb, _lastX, _lastY, -_y);
		vertex_color(_vb, _lastColour, 1);
		vertex_position(_vb, 0, 0);
		
		// tri A
		vertex_position_3d(_vb, _x - _w / 2, _y - _h, -_y);
		vertex_color(_vb, _c, 1);
		vertex_position(_vb, 0, 0);
	
		vertex_position_3d(_vb, _x + _w / 2, _y - _h, -_y);
		vertex_color(_vb, _c, 1);
		vertex_position(_vb, 0, 0);
		
		_lastX = _x + _w / 2;
		_lastY = _y - _h;
		_lastColour = _c;
	}
	
	// Top
	vertex_position_3d(_vb, _x, _y - _bladeInfo.height, -_y);
	vertex_color(_vb, _bladeInfo.tipColour, 1);
	vertex_position(_vb, 0, 0);
}