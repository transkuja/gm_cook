
if (global.input_bindings != noone)
{
	for (var _i = 0; _i < array_length(global.input_bindings_keys); _i++)
	{
		var _current_input = global.input_bindings_keys[_i];
		var _bindings = global.input_bindings[$ _current_input];
		if (input_get_pressed(0, _current_input)) {
			if (_bindings.pressed_event != noone)
				_bindings.pressed_event.dispatch();
		}
		
		if (input_get_released(0, _current_input)) {
			if (_bindings.released_event != noone)
				_bindings.released_event.dispatch();
		}
		
		if (input_get(0, _current_input)) {
			if (_bindings.down_event != noone)
				_bindings.down_event.dispatch(input_get(0, _current_input));
		}
	}
}