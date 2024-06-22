event_inherited()

state = TRANSFORMER_STATE.EMPTY;
items_in_ids = array_create(0, "none");
items_pending = array_create(0, "none");
qte_holder = noone;

// On A pressed
function PutItemIn(_itemId) {
	if (IsFilled()) {
		PlayFilledFeedbacks()
		return;
	}
	
	if (_itemId != "none")
		_push(items_pending, _itemId);
	
}

function ConfirmPendingItem() {
	if (array_length(items_pending) == 0) return;
	
	var _itemId = items_pending[0];		
	array_remove(items_pending, _itemId);
	_push(items_in_ids, _itemId);
	
	var anim_scale_x = new polarca_animation("image_xscale", 0.8, ac_bump_x, 0, 0.08);
	var anim_scale_y = new polarca_animation("image_yscale", 1.2, ac_bump_x, 0, 0.08);
	polarca_animation_start([anim_scale_x, anim_scale_y]);
	
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

// After operation, A
function TakeFrom(_interactInstigator) {
	if (instance_exists(_interactInstigator) && _interactInstigator.object_index == obj_player) {
		if (_interactInstigator.HasItemInHands())
			return false;
	}
		
	var _item_removed = items_in_ids[array_length(items_in_ids) - 1];
	array_remove(items_in_ids, _item_removed);
		
	_interactInstigator.CreateItemInHands(_item_removed);
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

draw_circle_radius = 32;

function DrawItemsIn() {
	var _nb_items_to_draw = (state == TRANSFORMER_STATE.RESULT) ? 1 : max_items;
	
	var _draw_xs = GetPositionsOnLineCenter(draw_circle_radius, 50, _nb_items_to_draw, x, SPRITE_ORIGIN.TOP_LEFT); 
	
	if (array_length(items_in_ids) > 0)	{
		for (var _i = 0; _i < _nb_items_to_draw; _i++)
		{
			var _draw_xy = WorldToGUI(_draw_xs[_i], y - popup_draw_height);
			
			draw_sprite(phgen_circle(draw_circle_radius, c_white, 2, c_black), 0, _draw_xy[0], _draw_xy[1] - draw_circle_radius);
			
			if (array_length(items_in_ids) > _i) {
				draw_sprite_ext(
					GetItemSprite(items_in_ids[_i]), 
					0, 
					 _draw_xy[0] + draw_circle_radius,  _draw_xy[1],
					0.4, 0.4, 0, c_white, 1);
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
	OnTransformationFinished();
	if (current_state) 
		current_state.transition_to(new TransformerResultState(id));
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
		qte_holder = instance_create_layer(x, y, "GUI", qte_holder_obj);
	}
}

function InitializeQteHolder() {
	if (instance_exists(qte_holder))
		qte_holder.Init(items_in_ids);
}

function ActivateQteHolder() {
	if (instance_exists(qte_holder)) {
		qte_holder.on_qte_completed = Broadcast(function() { TransformationFinished() } );
		qte_holder.Start();
	}
}

// Start code execution
current_state = new TransformerEmptyState(id, {});
current_state.enter_state();