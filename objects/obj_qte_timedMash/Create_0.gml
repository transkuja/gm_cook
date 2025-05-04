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
cursor_speed = 0.05;

current_position = 0;

anticipation_time = 0.5;

is_checking_input = false;

// Anim failed
bg_color_lerp = 0;
anim_speed_failed = 0.025;
anim_failed_inst = noone;

function OnInit(_items_id) {
	if (array_length(_items_id) == 0)
		return false;
	
	if (current_mash_count == 0) {
		var _mash_count = GetFryingInputCount(_items_id[0]);
		if (_mash_count == -1) { return false; }
		
		initial_item_mash_count = _mash_count;
		current_mash_count = _mash_count;
	}
	
	failed_once = false;
	return true;
}

function CheckInputIsValid() {
	return current_qte_time >= window_open_time && current_qte_time <= window_close_time;
}

function GoToStartLocation() {
	is_checking_input = false;
	current_position = 0;
	current_qte_time = 0;
	alarm[0] = seconds(anticipation_time);
	
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

failed_once = false;

function OnInputValidated() {
	if (!is_checking_input) return;
	is_checking_input = false;
	
	current_mash_count--;
	if (initial_item_mash_count > 0 && current_mash_count <= 0)
	{
		if (failed_once)
			PlayGoodScoreFeedbacks(x, y);
		else
			PlayPerfectScoreFeedbacks(x, y);
			
		Finish();
	}
	else
	{
		PlayGoodScoreFeedbacks(x, y);
		audio_play_sound(correct_input_sound, 10, false);
		GoToStartLocation();
	}
}

function OnInputFailed() {
	if (!is_checking_input) return;
	
	// Play failed anim
	instance_destroy(anim_failed_inst);
	bg_color_lerp = 0;
	var _feedback_anim = new polarca_animation("bg_color_lerp", 1, ac_on_off_two, 0, anim_speed_failed);
	anim_failed_inst = polarca_animation_start([_feedback_anim]);
	anim_failed_inst.on_animation_finished = Broadcast(
		function() { 
			bg_color_lerp = 0; 
	});
	
	failed_once = true;
	GoToStartLocation();
}

function GetProgressRatio() {
	if (initial_item_mash_count <= 0)
		return 0;
		
	return 1 - (current_mash_count / initial_item_mash_count);
}

function DrawCursor(_x, _y) {
	var _pos = _x + current_position - (progress_bar_width * 0.5);
	var _height = progress_bar_height + 10;
	draw_sprite(phgen_rectangle(10, _height, c_red, 0, c_white, 5, _height * 0.5), 0, _pos, _y);
}

function DrawProgress() {
	var _draw_xy = WorldToGUI(x, y + progress_y_offset);
	var _bg_color = merge_colour(c_white, make_color_rgb(215,0,0), bg_color_lerp);
	draw_sprite(phgen_rectangle(progress_bar_width, progress_bar_height, _bg_color, 1, c_grey, progress_bar_width * 0.5, progress_bar_height * 0.5), 0, _draw_xy[0], _draw_xy[1]);
	
	var pb_content_w = progress_bar_width * InvLerp(0, bar_duration, window_close_time - window_open_time);
	var pb_content_h = progress_bar_height;
	var pb_content_start_pos = InvLerp(0, bar_duration, window_open_time) * progress_bar_width - (progress_bar_width * 0.5);
	if (pb_content_w > 0 && pb_content_h > 0)
		draw_sprite(phgen_rectangle(pb_content_w, pb_content_h, c_green, 0, c_white, 0, progress_bar_height * 0.5), 0, _draw_xy[0] + pb_content_start_pos, _draw_xy[1]);
		
	DrawCursor(_draw_xy[0], _draw_xy[1]);
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
	current_qte_time = 0;
	current_position = 0;
	is_checking_input = false;
	failed_once = false;
	audio_stop_sound(loop_sound_inst);
}

function SpecificInputBehavior() {
	if (is_checking_input) {
		current_qte_time += d(cursor_speed);
	
		current_qte_time = clamp(current_qte_time, 0, bar_duration);
		current_position = Remap(0, bar_duration, 0, progress_bar_width, current_qte_time);
	
		if (current_qte_time >= bar_duration) {
			is_checking_input = false;
			GoToStartLocation();
		}
	}
}
