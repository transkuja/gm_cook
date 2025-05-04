/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function SetSelected(_value) {
    if (_value == false && is_selected)
        RemoveSelectedFeedback();
    
	is_selected = _value;
    
    if (is_selected)
        EnableSelectedFeedback();
}

function DrawSelectedFeedback() {
}

function EnableSelectedFeedback() {
	image_index = 1;
}

function RemoveSelectedFeedback() {
	if (!hovering)
		image_index = 0;
}