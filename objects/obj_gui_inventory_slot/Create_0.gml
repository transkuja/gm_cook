/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

on_clicked = function() {
	if (global.player_control < 0) return;
	audio_play_sound(Minimalist1, 10, false);

	if (is_selected) {
		// Checks if another menu is opened
		if (global.inventory_mode)
		{
			if (global.ui_on_inventory_item_used != noone)
				global.ui_on_inventory_item_used.dispatch(item_data);
		}
		else
		{
			if (instance_exists(inst_player)) {
				inst_player.GetItemFromInventoryToHands();
			}
		}
	}
	
	if (instance_exists(inst_inventory)) {
		inst_inventory.SetSelectedSlot(slot_index);
	}
}