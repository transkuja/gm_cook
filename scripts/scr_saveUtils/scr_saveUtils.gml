function save_data_get(_key) { 
	if (!instance_exists(inst_saveManager)) {
		_log("ERROR: SAVE MANAGER MISSING !!!!");
		return;
	}
	
	if (ds_map_exists(inst_saveManager.current_save_data, _key))
		return ds_map_find_value(inst_saveManager.current_save_data,_key);
}

function save_data_add(_key, _delta) {
	if (!instance_exists(inst_saveManager)) {
		_log("ERROR: SAVE MANAGER MISSING !!!!");
		return;
	}
	
	if (ds_map_exists(inst_saveManager.current_save_data, _key))
	{
		var cur_value = ds_map_find_value(inst_saveManager.current_save_data, _key);
		ds_map_replace(inst_saveManager.current_save_data, _key, cur_value + _delta);
	}
}

function save_data_set(_key, _value) {
	if (!instance_exists(inst_saveManager)) {
		_log("ERROR: SAVE MANAGER MISSING !!!!");
		return;
	}
	
	if (ds_map_exists(inst_saveManager.current_save_data, _key))
		ds_map_replace(inst_saveManager.current_save_data, _key, _value);
}

function save_data_get_key(_suffixe) { 
	return room_get_name(room) + object_get_name(object_index) + string(x) + string(y) + _suffixe; 
}