/// @description Insert description here
// You can write your code in this editor

//var _stick_horizontal = gamepad_axis_value(0, gp_axislh);
//var _stick_vertical = gamepad_axis_value(0, gp_axislv);
	
//var text_value = string(_stick_horizontal) + "," + string(_stick_vertical);

//draw_text_color(x + 5, y - 5, text_value, c_green, c_green, c_green, c_green, 1);

if (draw_debug) { 
	var _color = c_green;
	draw_set_alpha(0.2);
	draw_rectangle_color(x - min_x_check_enviro,
		y - min_y_check_enviro,
		x + max_x_check_enviro,
		y + max_y_check_enviro,
		_color, _color, _color, _color, false);
	draw_set_alpha(1);
	
	if (debug_draw_enviro_detected)
		draw_line_color(x,y, debug_draw_enviro_detected_x, debug_draw_enviro_detected_y, c_fuchsia, c_fuchsia);
}