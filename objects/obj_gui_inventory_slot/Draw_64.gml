
draw_self();

// Selected feedback
if (is_selected) {
	DrawSelectedFeedback();
}

// Slot content
if (!is_struct(item_data) || !struct_exists(item_data, "qty")) { return; }

if (item_data.qty > 0) {
	var _item_sprite = GetItemSprite(item_data.item_id);
	if (_item_sprite != noone && _item_sprite != undefined && _item_sprite != -1) {
		draw_sprite_ext(_item_sprite, 0, _center_x, _center_y, item_scale, item_scale, 0, c_white, 1);
	}

	draw_set_font(fnt_inventory_slot);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle)
	//draw_text(x + (sprite_width * 0.2),y + (sprite_height * 0.2), item_data.qty);
	draw_text_ext_transformed(x + (sprite_width * 0.2),y + (sprite_height * 0.15), item_data.qty, 
		0, 50, 1 + animated_scale_x,1 + animated_scale_y,0);
		
}

