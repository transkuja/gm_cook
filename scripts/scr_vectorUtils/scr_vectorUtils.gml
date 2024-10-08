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