/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

arr_quests_ids = string_split(quests_ids, "|");

function GetUnresolvedQuest() {
	for (var i = 0; i < array_length(arr_quests_ids); i++) {
		q_status = GetQuestStatus(arr_quests_ids[i]);
	
		if (q_status != "done")
			return arr_quests_ids[i];
	}
	
	return "";
}

function GetPendingQuest() {
	for (var i = 0; i < array_length(arr_quests_ids); i++) {
		q_status = GetQuestStatus(arr_quests_ids[i]);
		
		if (q_status == "pending")
			return arr_quests_ids[i];
	}
	
	return "";
}


// for each quest, check in save if marked as resolved
// if quest not resolved, check requirements
// if requirements met, bypass dialogue with quest dialogue (initial or pending)
// save quest status (not_started, pending, done)

// On interact, check if can validate quest (item in inventory)
// show choice if can validate quest
// on quest validation, remove items from inventory + play final dialogue
// add the ability to force dialogue on choice positive/negative