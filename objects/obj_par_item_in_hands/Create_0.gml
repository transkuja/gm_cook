item_id = "";
is_init = false;
is_dropped = false;
sprite_item_ref = noone;

player_xoffset = 0.0;
player_yoffset = -300.0;

// Outline shader
//handler=shader_get_uniform(shader_outline,"texture_Pixel")
//handler_1=shader_get_uniform(shader_outline,"thickness_power")
//handler_2=shader_get_uniform(shader_outline,"RGBA")

shader_enabled = false;

// Move variables
move_target = noone;
destroy_on_move_end = false;
move_speed = 0.075;

// Drop settings
min_drop_radius = 25;
max_drop_radius = 100;

function Initialize(_itemId, _check_new_recipe = false) {
	item_id = _itemId;
	if (item_id != "none")
	{
		sprite_item_ref = GetItemSprite(item_id);
		sprite_index = sprite_item_ref;
	}
	
	mask_index = spr_no_coll_mask;
	
	is_init = true;
}

function Drop(_x, _y) {
	//x = _x;
	//y = _y;
	
	var _angle = random_range(-pi, 0);
	var _drop_radius = random_range(min_drop_radius, max_drop_radius);
	
	x = _x + (cos(_angle - pi) * _drop_radius);
	y = _y + (sin(_angle - pi) * _drop_radius);
	
	is_dropped = true; 
	mask_index = sprite_item_ref;
	
	depth = -y;
	
	audio_play_sound(Basket_Putdown_01, 10, false);
	SpawnFx(fx_on_drop, 0.25, x, y);
	//CanBePickedUpFeedback(true);
	
}

function PickUp(_pickupInstigator) {
	if (!IsPlayerInstance(_pickupInstigator)) { return; }
	
	is_dropped = false;
	mask_index = spr_no_coll_mask;
	CanBePickedUpFeedback(false);
	
	audio_play_sound(Minimalist1, 10, false);
		
	_pickupInstigator.SetItemInHands(self);
}

initial_layer = layer_get_name(layer);
function CanBePickedUpFeedback(_enable) {
	//if (shader_enabled == _enable)
	//	return; 
		
	//if (_enable) {
	//	var layer_id = layer_get_id("Outline_Instance");
	//	layer_add_instance(layer_id, self);
		
	//	//layer = layer_get_id("Outline_Instance");
	//}
		
		//SetEffectOutline(self);
	//else
	//	RemoveEffectOutline(self, initial_layer);
		
	shader_enabled = _enable;
}

function MoveWithPlayer(_x, _y, _depth) {
	if (is_dropped) { return; }
	x = _x + player_xoffset;
	y = _y + player_yoffset;
	depth = _depth - 5;
}
	
function StartMoveTo(_target, _destroyOnMoveEnd) {
	move_target = _target;
	destroy_on_move_end = _destroyOnMoveEnd;
	is_dropped = true;
	
	depth = -12000;
	
	if (instance_exists(move_target))
	{
		xa = new polarca_animation("x",center_x(move_target),ac_moveItemInTransformer,0,move_speed)
		ya = new polarca_animation("y",center_y(move_target),ac_moveItemInTransformer,0,move_speed)
		sxa = new polarca_animation("image_xscale", 0.25 ,ac_moveItemInTransformer,1,move_speed);
		sya = new polarca_animation("image_yscale", 0.25 ,ac_moveItemInTransformer,1,move_speed);
		
		var _broadcast = Broadcast(function() {
				if (destroy_on_move_end) 
					instance_destroy();
		} );
		
		polarca_animation_start([xa, ya, sxa, sya]).on_animation_finished = _broadcast;
			
		
		return _broadcast;
	}
	else
		return noone;
}

anim_interaction_blocked = noone;
blend_color = c_white;
blend_color_lerp = 0;
anim_speed_conditions_not_met = 0.02;
function BlockedFeedback() {
	if (anim_interaction_blocked != noone)
		instance_destroy(anim_interaction_blocked);
		
	blend_color_lerp = 0;
	blend_color = c_red;
	var _feedback_anim = new polarca_animation("blend_color_lerp", 100, ac_on_off_three, 0, anim_speed_conditions_not_met);
	anim_interaction_blocked = polarca_animation_start([_feedback_anim]);
	anim_interaction_blocked.on_animation_finished = Broadcast(
		function() { 
			anim_interaction_blocked = noone;
			blend_color = c_white;
			image_blend = c_white;
			blend_color_lerp = 0;
	});
}