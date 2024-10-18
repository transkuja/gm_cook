draw_self();

if (draw_debug) { 
	//draw_circle_colour(x,y+detection_offset_y,collect_radius, c_fuchsia, c_fuchsia, true);
	//draw_circle_colour(x,y+detection_offset_y,pick_up_radius, c_green, c_green, true);
	var _color = c_green;
	//_color.a = 0.2;
	draw_set_alpha(0.2);
	draw_rectangle_color(min_x_depth_sorting, min_y_depth_sorting, max_x_depth_sorting, max_y_depth_sorting,
		_color, _color, _color, _color, false);
	draw_set_alpha(1);
}