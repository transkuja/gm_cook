event_inherited()

state = TRANSFORMER_STATE.EMPTY;
items_in_ids = array_create(0, "none");
items_pending = array_create(0, "none");

// On X pressed
function StartTransforming() {
	
}

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

function DrawItemsIn() {
	if (array_length(items_in_ids) > 0)	{
		for (var _i = 0; _i < array_length(items_in_ids); _i++)
		{
			var _draw_xy = WorldToGUI(x + (_i * 100), y - popup_draw_height);
			//var _draw_x = x + (_i * 100);
			//var _draw_y = y - 100;
			draw_sprite(phgen_circle(32, c_white, 2, c_black), 0, _draw_xy[0] - 32, _draw_xy[1] - 32);
			draw_sprite_ext(
				GetItemSprite(items_in_ids[_i]), 
				0, 
				 _draw_xy[0],  _draw_xy[1],
				0.4, 0.4, 0, c_white, 1);
			_log(_draw_xy);
		}
	}
}

progress_bar_width = 100;
progress_bar_height = 25;
progress_bar_outline = 2.5;

function DrawProgress() {
	var _draw_xy = WorldToGUI(x, y - 85);
	draw_sprite(phgen_rectangle(progress_bar_width, progress_bar_height, c_white, 0, c_white, progress_bar_width * 0.5, progress_bar_height * 0.5), 0, _draw_xy[0], _draw_xy[1]);
	
	var pb_content_w = (progress_bar_width - 2*progress_bar_outline) * GetProgressRatio();
	var pb_content_h = progress_bar_height - 2*progress_bar_outline;
	if (pb_content_w > 0 && pb_content_h > 0)
		draw_sprite(phgen_rectangle(pb_content_w, pb_content_h, c_green, 0, c_white, 0, progress_bar_height * 0.5), 0, _draw_xy[0] - progress_bar_width * 0.5 + progress_bar_outline, _draw_xy[1] + progress_bar_outline);
}

function DrawBackground() {
	//var _draw_xy = WorldToGUI(x, y - 85);
	//var _w = progress_bar_width + 100;
	//var _h = progress_bar_height + 20;
	//draw_sprite(phgen_rectangle(_w, _h, c_gray, 0, c_gray, _w * 0.5, _h * 0.5), 0, _draw_xy[0], _draw_xy[1]);
}

function GetProgressRatio() {
	return 1;
}

function Progress() {
	return true;		
}

function OnTransformationFinished() {
}

function SetFeedbacksInitialState() {
}

function SetPlayerInteractingFeedbacks() {
}

function HideFeedbacks() {
}

current_state = new TransformerEmptyState(id, {});
current_state.enter_state();