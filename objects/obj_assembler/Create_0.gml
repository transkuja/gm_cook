event_inherited();

initial_item_mash_count = 0;
current_mash_count = 0;
active_sequence = noone;

expected_result = "none";

function IsTransformable() {
	if (IsFilled())	{
		if (!instance_exists(inst_databaseLoader)) {
			_log("ERROR! Obj database loader does not exist !");
			return false;
		}
		
		for (var _index = 0; _index < array_length(inst_databaseLoader.assemble_combos); _index++) {
			var tmp = new AssembleCombo(inst_databaseLoader.assemble_combos[_index].ids, inst_databaseLoader.assemble_combos[_index].result_id );
			var result = tmp.IsCombo(items_in_ids);
			
			if (result != "none") {
				expected_result = result;
				break;
			}
		}
		
		return true;
	}	
	
	return false;
}

function OnTransformationFinished() {
	items_in_ids = array_create(1, expected_result);
	
	initial_item_mash_count = 0;
}

function StartTransforming() {
	if (current_mash_count == 0) {
		initial_item_mash_count = 1;
		current_mash_count = 1;
	}
	
}

function GetProgressRatio() {
	if (initial_item_mash_count <= 0)
		return 0;
		
	return 1 - (current_mash_count / initial_item_mash_count);
}

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