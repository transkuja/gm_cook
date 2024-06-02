/// @func _linspace(_start, _stop, n)
/// @desc Generates a specified number of equally-spaced values within a specified range.
/// @param {real} _start - First value of array.
/// @param {real} _stop - Last value of array.
/// @param {int} n - Number of values in array. Must be at least 2 (unless the endpoints are equal).
/// @return {real[]} An array with first value _start, final value _stop, and a total of n elements (or empty array in case of error).

function _linspace(_start, _stop, _n)
{
	// Verify that number of elements is valid
	if (_n < 2)
	{
		// n=1 is allowed only if the endpoints are equal
		if ((_start == _stop) && (_n == 1))
			return [_start];
		
		// Otherwise we return an empty array
		return [];
	}
	
	// Determine step size
	var step = (_stop - _start)/(_n - 1);
	
	// Generate array
	var arr = array_create(_n);
	for (var i = 0; i < _n-1; i++)
		arr[i] = _start + i*step;
	arr[_n-1] = _stop; // ensure that final value is exact
	
	return arr;
}
