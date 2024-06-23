// Inherit the parent event
event_inherited();

initial_item_mash_count = 0;
current_mash_count = 0;

progress_bar_width = 100;
progress_bar_height = 25;
progress_bar_outline = 2.5;

bar_duration = 2;
window_open_time = 1;
window_close_time = 1.5;
current_qte_time = 0;

start_position = 0;
end_position = 0;
current_position = 0;

anticipation_time = 0.5;

is_checking_input = false;

function OnInit(_items_id) {
	if (array_length(_items_id) == 0)
		return false;
	
	if (current_mash_count == 0) {
		//var _mash_count = GetChopMashCount(_items_id[0]);
		//if (_mash_count == -1) { return false; }
		
		initial_item_mash_count = 1;
		current_mash_count = 1;
	}
	
	
	return true;
}

function CheckInputIsValid() {
	return current_qte_time >= window_open_time && current_qte_time <= window_close_time;
}

function GoToStartLocation() {
	is_checking_input = false;
	current_position = start_position;
	current_qte_time = 0;
	alarm[0] = seconds(anticipation_time);
	
}

function StartMoving() {
	is_checking_input = true;
}

function OnInputValidated() {
	if (!is_checking_input) return;
	
	current_mash_count--;
	if (initial_item_mash_count > 0 && current_mash_count <= 0)
		Finish();
	else
		GoToStartLocation();
}

function OnInputFailed() {
	if (!is_checking_input) return;
	
	GoToStartLocation();
}

function GetProgressRatio() {
	if (initial_item_mash_count <= 0)
		return 0;
		
	return 1 - (current_mash_count / initial_item_mash_count);
}

function DrawProgress() {
	var _draw_xy = WorldToGUI(x, y - 85);
	draw_sprite(phgen_rectangle(progress_bar_width, progress_bar_height, c_white, 0, c_white, progress_bar_width * 0.5, progress_bar_height * 0.5), 0, _draw_xy[0], _draw_xy[1]);
	
	var pb_content_w = progress_bar_width * InvLerp(0, bar_duration, window_close_time - window_open_time);
	var pb_content_h = progress_bar_height;
	var pb_content_start_pos = InvLerp(0, bar_duration, window_open_time) * progress_bar_width - (progress_bar_width * 0.5);
	if (pb_content_w > 0 && pb_content_h > 0)
		draw_sprite(phgen_rectangle(pb_content_w, pb_content_h, c_green, 0, c_white, 0, progress_bar_height * 0.5), 0, _draw_xy[0] + pb_content_start_pos, _draw_xy[1]);
}

function DrawBackground() {
	//var _draw_xy = WorldToGUI(x, y - 85);
	//var _w = progress_bar_width + 100;
	//var _h = progress_bar_height + 20;
	//draw_sprite(phgen_rectangle(_w, _h, c_gray, 0, c_gray, _w * 0.5, _h * 0.5), 0, _draw_xy[0], _draw_xy[1]);
}


function SetFeedbacksInitialState() {
	if (!sequence_exists(active_sequence)) {
		var _seq_x = x - 50 - (progress_bar_width * 0.5);
		var _seq_y = y - 85;
		
		active_sequence = layer_sequence_create("GUI", _seq_x, _seq_y, seq_press_button);
	}
	
	layer_sequence_xscale(active_sequence, 0.35);
	layer_sequence_yscale(active_sequence, 0.35);
	layer_sequence_pause(active_sequence);
}