
draw_self();

if (spr_item != noone && spr_item != undefined && spr_item != -1) {
	draw_sprite(spr_item, 0, center_x, center_y);
}

if (qty > 0) {
	draw_set_font(fnt_inventory_slot);
	draw_text(x + (sprite_width * 0.1),y + (sprite_height * 0.1), qty);
}

if (is_selected) {
	DrawSelectedFeedback();
}