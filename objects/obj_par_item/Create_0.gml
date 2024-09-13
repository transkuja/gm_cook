
is_collected = false;
is_magnetized = false;

// Magnet
magnet_speed = 2;
end_radius = 40
lerp_param = 0;
lerp_origin_x = 0;
lerp_origin_y = 0;
target_offset_y = -50;

// Debug
draw_debug = true;

image_xscale = 0.5;
image_yscale = 0.5;

function Initialize(_item_id) {
	item_id = _item_id;
	if (item_id != "none")
		sprite_index = GetItemSprite(_item_id);
}

function StartMagnet() {
	// TODO: can collect ? (inventory full)
	if (is_collected || is_magnetized) return;		
	
	if (instance_exists(inst_inventory) && !inst_inventory.CanAddItem(item_id, 1))
		return;
		
	if (instance_exists(inst_player)) {
		lerp_param = 0;
		lerp_origin_x = x;
		lerp_origin_y = y;
		is_magnetized = true;
	}
}

function Collect() {
	if (is_collected) return;
	
	is_magnetized = false;
	
	if (instance_exists(inst_inventory)) {
		if (!inst_inventory.CanAddItem(item_id, 1))
			return;
			
		inst_inventory.AddItem(new ItemData(item_id, 1, stack));
		is_collected = true;
		audio_play_sound(splash0, 10, false);
		instance_destroy();
	}
}
