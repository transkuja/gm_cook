// Inherit the parent event
event_inherited();

initial_item_mash_count = 0;
current_mash_count = 0;

progress_bar_width = 100;
progress_bar_height = 25;
progress_bar_outline = 2.5;

function OnInit(_items_id) {
	if (array_length(_items_id) == 0)
		return false;
	
	if (current_mash_count == 0) {
		//var _mash_count = GetChopMashCount(_items_id[0]);
		//if (_mash_count == -1) { return false; }
		
		initial_item_mash_count = 5;
		current_mash_count = 5;
	}
	
	return true;
}

function OnInputValidated() {
	current_mash_count--;
	if (initial_item_mash_count > 0 && current_mash_count <= 0)
		Finish();
}

function GetProgressRatio() {
	if (initial_item_mash_count <= 0)
		return 0;
		
	return 1 - (current_mash_count / initial_item_mash_count);
}

function DrawProgress() {
	var _draw_xy = WorldToGUI(x, y + progress_y_offset);
	draw_sprite(phgen_rectangle(progress_bar_width, progress_bar_height, c_white, 0, c_white, progress_bar_width * 0.5, progress_bar_height * 0.5), 0, _draw_xy[0], _draw_xy[1]);
	
	var pb_content_w = (progress_bar_width - 2*progress_bar_outline) * GetProgressRatio();
	var pb_content_h = progress_bar_height - 2*progress_bar_outline;
	if (pb_content_w > 0 && pb_content_h > 0)
		draw_sprite(phgen_rectangle(pb_content_w, pb_content_h, c_green, 0, c_white, 0, progress_bar_height * 0.5), 0, _draw_xy[0] - progress_bar_width * 0.5 + progress_bar_outline, _draw_xy[1] + progress_bar_outline);
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
		
		active_sequence = layer_sequence_create("GUI", _seq_x, _seq_y, input_sequence);
	}
	
	layer_sequence_xscale(active_sequence, 0.35);
	layer_sequence_yscale(active_sequence, 0.35);
	layer_sequence_pause(active_sequence);
}

function OnReset() {
	initial_item_mash_count = 0;
	current_mash_count = 0;
}