/// @description Insert description here
// You can write your code in this editor

arr_requirements = string_split(requirements, "|");
inst_dialogue_box = noone;
save_key = save_data_get_key("_played");

function AreRequirementsValid() {
	if (dialogue_id == "" || !is_string(dialogue_id)) return false;
	
	// Check from requirements database
	if (!AreDialogueRequirementsMet(dialogue_id))
		return false;
	
	// No other requirement, can start dialogue
	if (array_length(arr_requirements) == 0) return true;
	
	for (var i = 0; i < array_length(arr_requirements); i++)
	{
		if (save_data_get(arr_requirements[i]) == undefined)
			return false;
	}
	
	// No check failed, can start dialogue
	return true;
}

function StartDialogue() {
	// Create dialogue box
	inst_dialogue_box = instance_create_layer(0, 0, "GUI", obj_gui_dialogue_box);
	
	// Init with current id
	if (instance_exists(inst_dialogue_box)) {
		inst_dialogue_box.Initialize(dialogue_id);
		
		var _broadcast = Broadcast(function() {
			save_data_set(save_key, true);
		} );
	
		inst_dialogue_box.on_dialogue_close = _broadcast;
	}
}