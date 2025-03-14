

function GetGlobalInstanceVarName(_manager_enum) {
	switch (_manager_enum)
	{
		case MANAGERS.DATABASE_MANAGER:
			return "database_manager";
			
		case MANAGERS.SAVE_MANAGER:
			return "save_manager";
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