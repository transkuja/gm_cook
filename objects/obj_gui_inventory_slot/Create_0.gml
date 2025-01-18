/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

on_clicked = function() {
	if (global.player_control < 0) return;
	audio_play_sound(Minimalist1, 10, false);

	_remove_item = false;
	
	if (is_selected) {
		// Checks if another menu is opened
		if (global.inventory_mode)
		{
			if (global.ui_on_inventory_item_used != noone)
			{
				if (global.ui_on_inventory_item_used(item_data))
					_remove_item = true;
			}
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
		if (_remove_item)
			inst_inventory.UseSelectedItem();
	}
}