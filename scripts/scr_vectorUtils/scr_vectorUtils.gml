function VectorSqrLength(_x, _y) {
	return (_x * _x) + (_y * _y);
}

function VectorLength(_x, _y) {
	return sqrt(VectorSqrLength(_x, _y));
}

function NormalizeVector(_x, _y) {
	var _normalized = [0,0];
	var _size = VectorLength(_x, _y);
	if (_size > 0) {
		_normalized[0] = _x / _size;
		_normalized[1] = _y / _size;
	}	
		
	return _normalized;
}

function DotProduct(_x1, _y1, _x2, _y2) {
	return (_x1 * _x2) + (_y1 * _y2);
}

function GetAngleVectors(_x1, _y1, _x2, _y2) {
	var _v1 = NormalizeVector(_x1, _y1);
	var _v2 = NormalizeVector(_x2, _y2);
	
	return arccos(DotProduct(_v1[0], _v1[1], _v2[0], _v2[1]));
}

function GetAngleVectorsDegrees(_x1, _y1, _x2, _y2) {
	var _v1 = NormalizeVector(_x1, _y1);
	var _v2 = NormalizeVector(_x2, _y2);
	
	return darccos(DotProduct(_v1[0], _v1[1], _v2[0], _v2[1]));
}

function DistanceSqr(_x1, _y1, _x2, _y2) {
	var _x = _x1 - _x2;
	var _y = _y1 - _y2;
	
	return VectorSqrLength(_x, _y);
}

function GetClosest(_obj_to_test, _arr_objects) {
	var _dist_ref = 1000000;
	var _result = noone;
	for (var _i = 0; _i < array_length(_arr_objects); _i++)
	{
		var _current_distance = DistanceSqr(_obj_to_test.x, _obj_to_test.y, 
				_arr_objects[_i].x, _arr_objects[_i].y);
				
		if (_current_distance < _dist_ref)
		{
			_dist_ref = _current_distance;
			_result = _arr_objects[_i];
		}
	}
			
	return _result;
}