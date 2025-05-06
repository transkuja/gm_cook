// Inherit the parent event
event_inherited();

initial_item_mash_count = 0;
current_mash_count = 0;

progress_bar_width = 100;
progress_bar_height = 25;
progress_bar_outline = 2.5;

// TMP: diff time to specify good or perfect (mash speed)
first_chop_time = -1;

on_init = OnInit;
on_input_validated = OnInputValidated;
on_reset = OnReset;

function OnInit(_items_id) {
    if (array_length(_items_id) == 0)
		return false;
	
	if (current_mash_count == 0) {
		var _mash_count = GetChopMashCount(_items_id[0]);
		if (_mash_count == -1) { 
			_log("WARNING: Can't find appropriate mash count, fallback to 1");
			_mash_count = 1; 
		}
		
		initial_item_mash_count = _mash_count;
		current_mash_count = _mash_count;
	}
	
	first_chop_time = -1;
	return true;
}

function OnInputValidated() {
	current_mash_count--;
	if (first_chop_time < 0)
		first_chop_time = current_time;
		
	if (initial_item_mash_count > 0 && current_mash_count <= 0)
	{
		if (current_time - first_chop_time < 1800) // 1.8s
			PlayPerfectScoreFeedbacks(x, y - 40);
		else
			PlayGoodScoreFeedbacks(x, y - 40);
				
		Finish();
	}
	else
	{
		audio_play_sound(Cutout_Knife_Hit_01, 10, false);
		PlayValidateFx();
	}
}

function GetProgressRatio() {
	if (initial_item_mash_count <= 0)
		return 0;
		
	return 1 - (current_mash_count / initial_item_mash_count);
}

function DrawProgress() {
	var _draw_xy = WorldToGUI(x, y + progress_y_offset);
	draw_sprite(phgen_rectangle(progress_bar_width, progress_bar_height, c_white, 1, c_grey, progress_bar_width * 0.5, progress_bar_height * 0.5), 0, _draw_xy[0], _draw_xy[1]);
	
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
	if (!layer_sequence_exists("GUI", active_sequence)) {
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
	first_chop_time = -1;
}