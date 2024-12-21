text_width = 850;
line_height = 40;

// Stop player on open
global.player_control--;

// Init fade values
event_perform_object(obj_fading, ev_create, 0);
fadeMe = 1; // don't fade immediately

on_menu_close = noone;

draw_x = view_wport[0] * 0.5;
draw_y = view_hport[0] * 0.5 - 100;
x = draw_x;
y = draw_y;

depth = -11000;
image_xscale = 1.5;

can_close = false;

function Initialize(_inventory_array) {
	//if (_item_id == undefined || _item_id == "" || _item_id == noone) {
	//	instance_destroy();
	//	return;
	//}
		
	image_alpha = 1;
	
	audio_play_sound(snd_on_popup_open, 10, false);
	alarm[1] = 30; // enable closing
}

function CloseMenu() {
	audio_play_sound(snd_on_popup_close, 10, false);
	
	StartFadeOut();
	alarm[0] = seconds(0.5);
}

function HandleInput() {
	if (!can_close)
		return;
		
	// TODO: add delay to prevent closing too fast
	if (input_get_pressed(0, "ui_cancel")) {
		CloseMenu();
	}
}