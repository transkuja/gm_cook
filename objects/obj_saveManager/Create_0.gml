current_save_data = ds_map_create();
file_name="SaveData.sav"

global.save_manager = self;

on_data_collected = noone;
on_load_finished = noone;

function perform_save() {
	if (current_save_data == noone || current_save_data == undefined) return;
	
	if (on_data_collected != noone)
		on_data_collected.dispatch();
		
	ds_map_secure_save(current_save_data, file_name);
}

function perform_load() {
	if (!file_exists(file_name)) return;
	
	ds_map_destroy(current_save_data);
	current_save_data = ds_map_secure_load(file_name);
}

function clear_save() {
	if (file_exists(file_name))
		file_delete(file_name);
	
	if (current_save_data != noone)
		ds_map_destroy(current_save_data);
		
	current_save_data = noone;
}

function bind_to_data_collection(_entity, _function) {
	if (on_data_collected == noone)	{
		var _broadcast = Broadcast(_function);
		on_data_collected = _broadcast;
	}
	else {
		Subscriber(_function).watch(on_data_collected);
	}
}
