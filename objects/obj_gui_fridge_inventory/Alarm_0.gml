/// @description Destroy

global.inventory_mode = false;

SaveFridgeState();

if (on_menu_close != noone) 
	on_menu_close.dispatch();
	
for (var _index = slot_count - 1; _index >= 0; _index--)
{
	if (instance_exists(slots_instances[_index]))
		instance_destroy(slots_instances[_index]);
}

instance_destroy();