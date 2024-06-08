event_inherited();

initial_item_mash_count = 0;
current_mash_count = 0;

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
	
	var _s = layer_sequence_create("GUI",x,y, seq_press_button);
	layer_sequence_pause(_s);
	
	layer_sequence_play(_s);
}

function Progress() {
	current_mash_count--;
	return initial_item_mash_count > 0 && current_mash_count <= 0;		
}