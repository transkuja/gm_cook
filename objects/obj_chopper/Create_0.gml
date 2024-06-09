event_inherited();

initial_item_mash_count = 0;
current_mash_count = 0;
active_sequence = noone;

function IsTransformable() {
	if (IsFilled())
		return GetChoppedResult(items_in_ids[0]) != "none";
		
	return false;
}

function OnTransformationFinished() {
	if (array_length(items_in_ids) > 0)
		items_in_ids[0] = GetChoppedResult(items_in_ids[0]);
}

function StartTransforming() {
	if (current_mash_count == 0) {
		var _mash_count = GetChopMashCount(items_in_ids[0]);
		if (_mash_count == -1) { return; }
		
		initial_item_mash_count = _mash_count;
		current_mash_count = _mash_count;
	}
	
}

function Progress() {
	current_mash_count--;
	return initial_item_mash_count > 0 && current_mash_count <= 0;		
}

function SetFeedbacksInitialState() {
	if (!sequence_exists(active_sequence))
		active_sequence = layer_sequence_create("GUI",x,y, seq_press_button);
		
	layer_sequence_pause(active_sequence);
}

function SetPlayerInteractingFeedbacks() {
	if (sequence_exists(active_sequence))
		layer_sequence_play(active_sequence);
}

function HideFeedbacks() {
	if (sequence_exists(active_sequence))
		layer_sequence_destroy(active_sequence);
}