/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

arr_quests_ids = string_split(quests_ids, "|");
current_quest_id = "";

function GetCurrentDialogue() {
	// Has an unresolved quest, bypass dialogue with based on quest dialogues
	current_quest = GetUnresolvedQuest();
	if (current_quest[0] != "") {
		current_quest_id = current_quest[0];
		
		if (instance_exists(inst_databaseLoader)) { return false; }
		var q_data = inst_databaseLoader.quests[? _quest_id];
		
		if (current_quest[1] == "not_started") {
			if (IsQuestRequirementsMet(current_quest_id)) {
				if (struct_exists(q_data, "initial_dialogue"))
					return q_data.initial_dialogue;
			}
		}
		else (current_quest[1] == "pending") {
			if (struct_exists(q_data, "pending_dialogue"))
				return q_data.pending_dialogue;
		}
	}
	
	if (array_length(dialogue_ids) > current_dialogue_state)
		return dialogue_ids[current_dialogue_state];
		
	return "";
}

function GetUnresolvedQuest() {
	for (var i = 0; i < array_length(arr_quests_ids); i++) {
		q_status = GetQuestStatus(arr_quests_ids[i]);
	
		if (q_status != "done")
			return [arr_quests_ids[i], q_status];
	}
	
	return ["",""];
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