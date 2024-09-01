/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function SetDialogueId() {
	if (instance_exists(inst_databaseLoader))	
	{
		// Act I: if vieux quichon entered AND 1st dialogue played, swapped to 2nd dialogue
		intro_dialogue_played = save_data_get(save_key) != undefined;
		
		if (!intro_dialogue_played) 
			return;
			
		if (string_pos("vieux quichon", inst_databaseLoader.billy_memory) != 0)
		{
			dialogue_id = "d_protaupe_correct_name";
			return;
		}
	}
	
}