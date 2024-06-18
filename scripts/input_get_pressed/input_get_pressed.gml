function check_key_pressed(_device, _input_key) {
	var KeyGetter = keyboard_check_pressed(_input_key);
	if ( _input_key == mb_left or _input_key == mb_right or _input_key == mb_middle or
		_input_key == mb_any or _input_key == mb_none ){
				KeyGetter = device_mouse_check_button_pressed(_device, _input_key);
		}
		
	return KeyGetter;
}

function check_pad_pressed(_device, _input_pad) {
	var PadGetter = gamepad_button_check_pressed(_device, _input_pad);
	switch(_input_pad){
		
		#region Right Stick Up
		case gp_axisR_up:
			 var _val = abs(clamp(gamepad_axis_value(_device, gp_axisrv), -1, 0))
			if ( _val < gamepad_get_axis_deadzone(_device) ){
				__rut = false;	
			} else { __rut = true; }
			PadGetter = 0;
			if ( __rut && !__rutp ){ PadGetter = _val; __rutp = __rut; }
		break;
		#endregion
		#region Right Stick Down
		case gp_axisR_down:
			var _val = clamp(gamepad_axis_value(_device, gp_axisrv), 0, 1);
			if ( _val < gamepad_get_axis_deadzone(_device) ){
				__rdt=false;	
			} else { __rdt=true;}
			PadGetter=0;
			if ( __rdt && !__rdtp ){ PadGetter = _val; __rdtp=__rdt;}
		break;
		#endregion
		#region Right Stick Left
		case gp_axisR_left:
			var _val = abs(clamp(gamepad_axis_value(_device, gp_axisrh), -1, 0));
			if ( _val < gamepad_get_axis_deadzone(_device) ){
				__rlt=false;	
			} else { __rlt=true;}
			PadGetter=0;
			if ( __rlt && !__rltp ){ PadGetter = _val; __rltp=__rlt;}
		break;
		#endregion
		#region Right Stick Right
		case gp_axisR_right:
			var _val = clamp(gamepad_axis_value(_device, gp_axisrh), 0, 1);
			if ( _val < gamepad_get_axis_deadzone(_device) ){
				__rrt=false;	
			} else { __rrt=true;}
			PadGetter=0;
			if ( __rrt && !__rrtp ){ PadGetter = _val; __rrtp=__rrt;}
		break;
		#endregion
		
		#region Left Stick Up
		case gp_axisL_up:
			var _val = abs(clamp(gamepad_axis_value(_device, gp_axislv), -1, 0));
			if ( _val < gamepad_get_axis_deadzone(_device) ){
				__lut=false;	
			} else { __lut=true;}
			PadGetter=0;
			if ( __lut && !__lutp ){ PadGetter = _val; __lutp=__lut;}
		break;
		#endregion
		#region Left Stick Down
		case gp_axisL_down:
			var _val = clamp(gamepad_axis_value(_device, gp_axislv), 0, 1);
			if ( _val < gamepad_get_axis_deadzone(_device) ){
				__ldt=false;	
			} else { __ldt=true;}
			PadGetter=0;
			if ( __ldt && !__ldtp ){ PadGetter = _val; __ldtp=__ldt; }
		break;
		#endregion
		#region Left Stick Left
		case gp_axisL_left:
			var _val = abs(clamp(gamepad_axis_value(_device, gp_axislh), -1, 0));
			if ( _val < gamepad_get_axis_deadzone(_device) ){
				__llt=false;	
			} else { __llt=true;}
			PadGetter=0;
			if ( __llt && !__lltp ){ PadGetter = _val; __lltp=__llt; }
		break;
		#endregion
		#region Left Stick Right
		case gp_axisL_right:
			var _val = clamp(gamepad_axis_value(_device, gp_axislh), 0, 1);
			if ( _val < gamepad_get_axis_deadzone(_device) ){
				__lrt=false;	
			} else { __lrt=true;}
			PadGetter=0;
			if ( __lrt && !__lrtp ){ PadGetter = _val; __lrtp=__lrt;}
		break;
		#endregion
	
	}
	
	return PadGetter;
}

function input_get_pressed(_device, _inputName){
	var _INPUT_KEY  = global.input_list[? _inputName].key;
	var _INPUT_PAD = global.input_list[? _inputName].pad;

	var _EXTRA_KEYS  = global.input_list[? _inputName].extra_keys;
	var _EXTRA_PAD = global.input_list[? _inputName].extra_pad;
	
	var KeyGetter = check_key_pressed(_device, _INPUT_KEY);
	if (!KeyGetter && _EXTRA_KEYS != []) {	
		for (var _i = 0; _i < array_length(_EXTRA_KEYS); _i++) {
			if (check_key_pressed(_device, _EXTRA_KEYS[_i])) {
				KeyGetter = true;
				break;
			}
		}
	}
	
	var PadGetter = check_pad_pressed(_device, _INPUT_PAD);
	if (!PadGetter && _EXTRA_PAD != []) {	
		for (var _i = 0; _i < array_length(_EXTRA_PAD); _i++) {
			if (check_pad_pressed(_device, _EXTRA_PAD[_i])) {
				PadGetter = true;
				break;
			}
		}
	}
	
	return KeyGetter || PadGetter;
}