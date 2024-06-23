// Returns 0 when _v = _a and 1 when _v = _b
function InvLerp(_a, _b, _v) {
	return (_v - _a) / (_b - _a);
}

// Takes a value within a given input range into a given output range
function Remap(_iMin, _iMax, _oMin, _oMax, _v) {
	var _t = InvLerp(_iMin, _iMax, _v);
	return lerp(_oMin, _oMax, _t);
}