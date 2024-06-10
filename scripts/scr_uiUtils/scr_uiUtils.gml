
function GetPositionsOnLineCenter(_sprite_width, _gap, _count, _line_origin, _sprite_origin){
	var _offset = ((_sprite_width * _count) + (_gap * (_count - 1))) * 0.5;
	if (_sprite_origin == SPRITE_ORIGIN.TOP_LEFT)
		_offset += _sprite_width * 0.5;
	
	var _result = array_create(_count, 0);
	
	for (var i = 0; i < _count; i += 1)
	{
		_result[i] = _line_origin +( (_sprite_width + _gap) * i) - _offset;
	}
	
	return _result
}

function GetPositionsOnLineTopLeft(_sprite_width, _gap, _count, _top_left){
	var _result = array_create(_count, 0);
	
	for (var i = 0; i < _count; i += 1)
	{
		_result[i] = _top_left +( (_sprite_width + _gap) * i);
	}
	
	return _result
}