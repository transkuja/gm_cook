draw_self();

if (draw_debug) { 
	draw_circle_colour(x,y+detection_offset_y,collect_radius, c_fuchsia, c_fuchsia, true);
	draw_circle_colour(x,y+detection_offset_y,pick_up_radius, c_green, c_green, true);
}