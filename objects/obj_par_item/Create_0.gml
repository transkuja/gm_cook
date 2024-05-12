
is_collected = false;
is_magnetized = false;

// Magnet
magnet_speed = 2;
end_radius = 40
lerp_param = 0;
lerp_origin_x = 0;
lerp_origin_y = 0;

// Debug
draw_debug = true;

image_xscale = 0.5;
image_yscale = 0.5;

function StartMagnet() {
	// TODO: can collect ? (inventory full)
	if (is_collected || is_magnetized) return;		
	
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
		is_collected = true;
		inst_inventory.AddItem(new ItemData(item_id, gui_sprite, 1, stack));
		instance_destroy();
	}
}
