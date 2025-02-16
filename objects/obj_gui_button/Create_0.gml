/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function DrawSelectedFeedback() {
}

function EnableSelectedFeedback() {
	image_index = 1;
}

function RemoveSelectedFeedback() {
	if (!hovering)
		image_index = 0;
}