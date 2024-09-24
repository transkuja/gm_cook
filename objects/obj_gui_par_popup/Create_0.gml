text_recipe_unlocked = "Nouvelle recette !" // TODO: localize
text_recipe_name = "J'aime pas les gros singes."
text_width = 850;
line_height = 40;

// Stop player on open
global.player_control = false;

// Init fade values
event_perform_object(obj_fading, ev_create, 0);
fadeMe = 1; // don't fade immediately

on_popup_close = noone;

draw_x = view_wport[0] * 0.5;
draw_y = view_hport[0] * 0.5 - 100;
x = draw_x;
y = draw_y;

depth = -11000;
image_xscale = 1.5;

recipe_sprite = noone;
can_close = false;

function Initialize(_item_id) {
	if (_item_id == undefined || _item_id == "" || _item_id == noone) {
		instance_destroy();
		return;
	}
	
	recipe_sprite = GetItemSprite(_item_id);
	text_recipe_name = GetItemLocalizedName(_item_id);
	
	image_alpha = 1;
	
	audio_play_sound(snd_on_popup_open, 10, false);
	alarm[1] = 30; // enable closing
}

function ClosePopup() {
	audio_play_sound(snd_on_popup_close, 10, false);
	
	StartFadeOut();
	alarm[0] = seconds(0.5);
}

function HandleInput() {
	if (!can_close)
		return;
		
	// TODO: add delay to prevent closing too fast
	if (input_get_pressed(0, "ui_validate")) {
		ClosePopup();
	}
}


