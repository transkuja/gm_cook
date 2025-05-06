#region OnInit
function QteOnInit(_owner, _items_id) {
    return true;
}

function QteChopOnInit(_owner, _items_id) {
    if (array_length(_items_id) == 0)
		return false;
	
	if (_owner.current_mash_count == 0) {
		var _mash_count = GetChopMashCount(_items_id[0]);
		if (_mash_count == -1) { 
			_log("WARNING: Can't find appropriate mash count, fallback to 1");
			_mash_count = 1; 
		}
		
		_owner.initial_item_mash_count = _mash_count;
		_owner.current_mash_count = _mash_count;
	}
	
	_owner.first_chop_time = -1;
	return true;
}

function QteMixOnInit(_owner, _items_id) {
    
}

function QteStirOnInit(_owner, _items_id) {
    
}

function QteTimeMashOnInit(_owner,_items_id) {
    
}

#endregion

#region OnStart
function QteOnStart(_owner) {
}


function QteMixOnStart(_owner) {
	_owner.StartMoving();
}
#endregion
