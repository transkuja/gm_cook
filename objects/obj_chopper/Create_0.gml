event_inherited();

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
}

