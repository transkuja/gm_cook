/// @description On load finished

if (instance_exists(inst_inventory))
{
	inst_inventory.PerformLoad();
	bind_to_data_collection(inst_inventory, function(){inst_inventory.PerformSave();});
}

if (on_load_finished != noone)
	on_load_finished.dispatch();
