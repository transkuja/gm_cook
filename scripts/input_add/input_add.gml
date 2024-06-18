// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function input_add(_input_name, _key_or_mouse_button, _gamepad_button_or_axis, _extra_keys = [], _extra_pads = []){

	global.input_list[? _input_name] = {
		key : _key_or_mouse_button,
		pad : _gamepad_button_or_axis,
		extra_keys : _extra_keys,
		extra_pads : _extra_pads
	}

}