image_alpha = 0.5;
item_sprite = noone;
qty = 0;
is_selected = false;
center_x = x + (sprite_width * 0.5);
center_y = y + (sprite_height * 0.5);

function Refresh(_spr, _qty) {
	spr_item = _spr;
	qty = _qty;

}

function SetSelected(_value) {
	is_selected = _value;
}

function DrawSelectedFeedback() {
	draw_sprite_ext(spr_ui_slot_selected, 0, center_x, center_y, 1, 1, 0, c_orange, 1);
}