/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//arr_to_spawn_ids = string_split(to_spawn_ids, "|", true);
//spawned = [];

function GetIdsToSpawn() {
	var quest_status = save_data_get("q_protaupe_salad");
	if (quest_status != "done")
		return ["protaupe_fruit_a", "protaupe_fruit_b"];
	
	quest_status = save_data_get("q_protaupe_galette");
	if (quest_status == "pending")
		return ["protaupe_fruit_a", "protaupe_egg", "protaupe_flour"];
		
	quest_status = save_data_get("q_protaupe_ratatouille");
	if (quest_status == "pending")
		return ["protaupe_fruit_a", "protaupe_fruit_b", "protaupe_egg"];
		
	quest_status = save_data_get("q_protaupe_ratatouille2");
	if (quest_status == "pending")
		return ["protaupe_fruit_a", "protaupe_fruit_b", "protaupe_egg"];
		
	return ["protaupe_fruit_a", "protaupe_fruit_b"];
}

function Spawn(_checkInstance = false) {
	if (to_spawn == noone || to_spawn == undefined) return;
	
	if (!layer_exists("Instances"))
		layer_create(0,"Instances");
		
	var arr_to_spawn_ids = GetIdsToSpawn();
	if (array_length(arr_to_spawn_ids) == 0) return;

	var _spawnInitialAngle = random(360);
	var _offset = 360 / array_length(arr_to_spawn_ids);
	
	for (var i = 0; i < array_length(arr_to_spawn_ids); i++) {
		if (to_spawn == obj_par_item) {
			var spawn_location = GetPointOnCircleFromIndex(_spawnInitialAngle, _offset, i);
			var newInstance = instance_create_layer(spawn_location[0], spawn_location[1], "Instances", to_spawn);
			if (instance_exists(newInstance))
				newInstance.Initialize(arr_to_spawn_ids[i]);
			//_push(spawned, newInstance);
		}
			
	}
	
	if (auto_respawn) { alarm[0] = spawn_cooldown * game_get_speed(gamespeed_fps); }
}

function GetPointOnCircleFromIndex(_start, _offset, _index) {
	var angle = (_start + _index * _offset) % 360;
	return [x + (cos(angle) * spawn_radius), y + (sin(angle) * spawn_radius) - sprite_height * 0.5];
}

function GetPointOnCircle() {
	var randomAngle = random(360);
	return [x + (cos(randomAngle) * spawn_radius), y + (sin(randomAngle) * spawn_radius) - sprite_height * 0.5];
}