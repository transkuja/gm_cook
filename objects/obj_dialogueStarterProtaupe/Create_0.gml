/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function SetDialogueId() {
	if (instance_exists(inst_databaseLoader))	
	{
		// Act I: if vieux quichon entered AND 1st dialogue played, swapped to 2nd dialogue
		var _intro_dialogue_played = save_data_get(save_key) != undefined;
		
		if (!_intro_dialogue_played) 
			return;
		
		// If Act II quest finished (1st quest), can access second one
		var quest_1_status = save_data_get("q_protaupe_salad");
		if (quest_1_status != undefined && quest_1_status == "done")
		{
			if ((string_pos("galette", inst_databaseLoader.billy_memory) != 0 || string_pos("crêpe", inst_databaseLoader.billy_memory) != 0 || string_pos("crepe", inst_databaseLoader.billy_memory) != 0) 
					&& string_pos("sans lait", inst_databaseLoader.billy_memory) != 0)
			{
				dialogue_id = "d_protaupe_galette";
				save_key = dialogue_id + "_played";
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
				return;
			}
			else 
			{
				// TODO: dialogues conneries avec "Topich", "Thomas", "Thomas Pichon", "Dindon"
			}
		}
	}
	
}