/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//arr_to_spawn_ids = string_split(to_spawn_ids, "|", true);
//spawned = [];

//self_inventory = instance_create_layer(_draw_xs[i], view_hport[0] - 200, "GUI", obj_inventory);
self_hud = noone;

//if (instance_exists(self_inventory))
//{
//	self_inventory.slot_count = 40;
//	self_inventory.display_lines = 5;
	
//}

//inventory = new Inventory(24);
//inventory.AddItemIfPossible("protaupe_egg", 10);
//inventory.AddItemIfPossible("protaupe_flour", 5);

function Interact(_interactInstigator) constructor {
	if (instance_exists(self_hud))
		return;
		
	self_hud = instance_create_layer(view_wport[0] * 0.5, view_hport[0] * 0.5, "GUI", obj_gui_fridge_inventory);
	if (instance_exists(self_hud))
		self_hud.Initialize();
}

// OLD CODE
cone_radius = 70
function GetIdsToSpawn() {	
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
				//newInstance.depth = depth - (spawn_location[1] - y);
				newInstance.depth = 2; // tmp depth hack for proto
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