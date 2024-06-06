event_inherited();

initial_item_mash_count = 0;
current_mash_count = 0;

function IsTransformable() {
	if (array_length(items_in_ids) > 0)
		return GetChoppedResult(items_in_ids[0]) != "none";
}

function OnTransformationFinished() {
	if (array_length(items_in_ids) > 0)
		items_in_ids[0] = GetChoppedResult(items_in_ids[0]);
}

function StartTransforming() {
	// TODO: spawn object handling input + sequence for QTE gameplay (R&D)
	if (instance_exists(inst_player)) {
		inst_player.cooking_input_object = instance_create_layer(0,0,"Instances", obj_qte_chop);
		if (instance_exists(inst_player.cooking_input_object)) {
			inst_player.cooking_input_object.on_qte_completed = 
				Broadcast(function() {
					OnTransformationFinished();
				});
		}
	}
	
	var _s = layer_sequence_create("GUI",x,y, seq_press_button);
	layer_sequence_pause(_s);
	
	layer_sequence_play(_s);
}

