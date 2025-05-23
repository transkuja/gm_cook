
velocity_x = 0;
velocity_y = 0;
current_speed = 0;

// Old values
//min_speed = 150;
//max_speed = 450;
//sprint_max_speed = 650;

min_speed = 300;
max_speed = 600;
sprint_max_speed = 800;
sprint_burst = 650;

acceleration_factor = (max_speed - min_speed) * 2;
current_max_speed = max_speed;
sprinting = false;

state = PLAYER_STATE.IDLE;
dir = DIRECTION_ENUM.RIGHT;

playerSpr[PLAYER_STATE.IDLE] = spr_chr_monkey_idle;
playerSpr[PLAYER_STATE.WALKING] = spr_chr_monkey_walk;

// Scale
default_xscale = image_xscale;
scale_flip = -1;
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

play_left_footstep = false;

min_x_depth_sorting = 340;
max_x_depth_sorting = 910;
min_y_depth_sorting = 580;
max_y_depth_sorting = 670;

image_xscale = default_xscale * current_scale * scale_flip;

global.player_instance = self;

function ComputeVelocity() {
	var _stick_horizontal = gamepad_axis_value(0, gp_axislh);
	var _stick_vertical = gamepad_axis_value(0, gp_axislv);
	
	if (VectorLength(_stick_horizontal, _stick_vertical) > 0.01)
	{
		velocity_x = _stick_horizontal;
		velocity_y = _stick_vertical;
	}
	else
	{
		velocity_x = input_get(0, "move_right") - input_get(0, "move_left");
		velocity_y = input_get(0, "move_down") - input_get(0, "move_up");
	}
	
	var _normalized_velocity = NormalizeVector(velocity_x, velocity_y);
	velocity_x = _normalized_velocity[0];
	velocity_y = _normalized_velocity[1];
}

function HandleAcceleration(_dt) {
	if (velocity_x != 0 || velocity_y != 0) {
		if (current_speed < current_max_speed) {
			if (current_speed < min_speed) current_speed = min_speed;
			current_speed += _dt * acceleration_factor * (sprinting ? 2 : 1);	

			current_speed = clamp(current_speed, min_speed, current_max_speed);
		}
		else {
			current_speed -= _dt * acceleration_factor * 2;
		}
	}
	else
		current_speed = 0;
}

function UpdateFacingDirection() {
	// Change direction based on movement
	if (velocity_x > 0) { dir = DIRECTION_ENUM.RIGHT; scale_flip = -1;}
	if (velocity_x < 0) { dir = DIRECTION_ENUM.LEFT; scale_flip = 1;}
	
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
	if (global.player_control == 0 && !global.inventory_mode)
	{
		var _dt = delta_time * 0.000001;
			
		ComputeVelocity();
		HandleAcceleration(_dt);
	
		var _vel_x_next_frame =	velocity_x * current_speed * _dt;
		var _vel_y_next_frame =	velocity_y * current_speed * _dt;
		
		var _x_blocked = true;
		var _y_blocked = true;
			
		if (!collision_point(x + _vel_x_next_frame, y, obj_static, true, true) && 
			!collision_point(x + _vel_x_next_frame, y, obj_par_npc, true, true))
		{
			_x_blocked = false;
		}
		
		if (!collision_point(x, y + _vel_y_next_frame, obj_static, true, true) &&
			!collision_point(x, y + _vel_y_next_frame, obj_par_npc, true, true))
		{
			_y_blocked = false;
		}
			
		
		if (!_x_blocked)
			velocity_x += (_y_blocked && abs(velocity_x) > 0 ? -velocity_y*0.5 : 0);
		else
			velocity_x = 0;
			
		if (!_y_blocked)
			velocity_y += (_x_blocked && abs(velocity_y) > 0 ? -velocity_x*0.5 : 0);
		else
			velocity_y = 0;
		
		velocity_x = clamp(velocity_x, -1, 1);
		velocity_y = clamp(velocity_y, -1, 1);
		
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
				item_detected.StartMagnet(self);
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
	
	_log("Create item in hands with id: ", _itemId);
	
	audio_play_sound(Minimalist1, 10, false);
	
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
	_log("DEBUG: interact input");
	if (global.player_control < 0 || global.interact_blocked || global.inventory_mode)	{ return; }

	// Press X / Space button
	if (instance_exists(last_interactible_detected)) {
		if (input_get_pressed(0, "interact")) {
			last_interactible_detected.Interact(self);
			return;
		}
		
		if (input_get_pressed(0, "item_action")) {
			last_interactible_detected.ItemInteraction(self);
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
			// If can't interact, play feedback on item in hands
			last_transformer_detected.ItemInteraction(self);
			return;
		}
		else if (HasItemInHands()) {
			_log("Dropping item !");
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
	
	var _inventory = TryGetGlobalInstance(GLOBAL_INSTANCES.INVENTORY);
	if (!instance_exists(_inventory)) { _log("ERROR: No inventory instance in room !!!"); return; }
	if (!_inventory.IsSelectedItemValid()) { 
		_log("Selected item not valid, cant take out !");
		// TODO: feedback item selected not valid
		return; 
	}
	
	var _itemId = _inventory.UseSelectedItem();
	
	CreateItemInHands(_itemId);
}

function CheckInputsInventory() {
	if (global.player_control < 0 || global.inventory_mode)	{ return; }
	
	if (input_get_pressed(0, "take_out")) {
		if (!instance_exists(item_in_hands)) {
			GetItemFromInventoryToHands();
		}
		else {
			var _inventory = TryGetGlobalInstance(GLOBAL_INSTANCES.INVENTORY);
			if (instance_exists(_inventory)) {
				if (_inventory.AddItemIfPossible(item_in_hands.item_id, 1)) {
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
	if (global.player_control < 0)	{ return; }

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

xprev = 0;
yprev = 0;
function CreateTrailParticle() {
	if (fx_trail != noone)
	{
		var p_dir = point_direction(x,y - sprite_height * 0.5,xprev,yprev)

		part_type_orientation(global.pt_flare_particles, p_dir, p_dir, 0, 0, 0);

		part_particles_create(global.ps_above,x,y - sprite_height * 0.5,global.pt_flare_particles,1) 
		
		xprev = x;
		yprev = y - sprite_height * 0.5;
	}
}

min_x_check_enviro = 25;
min_y_check_enviro = 150;
max_x_check_enviro = 75;
max_y_check_enviro = 100;

debug_draw_enviro_detected = false;
debug_draw_enviro_detected_x = 0;
debug_draw_enviro_detected_y = 0;

depth_override = true;
depth_override_value = 0;
function CheckEnviroAround() {
	var _items_detected = ds_list_create();
	
	var x_min = dir == DIRECTION_ENUM.LEFT ? x - min_x_check_enviro : x + min_x_check_enviro;
	var x_max = dir == DIRECTION_ENUM.LEFT ? x + max_x_check_enviro : x - max_x_check_enviro;
	var _count = collision_rectangle_list(
		x_min,
		y - min_y_check_enviro,
		x_max,
		y + max_y_check_enviro,
		obj_par_enviro, false, false, _items_detected, false);
	
	var is_behind = false;
	depth_override = false;
	var _max_depth_value = 99999;
	var _lowest_bbox_top = -1000000;
	var _item_to_use = undefined;
	
	if (_count > 0)
	{
		for (var i = 0; i < _count; ++i;)
		{
			var item_detected = _items_detected[| i];
			if (item_detected != noone && item_detected != undefined)
			{
				if (!item_detected.use_depth_sorting)
					continue;
					
				if (item_detected.bbox_top > _lowest_bbox_top)
				{
					_lowest_bbox_top = item_detected.bbox_top;
					_item_to_use = item_detected;
				}
			}
		}
	}
	
	if (_item_to_use != undefined)
	{
		if (y - sprite_height * 0.4 < _item_to_use.bbox_top)
		{
			depth_override_value = _item_to_use.depth + 1;
			depth_override = true;
		}
				
		debug_draw_enviro_detected = true;
		debug_draw_enviro_detected_x = _item_to_use.x;
		debug_draw_enviro_detected_y = _item_to_use.y;
	}
	else
		debug_draw_enviro_detected = false;

	ds_list_destroy(_items_detected);
}

#region Inputs
function InteractInput() {
	if (global.player_control < 0 || global.interact_blocked || global.inventory_mode)	{ return; }

	// Press X / Space button
	if (instance_exists(last_interactible_detected)) {
		last_interactible_detected.Interact(self);
	}
}

function ItemActionInput() {
	if (global.player_control < 0 || global.interact_blocked || global.inventory_mode)	{ return; }

	// Press X / Space button
	if (instance_exists(last_interactible_detected)) {
		last_interactible_detected.ItemInteraction(self);
		return;
	}

	// Press A / Enter button
	if (instance_exists(last_portable_item_detected)) {
		if (!HasItemInHands()) {
			last_portable_item_detected.PickUp(self);
			return;
		}
	}
		
	if (instance_exists(last_transformer_detected)) {
		// If can't interact, play feedback on item in hands
		last_transformer_detected.ItemInteraction(self);
		return;
	}
	else if (HasItemInHands()) {
		_log("Dropping item !");
		item_in_hands.Drop(x, y);
		item_in_hands = noone;
		return;
	}
}

function TakeOutInput() {
	if (global.player_control < 0 || global.inventory_mode)	{ return; }
	if (state == PLAYER_STATE.TRANSFORMING) return;
	
	if (!instance_exists(item_in_hands)) {
		GetItemFromInventoryToHands();
	}
	else {
		var _inventory = TryGetGlobalInstance(GLOBAL_INSTANCES.INVENTORY);
		if (instance_exists(_inventory)) {
			if (_inventory.AddItemIfPossible(item_in_hands.item_id, 1)) {
				ClearItemInHands(noone, noone);
			}
		}
	}
}

function CancelInteractionInput() {
	//if (global.player_control < 0)	{ return; }
	if (current_state)
		current_state.cancel_interaction_pressed();
}

function QteInput() {
	//if (global.player_control < 0)	{ return; }
	
	if (current_state)
		current_state.qte_input_pressed();
}

function SprintInputPressed() {
	if (global.player_control < 0 || global.inventory_mode)	{ return; }
	if (state != PLAYER_STATE.IDLE && state != PLAYER_STATE.WALKING) return;
	
	current_max_speed = sprint_max_speed;
	sprinting = true;
	
	if (velocity_x != 0 || velocity_y != 0) {
		if (current_speed < current_max_speed) {
			current_speed += sprint_burst;
		}
	}
				
}

function SprintInputReleased() {
	current_max_speed = max_speed;
	sprinting = false;
}
#endregion

interact_pressed_event = noone;
item_action_pressed_event = noone;
take_out_pressed_event = noone;
qte_pressed_event = noone;
cancel_interaction_pressed_event = noone;
sprint_input_pressed_event = noone;
sprint_input_released_event = noone;
function BindInputs() {
	interact_pressed_event = BindEventToInput("interact", INPUT_EVENTS.PRESSED, function() { InteractInputCheck(); });
	item_action_pressed_event = BindEventToInput("item_action", INPUT_EVENTS.PRESSED, function() { ItemActionInput(); });
	take_out_pressed_event = BindEventToInput("take_out", INPUT_EVENTS.PRESSED, function() { TakeOutInput(); });
	qte_pressed_event = BindEventToInput("qte", INPUT_EVENTS.PRESSED, function() { QteInput(); });
	cancel_interaction_pressed_event = BindEventToInput("cancel_interaction", INPUT_EVENTS.PRESSED, function() { CancelInteractionInput(); });
	sprint_input_pressed_event = BindEventToInput("sprint", INPUT_EVENTS.PRESSED, function() { SprintInputPressed(); });
	sprint_input_released_event = BindEventToInput("sprint", INPUT_EVENTS.RELEASED, function() { SprintInputReleased(); });

}

function ClearInputs() {
	if (interact_pressed_event != noone) interact_pressed_event.destroy();		
	if (item_action_pressed_event != noone) item_action_pressed_event.destroy();		
	if (take_out_pressed_event != noone) take_out_pressed_event.destroy();		
	if (qte_pressed_event != noone) qte_pressed_event.destroy();
	if (cancel_interaction_pressed_event != noone) cancel_interaction_pressed_event.destroy();
	if (sprint_input_pressed_event != noone) sprint_input_pressed_event.destroy();
	if (sprint_input_released_event != noone) sprint_input_released_event.destroy();
}

function Initialize() {
}

alarm[1] = 30;
//BindInputs(); // TODO: Move to gamemanager ?
