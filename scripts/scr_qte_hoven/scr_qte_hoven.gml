
function QteHovenOnInit(_owner, _items_id) {
	if (array_length(_items_id) == 0)
		return false;
	
	if (!_owner.is_init)
	{
		_owner.bar_duration = seconds(_owner.bar_duration);
		_owner.perfect_window_open_time = seconds(_owner.perfect_window_open_time);
		_owner.perfect_window_close_time = seconds(_owner.perfect_window_close_time);
		_owner.good_window_open_time = seconds(_owner.good_window_open_time);
		_owner.good_window_close_time = seconds(_owner.good_window_close_time);
	
		_owner.current_qte_time = 0;
		_owner.current_position = 0;
	}

	_owner.is_checking_input = false;
	
	_owner.is_init = true;
	return true;
}


function QteHovenOnStart(_owner) {
    _owner.StartMoving();
	_owner.loop_sound_inst = audio_play_sound(_owner.in_progress_sound, 10, true);
}