event_inherited();

expected_result = "none";

function IsItemValid(_itemId) {
	return GetItemType(_itemId) != ITEM_TYPE.RECIPE_FINAL;
}

function IsTransformable() {
	if (IsFilled())	{
		if (!instance_exists(inst_databaseLoader)) {
			_log("ERROR! Obj database loader does not exist !");
			return false;
		}
		
		for (var _index = 0; _index < array_length(inst_databaseLoader.assemble_combos); _index++) {
			var tmp = new AssembleCombo(inst_databaseLoader.assemble_combos[_index].ids, inst_databaseLoader.assemble_combos[_index].result_id );
			var result = tmp.IsCombo(items_in_ids);
			
			if (result != "none") {
				expected_result = result;
				break;
			}
		}
		
		if (expected_result == "none")
			return false;
		else
			return true;
	}	
	
	return false;
}

function OnTransformationFinished() {
	items_in_ids = array_create(1, expected_result);
	
	initial_item_mash_count = 0;
}