if (global.player_control == false) return;

if (instance_exists(inst_inventory)) {
	inst_inventory.SetSelectedSlot(slot_index);
}
