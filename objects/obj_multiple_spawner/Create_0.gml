/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

arr_to_spawn_ids = string_split(to_spawn_ids, "|", true);
//spawned = [];

function Spawn(_checkInstance = false) {
	if (to_spawn == noone || to_spawn == undefined) return;
	if (array_length(arr_to_spawn_ids) == 0) return;
	
	if (!layer_exists("Instances"))
		layer_create(0,"Instances");
		
	for (var i = 0; i < array_length(arr_to_spawn_ids); i++) {
		if (to_spawn == obj_par_item) {
			var spawn_location = GetPointOnCircle();
			var newInstance = instance_create_layer(spawn_location[0], spawn_location[1], "Instances", to_spawn);
			if (instance_exists(newInstance))
				newInstance.Initialize(arr_to_spawn_ids[i]);
			//_push(spawned, newInstance);
		}
			
	}
	
	if (auto_respawn) { alarm[0] = spawn_cooldown * game_get_speed(gamespeed_fps); }
}

function GetPointOnCircle() {
	var randomAngle = random(360);
	return [x + (cos(randomAngle) * spawn_radius), y + (sin(randomAngle) * spawn_radius) - sprite_height * 0.5];
}