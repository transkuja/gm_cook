if (gamepad_button_check_pressed(0, gp_shoulderl)) {
	var _newValue = selected_slot - 1; 
	SetSelectedSlot(_newValue < 0 ? slot_count -1 : _newValue);
}	
else if (gamepad_button_check_pressed(0, gp_shoulderr)) {
	SetSelectedSlot((selected_slot + 1) % slot_count);
}
