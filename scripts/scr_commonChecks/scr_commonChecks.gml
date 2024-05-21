
function IsPlayerInstance(_instanceToCheck) {
	if (instance_exists(_instanceToCheck) && _instanceToCheck.object_index == obj_player)
		return true;
		
	return false;
}