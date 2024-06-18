// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function check_key_input(_device, _INPUT_KEY) {
	var _KeyGetter = keyboard_check(_INPUT_KEY);
	if ( _INPUT_KEY == mb_left or _INPUT_KEY == mb_right or _INPUT_KEY == mb_middle or
		_INPUT_KEY == mb_any or _INPUT_KEY == mb_none ) {
				_KeyGetter = device_mouse_check_button(_device, _INPUT_KEY);
		}
		
	return _KeyGetter;
}

function check_pad_input(_device, _INPUT_PAD) {
	var PadGetter = gamepad_button_check(_device, _INPUT_PAD);
	switch(_INPUT_PAD){
		
		#region Right Stick Up
		case gp_axisR_up:
			PadGetter = abs(clamp(gamepad_axis_value(_device, gp_axisrv), -1, 0));
		break;
		#endregion
		#region Right Stick Down
		case gp_axisR_down:
			PadGetter = clamp(gamepad_axis_value(_device, gp_axisrv), 0, 1);
		break;
		#endregion
		#region Right Stick Left
		case gp_axisR_left:
			PadGetter = abs(clamp(gamepad_axis_value(_device, gp_axisrh), -1, 0));
		break;
		#endregion
		#region Right Stick Right
		case gp_axisR_right:
			PadGetter = clamp(gamepad_axis_value(_device, gp_axisrh), 0, 1);
		break;
		#endregion
		
		#region Left Stick Up
		case gp_axisL_up:
			PadGetter = abs(clamp(gamepad_axis_value(_device, gp_axislv), -1, 0));
		break;
		#endregion
		#region Left Stick Down
		case gp_axisL_down:
			PadGetter = clamp(gamepad_axis_value(_device, gp_axislv), 0, 1);
		break;
		#endregion
		#region Left Stick Left
		case gp_axisL_left:
			PadGetter = abs(clamp(gamepad_axis_value(_device, gp_axislh), -1, 0));
		break;
		#endregion
		#region Left Stick Right
		case gp_axisL_right:
			PadGetter = clamp(gamepad_axis_value(_device, gp_axislh), 0, 1);
		break;
		#endregion
	
	}
	
	return PadGetter;
}

function input_get(_device, _inputName){
	var _INPUT_KEY  = global.input_list[? _inputName].key;
	var _INPUT_PAD = global.input_list[? _inputName].pad;
	
	var _EXTRA_KEYS  = global.input_list[? _inputName].extra_keys;
	var _EXTRA_PAD = global.input_list[? _inputName].extra_pad;
	
	var KeyGetter = check_key_input(_device, _INPUT_KEY);
	if (!KeyGetter && _EXTRA_KEYS != []) {	
		for (var _i = 0; _i < array_length(_EXTRA_KEYS); _i++) {
			if (check_key_input(_device, _EXTRA_KEYS[_i])) {
				KeyGetter = true;
				break;
			}
		}
	}
	
	var PadGetter = check_pad_input(_device, _INPUT_PAD);
	if (!PadGetter && _EXTRA_PAD != []) {	
		for (var _i = 0; _i < array_length(_EXTRA_PAD); _i++) {
			if (check_key_input(_device, _EXTRA_PAD[_i])) {
				PadGetter = true;
				break;
			}
		}
	}
	
	return KeyGetter || PadGetter;
	
}