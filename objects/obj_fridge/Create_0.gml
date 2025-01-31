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

slot_count = 24;
save_key = "fridge_item_";
inventory = new Inventory(slot_count);

//inventory = new Inventory(24);
//inventory.AddItemIfPossible("protaupe_egg", 10);
//inventory.AddItemIfPossible("protaupe_flour", 5);

function LoadFridgeState() {
	for (var _i = 0; _i < slot_count; _i++)
	{
		var _new_item = new ItemData();
		_new_item.LoadData(save_key + string(_i));

		if (_new_item.IsValid())
			inventory.items[_i] = _new_item;
	}
	
	is_inventory_loaded = true;
}

function SaveFridgeState() {
	for (var _i = 0; _i < slot_count; _i++)
	{
		if (_i >= array_length(inventory.items))
		{
			var _empty_item = new ItemData();
			_empty_item.SaveData(save_key + string(_i));
			continue;
		}
		
		inventory.items[_i].SaveData(save_key + string(_i));
	}
}

function PlayBumpAnimation() {
	var anim_scale_x = new polarca_animation("image_xscale", 0.8, ac_bump_x, 0, 0.08);
	var anim_scale_y = new polarca_animation("image_yscale", 1.2, ac_bump_x, 0, 0.08);
	polarca_animation_start([anim_scale_x, anim_scale_y]);
	
	audio_play_sound(snd_item_arrived, 10, false);
	//StopInteractionBlockedFeedback();
}

function Interact(_interactInstigator) constructor {
	if (instance_exists(_interactInstigator) && _interactInstigator.object_index == obj_player) {
		if (_interactInstigator.HasItemInHands())
		{
			var _item_id = _interactInstigator.item_in_hands.item_id;
			if (!inventory.CanAddItem(_item_id, 1)) { return; } // play feedback ?
		
	        if (_item_id != "none") {
				inventory.AddItemIfPossible(_item_id, 1);
				
				var _to_subscribe = Subscriber(function() { 
					PlayBumpAnimation();
				} );
			
				_interactInstigator.ClearItemInHands(self, _to_subscribe);
				
				SaveFridgeState();
			}
			return;
		}
	}
	
	if (instance_exists(self_hud))
		return;
		
	self_hud = instance_create_layer(view_wport[0] * 0.5, view_hport[0] * 0.5, "GUI", obj_gui_fridge_inventory);
	if (instance_exists(self_hud))
	{
		LoadFridgeState();		
		self_hud.Initialize(inventory);
		
		var _broadcast_save_inventory = Broadcast(function() { 
			SaveFridgeState();
		});
		
		self_hud.on_menu_close = _broadcast_save_inventory;
	}
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