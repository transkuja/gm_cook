image_alpha = 1;
item_data = {};

is_selected = false;
_center_x = center_x(); //x + (sprite_width * 0.5);
_center_y = center_y(); //y + (sprite_height * 0.5);

item_scale = 0.85;

function Refresh(_itemData) {
	// TODO: check if data is copied or passed by ref
	item_data = _itemData;
}

function SetSelected(_value) {
	is_selected = _value;
}

function DrawSelectedFeedback() {
	draw_sprite_ext(spr_ui_slot_selected, 0, _center_x, _center_y, 1, 1, 0, c_orange, 1);
}

function OnMouseEnter() {
	global.interact_blocked = true;
	UpdateVisual();
}

function OnMouseExit() {
	global.interact_blocked = false;
	UpdateVisual();
}

hovering_last_frame = false;
hovering = false;
clicked = false;

on_clicked_event = noone;
on_clicked = function() {
	audio_play_sound(Minimalist1, 10, false);
}

on_click_param = {};

function UpdateVisual() {
	if (clicked) 
	{
		image_index = 2;
	} 
	else if (hovering) 
	{
		image_index = 1;
	} 
	else 
	{
		image_index = 0;
	}
}