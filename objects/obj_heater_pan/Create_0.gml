event_inherited();

function IsItemValid(_itemId) {
	return GetItemType(_itemId) == ITEM_TYPE.HEATABLE_PAN;
}

function IsTransformable() {
	if (IsFilled())
		return GetHeatablePanResult(items_in_ids[0]) != "none";
		
	return false;
}

function OnTransformationFinished() {
	if (array_length(items_in_ids) > 0)
		items_in_ids[0] = GetHeatablePanResult(items_in_ids[0]);
	
	initial_item_mash_count = 0;
}

