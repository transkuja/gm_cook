

function GetGlobalInstanceVarName(_manager_enum) {
	switch (_manager_enum)
	{
		case GLOBAL_INSTANCES.DATABASE_MANAGER:
			return "database_manager";
			
		case GLOBAL_INSTANCES.SAVE_MANAGER:
			return "save_manager";
			
		case GLOBAL_INSTANCES.PLAYER:
			return "player_instance";
	}
	
	return "none";
}

function TryGetGlobalInstance(_global_inst_enum){
	var _var_name = GetGlobalInstanceVarName(_global_inst_enum);
	if (_var_name == "none")
		return noone;
		
	if (variable_global_exists(_var_name))
		return variable_global_get(_var_name);
		
	return noone;
}