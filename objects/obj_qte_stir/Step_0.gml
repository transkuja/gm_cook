// Inherit the parent event
event_inherited();

if (is_checking_input) {
	if (is_right_target ? input_get(0, "move_right") : input_get(0, "move_left")) {
		if (current_fill_speed < max_fill_speed) {
			current_fill_speed = clamp(current_fill_speed + d(1), min_fill_speed, max_fill_speed);
		}
		
		current_fill = clamp(current_fill + d(current_fill_speed), 0, fill_target);
		
		if (current_fill >= fill_target) {
			OnInputValidated();
		}
	}
	else {
		if (current_fill_speed > max_fill_speed) {
			current_fill_speed = clamp(current_fill_speed - d(1), min_fill_speed, max_fill_speed);
		}
	}
}
