/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

is_player_interacting = false;
current_dialogue_state = 0; // TODO: save this
inst_dialogue_box = noone;
save_key = save_data_get_key("_dialogue");

function GetCurrentDialogue() {
	if (array_length(dialogue_ids) > current_dialogue_state)
		return dialogue_ids[current_dialogue_state];
		
	return "";
}

function Interact(_interactInstigator) constructor {
	if (is_player_interacting || array_length(dialogue_ids) <= current_dialogue_state) 
		return;
		
	shader_enabled = false;
	is_player_interacting = true;
	
	// Create dialogue box
	inst_dialogue_box = instance_create_layer(0, 0, "GUI", obj_gui_dialogue_box);
	
	// Init with current id
	if (instance_exists(inst_dialogue_box)) {
		inst_dialogue_box.Initialize(GetCurrentDialogue());
		
		var _broadcast = Broadcast(function() {
			AdvanceDialogue();			
			EndInteraction();
		} );
	
		inst_dialogue_box.on_dialogue_close = _broadcast;
	}
	
}

function EndInteraction() {
	shader_enabled = true;
	is_player_interacting = false;
	inst_dialogue_box = noone;
}

function AdvanceDialogue() {
	if (current_dialogue_state + 1 < array_length(dialogue_ids))
		current_dialogue_state++;
		
	save_data_set(save_key, current_dialogue_state);
}