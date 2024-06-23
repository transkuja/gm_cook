// Inherit the parent event
event_inherited();

if (is_checking_input) {
	current_qte_time += d(1);
	if (current_qte_time >= bar_duration) {
		is_checking_input = false;
		alarm[1] = seconds(0.5);
	}
}