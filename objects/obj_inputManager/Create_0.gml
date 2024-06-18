global.input_list = ds_map_create();

// Gamepad Settings
for ( var i=0; i<4; i++ ){
	gamepad_set_axis_deadzone(i, 0.5);
	gamepad_set_button_threshold(i, 0.5);
}

// Define your inputs:
input_add("ui_left", ord("A"), gp_axisL_left);
input_add("ui_right", ord("D"), gp_axisL_right);
input_add("ui_up", ord("W"), gp_axisL_up);
input_add("ui_down", ord("S"), gp_axisL_down);

input_add("move_left", ord("A"), gp_axisL_left);
input_add("move_right", ord("D"), gp_axisL_right);
input_add("move_up", ord("W"), gp_axisL_up);
input_add("move_down", ord("S"), gp_axisL_down);

input_add("interact", vk_space, gp_face3);
input_add("item_action", vk_enter, gp_face1);
input_add("item_action2", mb_left, gp_face1);
input_add("take_out", mb_right, gp_face4);

input_add("qte", mb_left, gp_face2);