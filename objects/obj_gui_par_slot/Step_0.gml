/// @description Insert description here
// You can write your code in this editor

if (!can_interact)
	return;
	
hovering_last_frame = hovering;
hovering = position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id);

if (hovering != hovering_last_frame)
{
	if (hovering == true)
		OnMouseEnter();
	else
		OnMouseExit();
}

if (hovering && mouse_check_button_pressed(mb_left)) 
{
	clicked = true;
	UpdateVisual();
} 

if (mouse_check_button_released(mb_left)) 
{
	clicked = false;

	if (hovering) 
	{
		//audio_play_sound(snd_button, 1, false);
		on_clicked();
		if (on_clicked_event != noone)
			on_clicked_event.dispatch(on_click_param);
	}
	
	UpdateVisual();
}