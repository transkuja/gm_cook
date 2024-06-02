event_inherited()

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

function ConfirmPendingItem(_itemId) {
	if (!_contains(items_pending, _itemId)) { return; }
		
	array_remove(items_pending, _itemId);
	_push(items_in_ids, _itemId);
	
	var anim_scale_x = new polarca_animation("image_xscale", 0.8, ac_bump_x, 0, 0.08);
	var anim_scale_y = new polarca_animation("image_yscale", 1.2, ac_bump_x, 0, 0.08);
	polarca_animation_start([anim_scale_x, anim_scale_y]);
		
	
	_log("Transformer content:");
	for (var i = 0; i < array_length(items_in_ids); i++)
		_log(items_in_ids[i]);
}

// After operation, A
function TakeFrom() {
	if (array_length(items_in_ids) == 0) { return; }
	
	var _item_removed = items_in_ids[array_length(items_in_ids) - 1];
	array_remove(items_in_ids, _item_removed);
	return _item_removed;
}

function IsTransformable() {
	return true;
}

// On A pressed
function Interact(_interactInstigator) {
	if (instance_exists(_interactInstigator) && _interactInstigator.object_index == obj_player) {
		if (_interactInstigator.HasItemInHands())
			return;
	}
	
	if (array_length(items_in_ids) == max_items && IsTransformable()) {
		StartTransforming();
	}
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

function OnTransformationFinished() {
}