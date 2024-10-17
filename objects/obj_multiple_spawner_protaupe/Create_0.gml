/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//arr_to_spawn_ids = string_split(to_spawn_ids, "|", true);
//spawned = [];

cone_radius = 70
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
	else if (quest_status == "done")
		return ["protaupe_fruit_a", "protaupe_fruit_b", "protaupe_egg", "protaupe_flour"];
		
	return ["protaupe_fruit_a", "protaupe_fruit_b"];
}

function Spawn(_checkInstance = false) {
	if (to_spawn == noone || to_spawn == undefined) return;
	
	audio_play_sound(Fridge_Door_Open_01, 10, false);
	
	if (!layer_exists("Instances"))
		layer_create(0,"Instances");
		
	var arr_to_spawn_ids = GetIdsToSpawn();
	if (array_length(arr_to_spawn_ids) == 0) return;

	//var _spawnInitialAngle = random(360);
	//var _offset = 360 / array_length(arr_to_spawn_ids);
	var _offset = cone_radius / array_length(arr_to_spawn_ids);
	var _spawnInitialAngle = 90 + random_range(-cone_radius*0.5, -cone_radius*0.5 + _offset);
		
	for (var i = 0; i < array_length(arr_to_spawn_ids); i++) {
		if (to_spawn == obj_par_item) {
			var spawn_location = GetPointOnCircleFromIndex(_spawnInitialAngle, _offset, i);
			var newInstance = instance_create_layer(spawn_location[0], spawn_location[1], "Instances", to_spawn);
			if (instance_exists(newInstance)) {
				SpawnFx(fx_on_spawn, 0.25, spawn_location[0], spawn_location[1]);
				newInstance.Initialize(arr_to_spawn_ids[i]);
				newInstance.depth = depth - (spawn_location[1] - y);
			}
			//_push(spawned, newInstance);
		}
			
	}
	
	if (auto_respawn) { alarm[0] = spawn_cooldown * game_get_speed(gamespeed_fps); }
}

function GetPointOnCircleFromIndex(_start, _offset, _index) {
	var angle = (_start + _index * _offset) % 360;
	return [x + (cos(degtorad(angle)) * spawn_radius), y + (sin(degtorad(angle)) * spawn_radius) - sprite_height * 0.5];
}

function GetPointOnCircle() {
	var randomAngle = random(360);
	return [x + (cos(degtorad(randomAngle)) * spawn_radius), y + (sin(degtorad(randomAngle)) * spawn_radius) - sprite_height * 0.5];
}