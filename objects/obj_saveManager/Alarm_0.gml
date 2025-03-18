/// @description On load finished

var _inventory = TryGetGlobalInstance(GLOBAL_INSTANCES.INVENTORY);
if (instance_exists(_inventory))
{
	_inventory.PerformLoad();
	bind_to_data_collection(_inventory, function(){_inventory.PerformSave();});
}

if (on_load_finished != noone)
	on_load_finished.dispatch();
