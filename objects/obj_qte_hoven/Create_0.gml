// Inherit the parent event
event_inherited();

initial_item_mash_count = 0;
current_mash_count = 0;

progress_bar_width = 150;
progress_bar_height = 25;
progress_bar_outline = 2.5;

bar_duration = 10; // -> should be item related
window_open_time = 1;
window_close_time = 1.5;
current_qte_time = 0;
cursor_speed = 0.05;

// Perfect zone -> should be item related
perfect_window_open_time = bar_duration * 0.5;
perfect_window_close_time = bar_duration * 0.7;

// Good zone -> should be item related
good_window_open_time = bar_duration * 0.25;
good_window_close_time = bar_duration * 0.8;

// Nothing zone is before min(perfect_open, good_open)
// Burnt zone is after max(perfect_close, good_close)

current_position = 0;

anticipation_time = 0.5;

is_checking_input = false;

// Anim failed
bg_color_lerp = 0;
anim_speed_failed = 0.025;
anim_failed_inst = noone;

is_init = false;
function OnInit(_items_id) {
	if (array_length(_items_id) == 0)
		return false;
	
	if (!is_init)
	{
		bar_duration = seconds(bar_duration);
		perfect_window_open_time = seconds(perfect_window_open_time);
		perfect_window_close_time = seconds(perfect_window_close_time);
		good_window_open_time = seconds(good_window_open_time);
		good_window_close_time = seconds(good_window_close_time);
	
		current_qte_time = 0;
		current_position = 0;
	}

	is_checking_input = false;
	
	is_init = true;
	return true;
}

function StartMoving() {
	is_checking_input = true;
	instance_destroy(anim_failed_inst);
	bg_color_lerp = 0;
}

loop_sound_inst = noone;
function OnStart() {
	StartMoving();
	loop_sound_inst = audio_play_sound(in_progress_sound, 10, true);
}

function OnInputPressed() {

}

function OnInputValidated() {

}

function OnInputFailed() {

}

function GetProgressRatio() {
	return 0;
}

function DrawCursor(_x, _y) {
	var _pos = _x + current_position - (progress_bar_width * 0.5);
	var _height = progress_bar_height + 10;
	draw_sprite(phgen_rectangle(10, _height, c_red, 0, c_white, 5, _height * 0.5), 0, _pos, _y);
}

function DrawZone(_pb_draw_xy, _start_time, _end_time, _color) {
	var pb_content_w = progress_bar_width * InvLerp(0, bar_duration, _end_time - _start_time);
	var pb_content_h = progress_bar_height;
	var pb_content_start_pos = InvLerp(0, bar_duration, _start_time) * progress_bar_width - (progress_bar_width * 0.5);
	if (pb_content_w > 0 && pb_content_h > 0)
		draw_sprite(phgen_rectangle(pb_content_w, pb_content_h, _color, 0, c_white, 0, progress_bar_height * 0.5), 0, _pb_draw_xy[0] + pb_content_start_pos, _pb_draw_xy[1]);
}

function DrawProgress() {
	var _draw_xy = WorldToGUI(x, y + progress_y_offset);
	var _bg_color = merge_colour(c_white, make_color_rgb(215,0,0), bg_color_lerp);
	draw_sprite(phgen_rectangle(progress_bar_width, progress_bar_height, _bg_color, 1, c_grey, progress_bar_width * 0.5, progress_bar_height * 0.5), 0, _draw_xy[0], _draw_xy[1]);
	
	// Draw good zone
	DrawZone(_draw_xy, good_window_open_time, good_window_close_time, c_orange);
	
	// Draw perfect zone
	DrawZone(_draw_xy, perfect_window_open_time, perfect_window_close_time, c_green);
	
	// Draw burnt zone
	DrawZone(_draw_xy, max(perfect_window_close_time, good_window_close_time), bar_duration, c_black);
	
	//var pb_content_w = progress_bar_width * InvLerp(0, bar_duration, window_close_time - window_open_time);
	//var pb_content_h = progress_bar_height;
	//var pb_content_start_pos = InvLerp(0, bar_duration, window_open_time) * progress_bar_width - (progress_bar_width * 0.5);
	//if (pb_content_w > 0 && pb_content_h > 0)
	//	draw_sprite(phgen_rectangle(pb_content_w, pb_content_h, c_green, 0, c_white, 0, progress_bar_height * 0.5), 0, _draw_xy[0] + pb_content_start_pos, _draw_xy[1]);
		
	DrawCursor(_draw_xy[0], _draw_xy[1]);
}

function DrawBackground() {
	//var _draw_xy = WorldToGUI(x, y - 85);
	//var _w = progress_bar_width + 100;
	//var _h = progress_bar_height + 20;
	//draw_sprite(phgen_rectangle(_w, _h, c_gray, 0, c_gray, _w * 0.5, _h * 0.5), 0, _draw_xy[0], _draw_xy[1]);
}


function SetFeedbacksInitialState() {
	if (input_sequence == noone)
		return;
		
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
	//current_qte_time = 0; -> don't reset time
	// current_position = 0;
	is_checking_input = false;
	audio_stop_sound(loop_sound_inst);
}

function SpecificInputBehavior() {
	if (is_checking_input) {
		current_qte_time += d(1);
	
		current_qte_time = clamp(current_qte_time, 0, bar_duration);
		current_position = Remap(0, bar_duration, 0, progress_bar_width, current_qte_time);
	
		if (current_qte_time >= bar_duration) {
			is_checking_input = false;
		}
	}
}

function StopHoven() {
	// Check if min time reached, else return
	if (current_qte_time < good_window_open_time)
	{
		return 0;
	}
	else
	{
		if (current_qte_time >= perfect_window_open_time && current_qte_time <= perfect_window_close_time)
		{
			// Perfect
			PlayPerfectScoreFeedbacks(x, y - 70);
			return 1;
		}
		// Item was cooked
		else if (current_qte_time >= good_window_open_time && current_qte_time <= good_window_close_time)
		{
			// Nice
			PlayGoodScoreFeedbacks(x, y - 70);
			return 0.5;
		}
		else
		{
			// burnt
			return -1;
		}
	}
}