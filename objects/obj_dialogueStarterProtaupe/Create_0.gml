/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function CheckMemory(_quest_id) {
	if (_quest_id == "q_protaupe_salad") {
		return (string_pos("galette", inst_databaseLoader.billy_memory) != 0 || string_pos("crêpe", inst_databaseLoader.billy_memory) != 0 || string_pos("crepe", inst_databaseLoader.billy_memory) != 0) 
					&& string_pos("sans lait", inst_databaseLoader.billy_memory) != 0;
	}
		
	if (_quest_id == "q_protaupe_galette") 
	{
		return string_pos("grosse", inst_databaseLoader.billy_memory) != 0
			&& string_pos("ratatouille", inst_databaseLoader.billy_memory) != 0
			&& string_pos("famille", inst_databaseLoader.billy_memory) != 0;
	}
}

function QuestCheckFinished(_quest_id) {
	var quest_status = save_data_get(_quest_id);

	return (quest_status != undefined && quest_status == "done");
}

function CheckMemoryForName() {
	var arr_checks = ["topich", "pichon", "thomas"];
	for (var i = 0; i < array_length(arr_checks); i++)
	{
		if (string_pos(arr_checks[i], inst_databaseLoader.billy_memory) != 0)
		{
			dialogue_id = "d_input_" + arr_checks[i];
			save_key = dialogue_id + "_played";
			return;
		}	
	}
	
	if (string_pos("dinde", inst_databaseLoader.billy_memory) != 0 || string_pos("dindon", inst_databaseLoader.billy_memory) != 0)
	{
		dialogue_id = "d_input_dinde";
		save_key = dialogue_id + "_played";
		return;
	}
	
	if (string_pos("bite", inst_databaseLoader.billy_memory) != 0
		|| string_pos("penis", inst_databaseLoader.billy_memory) != 0 || string_pos("pénis", inst_databaseLoader.billy_memory) != 0
		|| string_pos("sex", inst_databaseLoader.billy_memory) != 0 || string_pos("zizi", inst_databaseLoader.billy_memory) != 0
		|| string_pos("teub", inst_databaseLoader.billy_memory) != 0 || string_pos("chibr", inst_databaseLoader.billy_memory) != 0)
	{
		dialogue_id = "d_input_bite";
		save_key = dialogue_id + "_played";
		return;
	}
}

function SetDialogueId() {
	if (instance_exists(inst_databaseLoader))	
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
				if (string_pos("vieux quichon", inst_databaseLoader.billy_memory) != 0)
				{
					dialogue_id = "d_protaupe_correct_name";
					save_key = dialogue_id + "_played";
					save_data_set("can_start_q_protaupe_salad", true);
					return;
				}
				else 
				{
					 CheckMemoryForName();
					// TODO: dialogues conneries avec "Topich", "Thomas", "Thomas Pichon", "Dindon"
				}
			}
		}
	}
	
}