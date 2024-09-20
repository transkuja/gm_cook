hovering_last_frame = false;
hovering = false;

mouse_enter_snd_inst = noone;
mouse_click_snd_inst = noone;

sprite_index = noone;
mask_index = spr_transparent_circle;

function PlayMouseEnterSound() {
	if (mouse_enter_snd_inst != noone)
		audio_stop_sound(mouse_enter_snd_inst);
	if (mouse_click_snd_inst != noone)
		audio_stop_sound(mouse_click_snd_inst);
	
	mouse_enter_snd_inst = noone;
	mouse_click_snd_inst = noone;
	
	mouse_enter_snd_inst = audio_play_sound(snd_mouse_enter, 10, false);
}

function PlayMouseClickSound() {
	if (mouse_enter_snd_inst != noone)
		audio_stop_sound(mouse_enter_snd_inst);
	if (mouse_click_snd_inst != noone)
		audio_stop_sound(mouse_click_snd_inst);
		
	mouse_enter_snd_inst = noone;
	mouse_click_snd_inst = noone;
	
	mouse_click_snd_inst = audio_play_sound(snd_mouse_click, 10, false);
}
