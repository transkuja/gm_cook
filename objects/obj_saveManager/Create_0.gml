current_save_data = ds_map_create();
file_name="SaveData.sav"

function perform_save() {
	ds_map_secure_save(current_save_data, file_name);
}

function perform_load() {
	if (!file_exists(file_name)) return;
	
	ds_map_destroy(current_save_data);
	current_save_data = ds_map_secure_load(file_name);
}