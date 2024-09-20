hovering_last_frame = hovering;
hovering = position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id);

if (hovering != hovering_last_frame && hovering == true) {
	PlayMouseEnterSound();
} 

if (mouse_check_button_released(mb_left)) {
	if (hovering) 
	{
		PlayMouseClickSound();
	}
}