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
input_add("ui_validate", vk_space, gp_face1, [vk_enter, mb_left]);

input_add("move_left", ord("Q"), gp_axisL_left, [vk_left]);
input_add("move_right", ord("D"), gp_axisL_right, [vk_right]);
input_add("move_up", ord("Z"), gp_axisL_up, [vk_up]);
input_add("move_down", ord("S"), gp_axisL_down, [vk_down]);

input_add("interact", vk_space, gp_face3);
input_add("item_action", vk_enter, gp_face1, [mb_left]);
input_add("take_out", mb_right, gp_face4);

input_add("qte", mb_left, gp_face1, [vk_enter,vk_space], [gp_face3]);

input_add("move_left_controller", "", gp_axisL_left);
input_add("move_right_controller", "", gp_axisL_right);
input_add("move_up_controller", "", gp_axisL_up,);
input_add("move_down_controller", "", gp_axisL_down);

input_add("prev_tab", "", gp_shoulderl);
input_add("next_tab", vk_tab, gp_shoulderr);