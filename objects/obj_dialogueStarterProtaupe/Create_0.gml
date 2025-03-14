/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function CheckMemory(_quest_id) {
	var _db_inst = TryGetGlobalInstance(MANAGERS.DATABASE_MANAGER);
	if (!instance_exists(_db_inst)) { return false; }
	
	if (_quest_id == "q_protaupe_salad") {
		return (string_pos("galette", _db_inst.billy_memory) != 0 || string_pos("crêpe", _db_inst.billy_memory) != 0 || string_pos("crepe", _db_inst.billy_memory) != 0) 
					&& string_pos("sans lait", _db_inst.billy_memory) != 0;
	}
		
	if (_quest_id == "q_protaupe_galette") 
	{
		return string_pos("grosse", _db_inst.billy_memory) != 0
			&& string_pos("ratatouille", _db_inst.billy_memory) != 0
			&& string_pos("famille", _db_inst.billy_memory) != 0;
	}
}

function QuestCheckFinished(_quest_id) {
	var quest_status = save_data_get(_quest_id);

	return (quest_status != undefined && quest_status == "done");
}

function CheckMemoryForName() {

}

function SetDialogueId() {
	var _db_inst = TryGetGlobalInstance(MANAGERS.DATABASE_MANAGER);
	if (instance_exists(_db_inst))
	{
		// Act I: if vieux quichon entered AND 1st dialogue played, swapped to 2nd dialogue
		var _intro_dialogue_played = save_data_get(save_key) != undefined;
		
		if (!_intro_dialogue_played) 
			return;
		
		if (QuestCheckFinished("q_protaupe_galette")) {
			if (CheckMemory("q_protaupe_galette"))
			{
				dialogue_id = "d_protaupe_ratatouille";
				save_key = dialogue_id + "_played";
				save_data_set("can_start_q_protaupe_ratatouille", true);
				return;
			}
		}
		else
		{
			// If Act II quest finished (1st quest), can access second one
			if (QuestCheckFinished("q_protaupe_salad"))
			{
				if (CheckMemory("q_protaupe_salad"))
				{
					dialogue_id = "d_protaupe_galette";
					save_key = dialogue_id + "_played";
					save_data_set("can_start_q_protaupe_galette", true);
					return;
				}
				else 
				{
				}
			}
			else 
			{
				if (string_pos("vieux quichon", _db_inst.billy_memory) != 0)
				{
					dialogue_id = "d_protaupe_correct_name";
					save_key = dialogue_id + "_played";
					save_data_set("can_start_q_protaupe_salad", true);
					return;
				}
				else 
				{
				}
			}
		}
	}
	
}