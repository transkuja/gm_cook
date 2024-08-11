/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

arr_quests_ids = string_split(quests_ids, "|");
current_quest_id = "";
cur_quest_data = {};
cur_quest_status = "";

function GetCurrentDialogue() {
	current_quest_id = "";
	
	// Has an unresolved quest, bypass dialogue with based on quest dialogues
	current_quest = GetUnresolvedQuest();
	if (current_quest[0] != "") {
		current_quest_id = current_quest[0];
		
		if (!instance_exists(inst_databaseLoader)) { return false; }
		cur_quest_data = inst_databaseLoader.quests[? current_quest_id];
		
		if (current_quest[1] == "pending") {
			if (struct_exists(cur_quest_data, "pending_dialogue")) {
				cur_quest_status = "pending";
				return cur_quest_data.pending_dialogue;
			}
		}
		else if (current_quest[1] == "not_started") {
			if (IsQuestRequirementsMet(current_quest_id)) {
				if (struct_exists(cur_quest_data, "initial_dialogue")) {
					cur_quest_status = "not_started";
					return cur_quest_data.initial_dialogue;
				}
			}
		}
		
	}
	
	if (array_length(arr_dialogues_ids) > current_dialogue_state)
		return arr_dialogues_ids[current_dialogue_state];
		
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


function CanAdvanceDialogue() {
	return current_quest_id == "";
}

function SetQuestToPending() {
	SaveQuestStatus(current_quest_id, "pending");
}

function SetQuestToFinished() {
	SaveQuestStatus(current_quest_id, "done");
}

function InitDialogueBox() {
	var current_dialogue_id = GetCurrentDialogue();
	if (instance_exists(inst_dialogue_box)) {
		if (cur_quest_status == "not_started") {
			var _accept_dialogue = "";
			var _refuse_dialogue = "";
			if (struct_exists(cur_quest_data, "accept_dialogue")) _accept_dialogue = cur_quest_data.accept_dialogue;
			if (struct_exists(cur_quest_data, "refuse_dialogue")) _accept_dialogue = cur_quest_data.refuse_dialogue;
			
			inst_dialogue_box.Initialize(current_dialogue_id, _accept_dialogue, _refuse_dialogue, 
											Broadcast( function() { SetQuestToPending(); }) );
		}
		else if (cur_quest_status == "pending") {
			var _final_dialogue = "";
			if (struct_exists(cur_quest_data, "final_dialogue")) _final_dialogue = cur_quest_data.final_dialogue;
			inst_dialogue_box.Initialize(current_dialogue_id, _final_dialogue, "", Broadcast(function() { SetQuestToFinished(); }));
		}
		else {
			inst_dialogue_box.Initialize(current_dialogue_id);
		}
	}
}

// for each quest, check in save if marked as resolved
// if quest not resolved, check requirements
// if requirements met, bypass dialogue with quest dialogue (initial or pending)
// save quest status (not_started, pending, done)

// On interact, check if can validate quest (item in inventory)
// show choice if can validate quest
// on quest validation, remove items from inventory + play final dialogue
// add the ability to force dialogue on choice positive/negative