if (global.player_control == false) return;

if (input_get_pressed(0, "prev_tab")) {
	var _newValue = selected_slot - 1; 
	SetSelectedSlot(_newValue < 0 ? slot_count -1 : _newValue);
}	
else if (input_get_pressed(0, "next_tab")) {
	SetSelectedSlot((selected_slot + 1) % slot_count);
}
