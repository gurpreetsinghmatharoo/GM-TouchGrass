/// Feather disable GM2010

/// @func VertexCreateBlade
/// @param {Id.VertexBuffer} _vb
/// @param {Real} _x
/// @param {Real} _y
/// @param {BladeInfo} _bladeInfo
function VertexCreateBlade(_vb, _x, _y, _bladeInfo) {
	// Base
	vertex_position(_vb, _x - _bladeInfo.baseThickness / 2, _y);
	vertex_color(_vb, _bladeInfo.baseColour, 1);
	vertex_position(_vb, 0, 0);
	
	vertex_position(_vb, _x + _bladeInfo.baseThickness / 2, _y);
	vertex_color(_vb, _bladeInfo.baseColour, 1);
	vertex_position(_vb, 0, 0);
	
	// Divisions
	var _divs = _bladeInfo.divs, _p, _h, _w;
	for (var d = 0; d < _divs; d ++) {
		_p = (1 + d) / (1 + _divs);
		_h = _bladeInfo.height * _p;
		_w = _bladeInfo.baseThickness * (1 - _p);
		
		vertex_position(_vb, _x - _w / 2, _y - _h);
		vertex_color(_vb, _bladeInfo.baseColour, 1);
		vertex_position(_vb, 0, 0);
	
		vertex_position(_vb, _x - _w / 2, _y - _h);
		vertex_color(_vb, _bladeInfo.baseColour, 1);
		vertex_position(_vb, 0, 0);
	
		vertex_position(_vb, _x + _w / 2, _y - _h);
		vertex_color(_vb, _bladeInfo.baseColour, 1);
		vertex_position(_vb, 0, 0);
	}
	
	// Top
	vertex_position(_vb, _x, _y - _bladeInfo.height);
	vertex_color(_vb, _bladeInfo.baseColour, 1);
	vertex_position(_vb, 0, 0);
}