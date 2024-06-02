/// @func _range(_start, _stop[, step])
/// @desc Generates an array of equally-spaced values over a specified range with a specified step size.
/// @param {real} _start - First value of array.
/// @param {real} _stop - Final value of array (if the step size evenly divides the array; otherwise gives an upper bound to the final value).
/// @param {real} [step=1] - Step size. May be positive if _start <= _stop and negative otherwise.
/// @return {real[]} Array of values beginning with _start, incrementing by step, and ending with the last value that does not extend beyond _stop.

function _range(_start, _stop)
{
	// Check for optional step argument
	var step = (argument_count > 2 ? argument[2] : 1);
	
	// Generate array depending on whether we are counting up or down
	if (step > 0)
	{
		// Counting up
		
		// Verify that bounds are valid
		if (_start > _stop)
			return [];
		
		// Determine number of elements
		var n = floor((_stop - _start)/step) + 1;
		
		// Generate array
		var arr = array_create(n);
		for (var i = 0; i < n; i++)
			arr[i] = _start + i*step;
		
		return arr;
	}
	else if (step < 0)
	{
		// Counting down
		
		// Verify that bounds are valid
		if (_start < _stop)
			return [];
		
		// Determine number of elements
		var n = floor(abs((_stop - _start)/step)) + 1;
		
		// Generate array
		var arr = array_create(n);
		for (var i = 0; i < n; i++)
			arr[i] = _start + i*step;
		
		return arr;
	}
	else
		return []; // zero step size
}
