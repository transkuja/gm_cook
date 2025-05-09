/// @description Destroy

global.inventory_mode = false;

if (global.ui_on_fridge_closed != noone)
	global.ui_on_fridge_closed.dispatch();
	
if (global.on_should_show_exit_cross != noone)
	global.on_should_show_exit_cross();
	
for (var _index = slot_count - 1; _index >= 0; _index--)
{
	if (instance_exists(slots_instances[_index]))
		instance_destroy(slots_instances[_index]);
}

global.ui_fridge_first_row = [];
global.ui_fridge_last_row = [];
	
instance_destroy();