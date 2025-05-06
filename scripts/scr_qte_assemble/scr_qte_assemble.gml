
function QteAssembleOnInit(_owner, _items_id) {
    if (array_length(_items_id) == 0)
		return false;
	
	if (_owner.current_mash_count == 0) {
		//var _mash_count = GetChopMashCount(_items_id[0]);
		//if (_mash_count == -1) { return false; }
		
		_owner.initial_item_mash_count = 5;
		_owner.current_mash_count = 5;
	}
	
	return true;
}

