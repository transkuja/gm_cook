/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

is_player_interacting = false;
current_dialogue_state = 0; // TODO: save this

function Interact(_interactInstigator) constructor {
	if (is_player_interacting) 
		return;
		
	shader_enabled = false;
	is_player_interacting = true;
}

function EndInteraction() {
	shader_enabled = true;
	is_player_interacting = false;
}

function AdvanceDialogue() {
	if (current_dialogue_state < array_length(dialogue_ids))
		current_dialogue_state++;
}