/// Feather disable GM2010

/// @func VertexCreateBlade
/// @param {Id.VertexBuffer} _vb
/// @param {Real} _x
/// @param {Real} _y
/// @param {BladeInfo} _bladeInfo
function VertexCreateBlade(_vb, _x, _y, _bladeInfo) {
	var _p = 0;
	var _bend = 0;
	
	// Base
	// tri A
	vertex_position_3d(_vb, _x - _bladeInfo.baseThickness / 2, _y, -_y);
	vertex_color(_vb, _bladeInfo.baseColour, 1);
	vertex_texcoord(_vb, 0, 0);
	vertex_normal(_vb, _x, _y, _bladeInfo.height);
	
	vertex_position_3d(_vb, _x + _bladeInfo.baseThickness / 2, _y, -_y);
	vertex_color(_vb, _bladeInfo.baseColour, 1);
	vertex_texcoord(_vb, 0, 0);
	vertex_normal(_vb, _x, _y, _bladeInfo.height);
	
	// Divisions
	var _divs = _bladeInfo.divs, _h, _w, _c, _lastX = _x + _bladeInfo.baseThickness / 2, _lastY = _y, _lastColour = _bladeInfo.baseColour, _xx;
	for (var d = 0; d < _divs; d ++) {
		_p = (1 + d) / (1 + _divs);					// 0-1 from base to tip (exclusive)
		_h = _bladeInfo.height * _p;				// height at this level
		_w = _bladeInfo.baseThickness * (1 - _p);	// width at this level
		_c = merge_color(_bladeInfo.baseColour, _bladeInfo.tipColour, _p);
		_bend = TGEaseInCubic(_p) * _bladeInfo.bend;
		
		_xx = _x + _bend;
		
		vertex_position_3d(_vb, _xx - _w / 2, _y - _h, -_y);
		vertex_color(_vb, _c, 1);
		vertex_texcoord(_vb, 0, 0);
		vertex_normal(_vb, _x, _y, _bladeInfo.height);
	
		// tri B
		vertex_position_3d(_vb, _xx - _w / 2, _y - _h, -_y);
		vertex_color(_vb, _c, 1);
		vertex_texcoord(_vb, 0, 0);
		vertex_normal(_vb, _x, _y, _bladeInfo.height);
	
		vertex_position_3d(_vb, _xx + _w / 2, _y - _h, -_y);
		vertex_color(_vb, _c, 1);
		vertex_texcoord(_vb, 0, 0);
		vertex_normal(_vb, _x, _y, _bladeInfo.height);
	
		vertex_position_3d(_vb, _lastX, _lastY, -_y);
		vertex_color(_vb, _lastColour, 1);
		vertex_texcoord(_vb, 0, 0);
		vertex_normal(_vb, _x, _y, _bladeInfo.height);
		
		// tri A
		vertex_position_3d(_vb, _xx - _w / 2, _y - _h, -_y);
		vertex_color(_vb, _c, 1);
		vertex_texcoord(_vb, 0, 0);
		vertex_normal(_vb, _x, _y, _bladeInfo.height);
	
		vertex_position_3d(_vb, _xx + _w / 2, _y - _h, -_y);
		vertex_color(_vb, _c, 1);
		vertex_texcoord(_vb, 0, 0);
		vertex_normal(_vb, _x, _y, _bladeInfo.height);
		
		_lastX = _xx + _w / 2;
		_lastY = _y - _h;
		_lastColour = _c;
	}
	
	_p = 1;
	_bend = _bladeInfo.bend;
	
	// Top
	var _topThickness = _bladeInfo.topThickness;
	if (_topThickness <= 0) {
		vertex_position_3d(_vb, _x + _bend, _y - _bladeInfo.height, -_y);
		vertex_color(_vb, _bladeInfo.tipColour, 1);
		vertex_texcoord(_vb, 0, 0);
		vertex_normal(_vb, _x, _y, _bladeInfo.height);
	}
	else {
		vertex_position_3d(_vb, (_x - _topThickness / 2) + _bend, _y - _bladeInfo.height, -_y);
		vertex_color(_vb, _bladeInfo.tipColour, 1);
		vertex_texcoord(_vb, 0, 0);
		vertex_normal(_vb, _x, _y, _bladeInfo.height);
		
		// tri B
		vertex_position_3d(_vb, _lastX, _lastY, -_y);
		vertex_color(_vb, _lastColour, 1);
		vertex_texcoord(_vb, 0, 0);
		vertex_normal(_vb, _x, _y, _bladeInfo.height);
		
		vertex_position_3d(_vb, (_x - _topThickness / 2 + _bend), _y - _bladeInfo.height, -_y);
		vertex_color(_vb, _bladeInfo.tipColour, 1);
		vertex_texcoord(_vb, 0, 0);
		vertex_normal(_vb, _x, _y, _bladeInfo.height);
		
		vertex_position_3d(_vb, (_x + _topThickness / 2 + _bend), _y - _bladeInfo.height, -_y);
		vertex_color(_vb, _bladeInfo.tipColour, 1);
		vertex_texcoord(_vb, 0, 0);
		vertex_normal(_vb, _x, _y, _bladeInfo.height);
	}
}





/// Easing functions
/// Source: https://easings.net
function TGEaseInCubic (_val) {
	return _val * _val * _val;
}