function save_data_get(_key, _default = undefined) { 
	if (!variable_global_exists("save_manager") || !instance_exists(global.save_manager)) {
		_log("ERROR: save_data_get: SAVE MANAGER MISSING !!!! Key: " + _key);
		return undefined;
	}
	
	if (ds_map_exists(global.save_manager.current_save_data, _key))
		return ds_map_find_value(global.save_manager.current_save_data,_key);
		
	return _default;
}

function save_data_add(_key, _delta) {
	if (!variable_global_exists("save_manager") || !instance_exists(global.save_manager)) {
		_log("ERROR: save_data_add: SAVE MANAGER MISSING !!!! Key: " + _key);
		return;
	}
	
	if (ds_map_exists(global.save_manager.current_save_data, _key))
	{
		var cur_value = ds_map_find_value(global.save_manager.current_save_data, _key);
		ds_map_replace(global.save_manager.current_save_data, _key, cur_value + _delta);
	}
	else
	{
		save_data_set(_key, _delta);
	}
}

function save_data_set(_key, _value) {
	if (!variable_global_exists("save_manager") || !instance_exists(global.save_manager)) {
		_log("ERROR: save_data_set: SAVE MANAGER MISSING !!!! Key: " + _key);
		return;
	}
	
	//if (ds_map_exists(global.save_manager.current_save_data, _key))
	ds_map_replace(global.save_manager.current_save_data, _key, _value);
}

function save_data_get_key(_suffixe) { 
	return room_get_name(room) + object_get_name(object_index) + string(x) + string(y) + _suffixe; 
}

function save_get_manager() {
	if (variable_global_exists("save_manager"))
		return global.save_manager;
	
	return undefined;
}