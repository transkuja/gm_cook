/// @description Insert description here
// You can write your code in this editor
if (is_title_screen) {
	if (save_data_get(save_key) == undefined || save_data_get(save_key) < 3 || irandom_range(0,2) == 1) {
		instance_destroy();
	}
	
	return;
}

if (global.patrick = true) {
	instance_destroy();
	return;
}
	
if (save_data_get(save_key) == undefined) {
	save_data_set(save_key, 1);
	instance_destroy();
}
else {
	if (is_main) {
		save_data_add(save_key, 1);
		var _saved_value = save_data_get(save_key);
		if (_saved_value > 0 && _saved_value%3 == 0) {
			global.patrick = true;
			return;
		}
		else {
			global.patrick = false;
			instance_destroy();
		}
	}
	else {
		if (global.patrick == false) {
			var _saved_value = save_data_get(save_key);
			if (_saved_value == undefined || _saved_value < 3)
			{
				instance_destroy();
				return;
			}
			
			if (_saved_value > 0 && _saved_value%3 == 0) {
				instance_destroy();
				return;
			}
			
			var _last = save_data_get("patrick_last");
			if (_last != undefined && _last == save_unique_key) {
				instance_destroy();
				return;
			}
			
			if (irandom_range(0,3) == 1) {
				global.patrick = true;
				save_data_set("patrick_last", save_unique_key);
				return;
			}
			else {
				instance_destroy();
			}
		}
	}
}