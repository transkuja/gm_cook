
velocity_x = 0;
velocity_y = 0;
current_speed = 0;

max_speed = 450;
acceleration_factor = max_speed * 2;

state = PLAYER_STATE.IDLE;
dir = DIRECTION_ENUM.RIGHT;

playerSpr[PLAYER_STATE.IDLE] = spr_player_idle;
playerSpr[PLAYER_STATE.WALKING] = spr_player_run;

// Scale
default_xscale = image_xscale;
scale_flip = 1;
current_scale = 1;

// Item detection
collect_radius = 120;
interact_radius = 80;
pick_up_radius = 50;
interact_prompt_instance = noone;
last_interactible_detected = noone;
last_transformer_detected = noone;
last_portable_item_detected = noone;
detection_offset_y = -50;

draw_debug = true;

// For prepared items
item_in_hands = noone; 

current_state = new PlayerIdleState(id, {});
current_state.enter_state();

function ComputeVelocity() {
	velocity_x = input_get(0, "move_right") - input_get(0, "move_left"); 
	velocity_y = input_get(0, "move_down") - input_get(0, "move_up"); 
	
	var _normalized_velocity = NormalizeVector(velocity_x, velocity_y);
	velocity_x = _normalized_velocity[0];
	velocity_y = _normalized_velocity[1];
}

function HandleAcceleration(_dt) {
	if (velocity_x != 0 || velocity_y != 0) {
		if (current_speed < max_speed) {
			current_speed += _dt * acceleration_factor;
			current_speed = clamp(current_speed, 0, max_speed);
		}
	}
	else
		current_speed = 0;
}

function UpdateFacingDirection() {
	// Change direction based on movement
	if (velocity_x > 0) { dir = DIRECTION_ENUM.RIGHT; scale_flip = 1;}
	if (velocity_x < 0) { dir = DIRECTION_ENUM.LEFT; scale_flip = -1;}
	
	image_xscale = default_xscale * current_scale * scale_flip;
}
	
function IsStopped() { return velocity_x == 0 && velocity_y == 0; }
function HasItemInHands() {	return instance_exists(item_in_hands); }
function ClearItemInHands(_target, _event) { 
	if (instance_exists(_target))
	{
		var _on_move_finished = item_in_hands.StartMoveTo(_target, true);
		if (_event != noone)
			_event.watch(_on_move_finished);
	}
	else
		instance_destroy(item_in_hands);
		
	item_in_hands = noone; 
}

function ComputeVelocityFromInputs() {
	if (global.player_control == true)
	{
		var _dt = delta_time * 0.000001;
	
		ComputeVelocity();
		HandleAcceleration(_dt);
	
		velocity_x *= current_speed * _dt;
		velocity_y *= current_speed * _dt;
	}
	else
	{
		current_speed = 0;
		velocity_x = 0;
		velocity_y = 0;
	}
	
}

function ItemDetection() {
	var _items_detected = ds_list_create();
	var _count = collision_circle_list(x,y + detection_offset_y, collect_radius, obj_par_item, false, false, _items_detected, false);
	
	if (_count > 0)
	{
		for (var i = 0; i < _count; ++i;)
		{
			var item_detected = _items_detected[| i];
			if (item_detected != noone && item_detected != undefined) {
				item_detected.StartMagnet();
			}
		}
	}	
	
	ds_list_destroy(_items_detected);
}

function InteractibleDetection() {
	var _detected = collision_circle(x,y+detection_offset_y, interact_radius, obj_par_interactible, false, false);
	
	if (_detected != noone && _detected != undefined) {
		if (last_interactible_detected == _detected) { return; }
		
		if (instance_exists(last_interactible_detected)) {
			last_interactible_detected.ResetFeedback();
		}
		
		_detected.InRangeFeedback();
		last_interactible_detected = _detected;
	}
	else
	{
		if (instance_exists(last_interactible_detected)) {
			last_interactible_detected.ResetFeedback();
			last_interactible_detected = noone;
		}
		
		if (instance_exists(interact_prompt_instance))
			instance_destroy(interact_prompt_instance);
	}
	
}

function TransformerDetection() {
	var _detected = collision_circle(x,y+detection_offset_y, interact_radius, obj_par_transformer, false, false);
	
	if (_detected != noone && _detected != undefined) {
		if (last_transformer_detected == _detected) { return; }
		
		if (instance_exists(last_transformer_detected)) {
			last_transformer_detected.ResetFeedback();
		}
		
		_detected.InRangeFeedback();
		last_transformer_detected = _detected;
	}
	else
	{
		if (instance_exists(last_transformer_detected)) {
			last_transformer_detected.ResetFeedback();
			last_transformer_detected = noone;
		}
		
		if (instance_exists(interact_prompt_instance))
			instance_destroy(interact_prompt_instance);
	}
}

function PortableItemDetection() {
	if (HasItemInHands()) { return; }
	
	var _detected = collision_circle(x,y+detection_offset_y, pick_up_radius, obj_par_item_in_hands, false, false);
	
	if (_detected != noone && _detected != undefined) {
		if (last_portable_item_detected == _detected) { return; }
		
		if (instance_exists(last_portable_item_detected)) {
			last_portable_item_detected.CanBePickedUpFeedback(false);
		}
		
		_detected.CanBePickedUpFeedback(true);
		last_portable_item_detected = _detected;
	}
	else
	{
		if (instance_exists(last_portable_item_detected)) {
			last_portable_item_detected.CanBePickedUpFeedback(false);
			last_portable_item_detected = noone;
		}
		
		if (instance_exists(interact_prompt_instance))
			instance_destroy(interact_prompt_instance);
	}
}

function CreateItemInHands(_itemId) {
	if (instance_exists(item_in_hands) || _itemId == "none" || _itemId == "") { return; }
	
	item_in_hands = instance_create_layer(
						x, 
						y,
						"Instances", obj_par_item_in_hands);
	
	if (instance_exists(item_in_hands)) {
		item_in_hands.Initialize(_itemId);
		UpdateItemInHands();
	}
}

function SetItemInHands(_item_inst) {
	if (HasItemInHands() || !instance_exists(_item_inst)) { return; }
	
	item_in_hands = _item_inst;
	UpdateItemInHands();
}

// TODO: externalize in InputManager
function InteractInputCheck() {
	if (global.player_control == false)	{ return; }

	// Press X / Space button
	if (instance_exists(last_interactible_detected)) {
		if (input_get_pressed(0, "interact")) {
			last_interactible_detected.Interact(self);
			return;
		}
	}

	// Press A / Enter button
	if (input_get_pressed(0, "item_action")) {
		if (instance_exists(last_portable_item_detected)) {
			if (!HasItemInHands()) {
				last_portable_item_detected.PickUp(self);
				return;
			}
		}
		
		if (instance_exists(last_transformer_detected)) {
			last_transformer_detected.ItemInteraction(self);
			return;

		}
		else if (HasItemInHands()) {
			item_in_hands.Drop(x, y);
			item_in_hands = noone;
			return;
		}
	}
}



function GetItemFromInventoryToHands() {
	if (instance_exists(item_in_hands)) {
		// TODO: smthg ? play sound at least	
		return;
	}
	
	if (!instance_exists(inst_inventory)) { _log("ERROR: No inventory instance in room !!!"); return; }
	if (!inst_inventory.IsSelectedItemValid()) { 
		// TODO: feedback item selected not valid
		return; 
	}
	
	var _itemId = inst_inventory.UseSelectedItem();
	
	CreateItemInHands(_itemId);
}

function CheckInputsInventory() {
	if (global.player_control == false)	{ return; }
	
	if (input_get_pressed(0, "take_out")) {
		if (!instance_exists(item_in_hands)) {
			GetItemFromInventoryToHands();
		}
		else {
			if (instance_exists(inst_inventory)) {
				if (inst_inventory.CanAddItem(item_in_hands.item_id, 1)) {
					inst_inventory.AddItem(new ItemData(item_in_hands.item_id, 1, 1));
					ClearItemInHands(noone, noone);
				}
			}
		}
	}
}

function UpdateItemInHands() {
	if (!instance_exists(item_in_hands)) { return; }
	
	item_in_hands.MoveWithPlayer(x, y, depth);
}

function CheckCookingInput() {
	if (global.player_control == false)	{ return; }

	if (instance_exists(last_interactible_detected)) {
		if (input_get_pressed(0 , "qte")) {
					
			//last_interactible_detected.Interact(self);
			//// TODO: play anim on player
		
			//if (instance_exists(last_transformer_detected)) {
			//	last_transformer_detected.TransformingFeedbacks();
			//}
		
			return true;
		}
	}
	else {
		if (current_state) 
			current_state.transition_to(new PlayerIdleState(self));
		return false;
	}
	
	return false;
}

function IsCooking() {
	return state == PLAYER_STATE.TRANSFORMING;
}