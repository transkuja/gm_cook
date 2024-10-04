is_ready = false;
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
draw_debug = false;

image_xscale = 0.5;
image_yscale = 0.5;

player_ref = noone;

part_sys_trail_list = ds_list_create();

function Initialize(_item_id) {
	item_id = _item_id;
	if (item_id != "none")
		sprite_index = GetItemSprite(_item_id);
		
	alarm[0] = seconds(0.25); // set is ready
}

function StartMagnet(_player) {
	// TODO: can collect ? (inventory full)
	if (!is_ready) return;
	if (is_collected || is_magnetized) return;		
	
	if (instance_exists(inst_inventory) && !inst_inventory.CanAddItem(item_id, 1))
		return;
		
	if (instance_exists(_player)) {
		player_ref = _player;
		lerp_param = 0;
		lerp_origin_x = x;
		lerp_origin_y = y;
		is_magnetized = true;
	}
}

//fx_on_collect_inst = noone;
function Collect() {
	if (!is_ready) return;
	if (is_collected) return;
	
	is_magnetized = false;
	
	if (instance_exists(inst_inventory)) {
		if (!inst_inventory.AddItemIfPossible(item_id, 1))
			return;
			
		is_collected = true;
		audio_play_sound(splash0, 10, false);
		
		// Spawn fx
		if (instance_exists(player_ref))
			SpawnFx(fx_on_collect, 0.25, player_ref.x + random_range(-15, 15), player_ref.y + target_offset_y + random_range(-15, 15));
		else
			SpawnFx(fx_on_collect, 0.25, x + random_range(-15, 15), y + random_range(-15, 15));
		
		
		instance_destroy();
	}
}

function CreateTrailParticle(_dir_x, _dir_y) {
	if (is_collected) 
		return;	
		
	if (fx_trail != noone)
	{
		fx_inst = part_system_create(fx_trail);
		//part_system_layer(fx_inst, layer_get_id("FX"));
		part_system_position(fx_inst, x, y);
		part_system_depth(fx_inst, depth + 1);
		
		part_system_angle(fx_inst, GetAngleVectorsDegrees(1, 0, _dir_x, _dir_y));
		ds_list_add(part_sys_trail_list, fx_inst);
	}
}
