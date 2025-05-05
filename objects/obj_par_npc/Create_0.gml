/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

arr_dialogues_ids = string_split(dialogue_ids, "|");
is_player_interacting = false;
current_dialogue_state = 0; // TODO: save this
inst_dialogue_box = noone;
save_key = save_data_get_key("_dialogue");

function GetCurrentDialogue() {
	if (array_length(arr_dialogues_ids) > current_dialogue_state) {
		
		var startIndex = current_dialogue_state;
		var curIndex = startIndex;
		while (!AreDialogueRequirementsMet(arr_dialogues_ids[curIndex])) {
			curIndex = (curIndex + 1) % array_length(arr_dialogues_ids);
			
			if (curIndex == startIndex)
				break;
		}
		
		current_dialogue_state = curIndex;
		return arr_dialogues_ids[current_dialogue_state];
	}
	return "";
}

function InitDialogueBox() {
	if (instance_exists(inst_dialogue_box))
		inst_dialogue_box.Initialize(GetCurrentDialogue());
}

function Interact(_interactInstigator) {
	if (is_player_interacting || array_length(arr_dialogues_ids) <= current_dialogue_state) 
		return;
		
	shader_enabled = false;
	is_player_interacting = true;
	
	// Create dialogue box
	inst_dialogue_box = instance_create_layer(0, 0, "GUI", obj_gui_dialogue_box);
	
	// Init with current id
	if (instance_exists(inst_dialogue_box)) {
		InitDialogueBox();
		
		if (inst_dialogue_box.on_dialogue_close == noone) {
			var _broadcast = Broadcast(function() {
				AdvanceDialogue();			
				EndInteraction();
			} );
	
			inst_dialogue_box.on_dialogue_close = _broadcast;
		}
		else {
			var _subscriber = Subscriber(function() {
				AdvanceDialogue();			
				EndInteraction();
			} ).watch(inst_dialogue_box.on_dialogue_close);
		}
	}
	
}

function EndInteraction() {
	shader_enabled = true;
	is_player_interacting = false;
	inst_dialogue_box = noone;
}

function CanAdvanceDialogue() {
	return true;
}

function AdvanceDialogue() {
	if (!CanAdvanceDialogue()) 
		return;
	
	if (current_dialogue_state + 1 < array_length(arr_dialogues_ids))
	{
		current_dialogue_state++;
		save_data_set(save_key, current_dialogue_state);
	}
}