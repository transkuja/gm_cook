
hovering_last_frame = hovering;
hovering = position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id);

if (hovering && mouse_check_button_pressed(mb_left)) 
{
	if (is_music) {
		audio_group_set_gain(audiogroup_music, sound_state, 0);
	}
	else {
		audio_group_set_gain(audiogroup_default, sound_state, 0);
	}
		
	sound_state = (sound_state + 1) % 2;
}
