item_id = "";
is_init = false;
is_dropped = false;
sprite_item_ref = noone;

player_xoffset = 0.0;
player_yoffset = -200.0;

// Outline shader
//handler=shader_get_uniform(shader_outline,"texture_Pixel")
//handler_1=shader_get_uniform(shader_outline,"thickness_power")
//handler_2=shader_get_uniform(shader_outline,"RGBA")

shader_enabled = false;

// Move variables
move_target = noone;
destroy_on_move_end = false;
move_speed = 0.075;

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
	x = _x;
	y = _y;
	is_dropped = true;
	mask_index = sprite_item_ref;
	
	audio_play_sound(Basket_Putdown_01, 10, false);
	SpawnFx(fx_on_drop, 0.25, x, y);
	CanBePickedUpFeedback(true);
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