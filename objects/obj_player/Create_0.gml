
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

// Transform inputs
cooking_input_object = noone;

current_state = new PlayerIdleState(id, {});
current_state.enter_state();

function ComputeVelocity() {
	velocity_x = gamepad_axis_value(0, gp_axislh);
	if (abs(velocity_x) < 0.1)
	{
		if (keyboard_check(vk_right) || keyboard_check(ord("D"))) velocity_x = 1;
		else if (keyboard_check(vk_left) || keyboard_check(ord("Q"))) velocity_x = -1;
		else velocity_x = 0;
	}
	
	velocity_y = gamepad_axis_value(0, gp_axislv);
	if (abs(velocity_y) < 0.1)
	{
		if (keyboard_check(vk_up) || keyboard_check(ord("Z"))) velocity_y = -1;
		else if (keyboard_check(vk_down) || keyboard_check(ord("S"))) velocity_y = 1;
		else velocity_y = 0;
	}
	
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
function ClearItemInHands(_target) { 
	if (instance_exists(_target))
		item_in_hands.StartMoveTo(_target, true);
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
		if (gamepad_button_check_pressed(0, gp_face3) || keyboard_check_pressed(vk_space)) {
			last_interactible_detected.Interact(self);
			return;
		}
	}

	// Press A / Enter button
	if (gamepad_button_check_pressed(0, gp_face1) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left)) {
		if (instance_exists(last_portable_item_detected)) {
			if (!HasItemInHands()) {
				last_portable_item_detected.PickUp(self);
				return;
			}
		}
		
		if (instance_exists(last_transformer_detected)) {
			if (HasItemInHands()) {
				if (!last_transformer_detected.IsFilled()) {
					last_transformer_detected.PutItemIn(item_in_hands.item_id);
					ClearItemInHands(last_transformer_detected);
					return;
				} 
				else {
					last_transformer_detected.PlayFilledFeedbacks();
					return;
				}
			}
			// No item in hand
			else {
				if (!last_transformer_detected.ContainsAnItem()) { return; }
				
				last_transformer_detected.HandleTakeItem(self);
				return;
			}
		}
		
		if (HasItemInHands()) {
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
	
	if (!instance_exists(inst_inventory)) { _log("No inventory instance in room !!!"); return; }
	if (!inst_inventory.IsSelectedItemValid()) { 
		// TODO: feedback item selected not valid
		return; 
	}
	
	var _itemId = inst_inventory.UseSelectedItem();
	
	CreateItemInHands(_itemId);
}

function CheckInputsInventory() {
	if (gamepad_button_check_pressed(0, gp_face4) || mouse_check_button_pressed(mb_right)) {
		if (!instance_exists(item_in_hands)) {
			GetItemFromInventoryToHands();
		}
	}
}

function UpdateItemInHands() {
	if (!instance_exists(item_in_hands)) { return; }
	
	item_in_hands.MoveWithPlayer(x, y, depth);
}

function CheckCookingInput() {
	if (!instance_exists(cooking_input_object)) { return false; }
	
	if (gamepad_button_check_pressed(0, gp_face1) ||
			mouse_check_button_pressed(mb_left) || 
			gamepad_button_check_pressed(0, gp_face3) || 
			keyboard_check_pressed(vk_space) ||
			keyboard_check_pressed(vk_enter)) {
		cooking_input_object.OnInputPressed();
		
		// TODO: play anim on player
		
		if (instance_exists(last_transformer_detected)) {
			last_transformer_detected.TransformingFeedbacks();
		}
		
		return true;
	}
	
	return false;
}

function IsCooking() {
	return instance_exists(cooking_input_object);
}