
hovering_last_frame = hovering;
hovering = position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id);

if (hovering && mouse_check_button_pressed(mb_left)) 
{
	sound_state = (sound_state + 1) % 2;
	ApplySoundSetting();
	
	save_data_set(option_save_key, sound_state);
}
