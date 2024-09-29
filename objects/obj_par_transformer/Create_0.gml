event_inherited()

state = TRANSFORMER_STATE.EMPTY;
items_in_ids = array_create(0, "none");
items_pending = array_create(0, "none");
qte_holder = noone;
is_interact_locked = false;

// Draw items offset for animations
offset_draw_item = 0;
max_offset_draw_item = 10;
offset_draw_speed = 0.03;
item_in_scale_x = 0;
item_in_scale_y = 0;

initial_scale_x = image_xscale;
initial_scale_y = image_yscale;

// On A pressed
function PutItemIn(_item_id) {
	if (IsFilled()) {
		PlayFilledFeedbacks()
		return;
	}
	
	if (_item_id != "none")
		_push(items_pending, _item_id);
	
}

function ConfirmPendingItem() {
	if (array_length(items_pending) == 0) return;
	
	var _itemId = items_pending[0];		
	array_remove(items_pending, _itemId);
	_push(items_in_ids, _itemId);
	
	var anim_scale_x = new polarca_animation("image_xscale", 0.8, ac_bump_x, 0, 0.08);
	var anim_scale_y = new polarca_animation("image_yscale", 1.2, ac_bump_x, 0, 0.08);
	polarca_animation_start([anim_scale_x, anim_scale_y]);
	
	audio_play_sound(snd_item_arrived, 10, false);
	
	_log("Transformer content:");
	for (var i = 0; i < array_length(items_in_ids); i++)
		_log(items_in_ids[i]);
	_log(array_length(items_pending));
}

function IsItemValid(_itemId) {
	return true;	
}

function ItemInteraction(_interactInstigator) {
	if (current_state)
		current_state.process_item_interaction(_interactInstigator);
}

function CheckIsNewRecipe(_item_id) {
	if (_item_id == "") 
		return false;
		
	if (state != TRANSFORMER_STATE.RESULT)
		return false;
	
	if (GetItemType(_item_id) == ITEM_TYPE.RECIPE_FINAL) {
		save_check = save_data_get(_item_id + "_unlocked");
		return save_check == undefined || !save_check;
	}
	
	return false;
}

// After operation, A
function TakeFrom(_interactInstigator) {
	if (instance_exists(_interactInstigator) && _interactInstigator.object_index == obj_player) {
		if (_interactInstigator.HasItemInHands())
			return false;
	}
		
	var _item_removed = items_in_ids[array_length(items_in_ids) - 1];
	array_remove(items_in_ids, _item_removed);
		
	_interactInstigator.CreateItemInHands(_item_removed);
	
	if (CheckIsNewRecipe(_item_removed)) {
		var popup = instance_create_layer(x,y, "GUI", obj_gui_par_popup);
		popup.Initialize(_item_removed);
		
		save_data_set(_item_removed + "_unlocked", true);
	}
	
	return true;
}

function IsTransformable() {
	return true;
}

// On A pressed
function Interact(_interactInstigator) {
	if (current_state)
		current_state.process_interaction(_interactInstigator);
}

// Retrieve what has been put in, in case of mistake
function EmptyTransformer() {
	
}

// At least one item in
function ContainsAnItem() {
	return array_length(items_in_ids) > 0;
}

function IsFilled() {
	// array_remove(items_in_ids, "none");
	return array_length(items_in_ids) + array_length(items_pending) == max_items;
}


function PlayFilledFeedbacks() {
	_log("Filled !");
}

cur_transforming_anm = noone;

function TransformingFeedbacks() {
	if (instance_exists(cur_transforming_anm))
		instance_destroy(cur_transforming_anm);
		
	image_xscale = 1;
	image_yscale = 1;
	
	var anim_scale_x = new polarca_animation("image_xscale", 1.2, ac_bump_x, 0, 0.3);
	var anim_scale_y = new polarca_animation("image_yscale", 0.8, ac_bump_x, 0, 0.3);
	cur_transforming_anm = polarca_animation_start([anim_scale_x, anim_scale_y]);
}

function GetItemsDrawnOffsets(_index = 0, _max = 1) {
	return [0, offset_draw_item];
}

draw_circle_radius = 32;

function DrawItemsIn() {
	var _nb_items_to_draw = (state == TRANSFORMER_STATE.RESULT) ? 1 : max_items;
	
	var _draw_xs = GetPositionsOnLineCenter(draw_circle_radius, 50, _nb_items_to_draw, x, SPRITE_ORIGIN.TOP_LEFT); 
	// Will need a method to handle red color
	var _draw_color = state == TRANSFORMER_STATE.CAN_TRANSFORM ? make_color_rgb(16, 235, 147) : c_white;
	
	if (array_length(items_in_ids) > 0)	{
		for (var _i = 0; _i < _nb_items_to_draw; _i++)
		{
			var _offset = GetItemsDrawnOffsets(_i, _nb_items_to_draw);
			var _draw_xy = WorldToGUI(_draw_xs[_i] + _offset[0], y - popup_draw_height + _offset[1]);
			
			draw_sprite_ext(phgen_circle(draw_circle_radius, _draw_color, 2, c_black), 0, _draw_xy[0], _draw_xy[1] - draw_circle_radius,
				1, 1, 0, c_white, 1);
			
			if (array_length(items_in_ids) > _i) {
				draw_sprite_ext(
					GetItemSprite(items_in_ids[_i]), 
					0, 
					 _draw_xy[0] + draw_circle_radius,  _draw_xy[1],
					0.4 * (1 + item_in_scale_x), 0.4 * (1 + item_in_scale_y), 0, c_white, 1);
			}
		}
	}
}

function GetProgressRatio() {
	return 1;
}

function Progress() {
	return true;		
}

function OnTransformationFinished() {
}

function TransformationFinished() {
	is_interact_locked = true;
	OnTransformationFinished();
	qte_holder.Reset();

	audio_play_sound(Tool_Table_01, 10, false);
	if (current_state) 
		current_state.transition_to(new TransformerResultState(id));
		
	alarm[0] = seconds(0.35);
}

function SetFeedbacksInitialState() {
}

function SetPlayerInteractingFeedbacks() {
}

function HideFeedbacks() {
}

// Non-overridable
function CreateQteHolder() {
	if (instance_exists(qte_holder)) { 
		qte_holder.Reset();
		return;
	}
	
	if (qte_holder_obj != noone && qte_holder_obj != undefined) {
		qte_holder = instance_create_layer(x, y + qte_holder_spawn_y_offset, "GUI", qte_holder_obj);
	}
}

function InitializeQteHolder(_force = false) {
	if (opt_show_qte_when_ready_only && !_force)
		return;
		
	if (instance_exists(qte_holder))
		qte_holder.Init(items_in_ids, x, y);
}

anim_item = noone;
function StartAnimItems() {
	StopAnimItems();
		
	var _offset_ya = new polarca_animation("offset_draw_item", max_offset_draw_item , ac_bump_translate_height_pp ,0, offset_draw_speed);
	anim_item = polarca_animation_start([_offset_ya]);
	anim_item.is_looping = true;	
	anim_item.is_ping_pong = true;
}

function StopAnimItems() {
	if (anim_item != noone)
		instance_destroy(anim_item);
	
	offset_draw_item = 0;
}

function OnQteValidatedFeedbacks(_progress) {

}

function ActivateQteHolder() {
	if (opt_show_qte_when_ready_only)
		InitializeQteHolder(true);
		
	if (instance_exists(qte_holder)) {
		qte_holder.on_qte_completed = Broadcast(function() { TransformationFinished() } );
		qte_holder.on_qte_validated = Broadcast(function(_progress) { OnQteValidatedFeedbacks(_progress) } );
		qte_holder.Start();
	}
}

// Start code execution
current_state = new TransformerEmptyState(id, {});
current_state.enter_state();