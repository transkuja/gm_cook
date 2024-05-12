function VectorSqrLength(_x, _y) {
	return (_x * _x) + (_y * _y);
}

function VectorLength(_x, _y) {
	return sqrt(VectorSqrLength(_x, _y));
}

function NormalizeVector(_x, _y) {
	var _normalized = [0,0];
	var _length = VectorLength(_x, _y);
	if (_length > 0) {
		_normalized[0] = _x / _length;
		_normalized[1] = _y / _length;
	}	
		
	return _normalized;
}

function DotProduct(_x1, _y1, _x2, _y2) {
	return (_x1 * _x2) + (_y1 * _y2);
}