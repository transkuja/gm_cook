global.input_list = ds_map_create();
global.input_bindings = {};
global.input_bindings_keys = array_create(0, "");

ui_input_cooldown = 200; // in ms
cd_inputs = {};

// Gamepad Settings
for ( var i=0; i<4; i++ ){
	gamepad_set_axis_deadzone(i, 0.25);
	gamepad_set_button_threshold(i, 0.25);
}

// face1 -> A, face2 -> B, face3 -> X, face4 -> Y

// Define your inputs:
input_add("ui_left", ord("Q"), gp_padl);
input_add("ui_right", ord("D"), gp_padr);
input_add("ui_up", ord("Z"), gp_padu);
input_add("ui_down", ord("S"), gp_padd);

input_add("ui_stick_left", "", gp_axisL_left);
input_add("ui_stick_right", "", gp_axisL_right);
input_add("ui_stick_up", "", gp_axisL_up);
input_add("ui_stick_down", "", gp_axisL_down);

input_add("ui_validate_no_click", vk_space, gp_face1, [vk_enter]);
input_add("ui_validate", vk_space, gp_face1, [vk_enter, mb_left]);
input_add("ui_alt", "", gp_face3);
input_add("ui_cancel", vk_escape, gp_face2);

input_add("move_left", ord("Q"), gp_padl, [vk_left]);
input_add("move_right", ord("D"), gp_padr, [vk_right]);
input_add("move_up", ord("Z"), gp_padu, [vk_up]);
input_add("move_down", ord("S"), gp_padd, [vk_down]);

input_add("interact", vk_space, gp_face3);
input_add("item_action", vk_enter, gp_face1, [mb_left]);
input_add("take_out", mb_right, gp_face4);
input_add("sprint", vk_shift, gp_face2);
input_add("cancel_interaction", vk_escape, gp_face2);

input_add("qte", mb_left, gp_face1, [vk_enter,vk_space], [gp_face3]);

input_add("left_stick_h", "", gp_axislh);
input_add("left_stick_v", "", gp_axislv);
input_add("right_stick_h", "", gp_axisrh);
input_add("right_stick_v", "", gp_axisrv);

input_add("prev_tab", "", gp_shoulderl);
input_add("next_tab", vk_tab, gp_shoulderr);

function IsKeyInCooldown(_key) {
	var _value = cd_inputs[$ _key];
	if (_value == undefined)
		return false;
		
	if (_key == "ui_stick_down")
	{
		_log("Check cd: ui_stick_down cd: ", cd_inputs[$ _key]);
		_log("Check cd: current time: ", current_time);
	}
				
	return current_time - _value < ui_input_cooldown;
}
