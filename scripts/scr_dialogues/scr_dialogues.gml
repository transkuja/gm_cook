
function AreDialogueRequirementsMet(_dialogue_id) {
	if (!instance_exists(inst_databaseLoader)) {
		_log("ERROR: Database loader instance not in Room: ", room_name);
		return false;
	}
	
	requirementsData = inst_databaseLoader.dialogues_requirements[? _dialogue_id];
	if (requirementsData == undefined)
		return true;
		
	if (!struct_exists(requirementsData, "requirements"))
		return true;
	
	requirementsMetCount = 0;
	for (var i = 0; i < array_length(requirementsData.requirements); i++)
	{
		save_data = save_data_get(requirementsData.requirements[i].save_key);
		inverse = requirementsData.requirements[i].inverse;
		check_value = requirementsData.requirements[i].value;
		
		// By default, check key present in save
		// Maybe just reverse condition ??
		if (!inverse) {
			// If key not present in save, then requirement not met
			if (save_data == undefined) continue;
			
			// Checking value
			if (check_value != "") {
				try {
					check_value=real(check_value);  
				}
				catch(e){ 
					//if it failed, it's still a string 
				}
				
				if( is_string(check_value) ){ 
					if (check_value == _save_data) { requirementsMetCount++; continue; }
				}else{
					if (save_data >= check_value) { requirementsMetCount++; continue; } //process as a number
				}
			}
			else
				requirementsMetCount++;
		}
		// If inverse option enabled
		else
		{
			// Check if key is NOT PRESENT
			if (save_data == undefined)
			{
				requirementsMetCount++;
				continue;
			}
			
			// If key present, check if specific value 
			if (check_value != "") {
				try {
					check_value=real(check_value);  
				}
				catch(e){ 
					//if it failed, it's still a string 
				}
				
				if( is_string(check_value) ){
					if (check_value != _save_data) { requirementsMetCount++; continue; }
				}else{
					if (save_data < check_value) { requirementsMetCount++; continue; }
				}
			}
			else {
				// If no specific value, then condition failed
				return false;
			}
		}
	}
	
	if (requirementsData.or_condition)
		return requirementsMetCount >= 1;
		
	return requirementsMetCount == array_length(requirementsData.requirements);
}