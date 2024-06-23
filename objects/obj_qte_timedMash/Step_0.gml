// Inherit the parent event
event_inherited();

if (is_checking_input) {
	current_qte_time += d(1);
	
	current_qte_time = clamp(current_qte_time, 0, bar_duration);
	_log(current_qte_time);
	current_position = Remap(0, bar_duration, 0, progress_bar_width, current_qte_time);
	
	if (current_qte_time >= bar_duration) {
		is_checking_input = false;
		alarm[1] = seconds(0.5);
	}
}