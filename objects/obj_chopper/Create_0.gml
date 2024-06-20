event_inherited();

initial_item_mash_count = 0;
current_mash_count = 0;
active_sequence = noone;

function IsItemValid(_itemId) {
	return GetItemType(_itemId) == ITEM_TYPE.RAW_COMPO;
}

function IsTransformable() {
	if (IsFilled())
		return GetChoppedResult(items_in_ids[0]) != "none";
		
	return false;
}

function OnTransformationFinished() {
	if (array_length(items_in_ids) > 0)
		items_in_ids[0] = GetChoppedResult(items_in_ids[0]);
	
	initial_item_mash_count = 0;
}

function StartTransforming() {
	if (current_mash_count == 0) {
		var _mash_count = GetChopMashCount(items_in_ids[0]);
		if (_mash_count == -1) { return; }
		
		initial_item_mash_count = _mash_count;
		current_mash_count = _mash_count;
	}
	
}

function GetProgressRatio() {
	if (initial_item_mash_count <= 0)
		return 0;
		
	return 1 - (current_mash_count / initial_item_mash_count);
}

// TODO: Move to OnInputValidated
function Progress() {
	current_mash_count--;
	return initial_item_mash_count > 0 && current_mash_count <= 0;		
}

function SetFeedbacksInitialState() {
	if (!sequence_exists(active_sequence)) {
		var _seq_x = x - (sprite_width * 0.5) - 50;
		var _seq_y = y - (sprite_height * 0.5) - 50;
		
		active_sequence = layer_sequence_create("GUI", _seq_x, _seq_y, seq_press_button);
	}
	
	layer_sequence_xscale(active_sequence, 0.35);
	layer_sequence_yscale(active_sequence, 0.35);
	layer_sequence_pause(active_sequence);
}

function SetPlayerInteractingFeedbacks() {
	var _s_id = layer_sequence_get_sequence(active_sequence);
	if (sequence_exists(_s_id))
		layer_sequence_play(active_sequence);
}

function HideFeedbacks() {
	var _s_id = layer_sequence_get_sequence(active_sequence);
	if (sequence_exists(_s_id))
		layer_sequence_destroy(active_sequence);
}