
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
		draw_sprite(_item_sprite, 0, center_x, center_y);
	}

	draw_set_font(fnt_inventory_slot);
	draw_text(x + (sprite_width * 0.1),y + (sprite_height * 0.1), item_data.qty);
}

