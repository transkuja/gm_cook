// This function is useful for in-game input mapping

function input_change(_inputName, new_keyboard_or_mouse, new_gamepad){
	global.input_list[? _inputName].key = new_keyboard_or_mouse;
	global.input_list[? _inputName].pad = new_gamepad;
}

function input_change_key(_inputName, new_keyboard_or_mouse, _index = -1){
	if (_index == -1) {
		global.input_list[? _inputName].key = new_keyboard_or_mouse;
	}
	else {
		if (array_length(global.input_list[? _inputName].extra_keys) > _index)
			global.input_list[? _inputName].extra_keys[_index] = new_keyboard_or_mouse;
	}
}

function input_change_pad(_inputName, new_gamepad, _index = -1){
	if (_index == -1) {
		global.input_list[? _inputName].pad = new_gamepad;
	}
	else {
		if (array_length(global.input_list[? _inputName].extra_pad) > _index)
			global.input_list[? _inputName].extra_pad[_index] = new_gamepad;
	}
}