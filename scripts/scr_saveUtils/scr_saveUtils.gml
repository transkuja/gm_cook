function save_data_get(_key) { 
	if (ds_map_exists(save_data, _key))
		return ds_map_find_value(save_data,_key);
}

function save_data_add(_key, _delta) {
	if (ds_map_exists(save_data, _key))
	{
		var cur_value = ds_map_find_value(save_data, _key);
		ds_map_replace(save_data, _key, cur_value + _delta);
	}
}

function save_data_set(_key, _value) {
	if (ds_map_exists(save_data, _key))
		ds_map_replace(save_data, _key, _value);
}

function save_data_get_key(_suffixe) { 
	return room_get_name(room) + object_get_name(object_index) + string(x) + string(y) + _suffixe; 
}