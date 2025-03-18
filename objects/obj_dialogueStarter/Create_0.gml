/// @description Insert description here
// You can write your code in this editor

arr_requirements = string_split(requirements, "|", true);
arr_quests_ids = string_split(quests_ids, "|", true);
inst_dialogue_box = noone;
save_key = dialogue_id + "_played";

function AreRequirementsValid() {
	if (dialogue_id == "" || !is_string(dialogue_id)) return false;
	
	// Check from requirements database
	if (!AreDialogueRequirementsMet(dialogue_id))
		return false;
	
	// No other requirement, can start dialogue
	//if (!is_string(requirements) || requirements == "") return true;
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
	var _db_inst = TryGetGlobalInstance(GLOBAL_INSTANCES.DATABASE_MANAGER);
	if (!instance_exists(_db_inst)) {
		_log("ERROR: Database loader instance not in Room: ", room_name);
		return;
	}
	
	for (var i = 0; i < array_length(arr_quests_ids); i++) {
		var quest = _db_inst.quests[? arr_quests_ids[i]];
		if (struct_exists(quest, "initial_dialogue")) {
			if (dialogue_id == quest.initial_dialogue) {
				PlayQuestStartingDialogue(arr_quests_ids[i]);
				return;
			}
		}
	}
	
	// Create dialogue box
	inst_dialogue_box = instance_create_layer(0, 0, "GUI", obj_gui_dialogue_box);
	
	// Init with current id
	if (instance_exists(inst_dialogue_box)) {
		inst_dialogue_box.Initialize(dialogue_id);
		
		var _broadcast = Broadcast(function() {
			save_data_set(save_key, true);
			inst_dialogue_box = noone;
		} );
	
		inst_dialogue_box.on_dialogue_close = _broadcast;
	}
}