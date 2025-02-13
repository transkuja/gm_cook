/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function DrawSelectedFeedback() {
	draw_sprite_ext(spr_ui_slot_selected, 0, _center_x, _center_y, 1, 1, 0, c_orange, 1);
	if (IsAnyControllerConnected())
		draw_sprite(spr_xbox_button_color_y_outline, 0, _center_x, _center_y - sprite_height * image_yscale * 0.5 - 25);
}