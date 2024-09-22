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

anticipation_time = 0.25;

is_checking_input = false;

is_right_target = true;
fill_target = 1000.0;
current_fill = 0;
min_fill_speed = 1;
max_fill_speed = 50;
current_fill_speed = min_fill_speed;

stir_sound_inst = noone;

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

function NextTarget() {
	is_right_target = !is_right_target;
	current_fill = 0;
	current_fill_speed = min_fill_speed;
	
	var _s_id = layer_sequence_get_sequence(active_sequence);
	if (sequence_exists(_s_id)) {
		layer_sequence_angle(active_sequence, is_right_target ? 0 : 180);
		//_s_id.tracks
	}
	
	alarm[0] = seconds(anticipation_time);
}

function CheckInputIsValid() {
	return current_qte_time >= window_open_time && current_qte_time <= window_close_time;
}

function StartMoving() {
	is_checking_input = true;
}

function OnStart() {
	StartMoving();
}

function OnInputPressed() {
	if (input_get_pressed(0, "qte")) {
		// TODO: mouse tracking
		
		//if (CheckInputIsValid()) {
		//	OnInputValidated();
		//}
		//else {
		//	OnInputFailed();
		//}
	}
}

function OnInputValidated() {
	_log("OnInputValidated");
	if (!is_checking_input) return;
	is_checking_input = false;
	
	current_mash_count--;
	if (initial_item_mash_count > 0 && current_mash_count <= 0)
		Finish();
	else
		NextTarget();
}

function OnInputFailed() {
	//if (!is_checking_input) return;
	
	//GoToStartLocation();
}

function DrawCursor(_x, _y) {
	//var _pos = _x + current_position - (progress_bar_width * 0.5);
	//var _height = progress_bar_height + 10;
	//draw_sprite(phgen_rectangle(10, _height, c_black, 0, c_white, 10, _height * 0.5), 0, _pos, _y);
}

function GetProgressRatio() {
	if (initial_item_mash_count <= 0)
		return 0;
	
	return current_fill / fill_target;
}

function DrawProgress() {
	var _draw_xy = WorldToGUI(x, y + progress_y_offset);
	draw_sprite(phgen_rectangle(progress_bar_width, progress_bar_height, c_white, 0, c_white, progress_bar_width * 0.5, progress_bar_height * 0.5), 0, _draw_xy[0], _draw_xy[1]);
	
	var pb_content_w = (progress_bar_width - 2*progress_bar_outline) * GetProgressRatio();
	var pb_content_h = progress_bar_height - 2*progress_bar_outline;
	if (pb_content_w > 1 && pb_content_h > 1) {
		if (is_right_target) {
			draw_sprite(phgen_rectangle(pb_content_w, pb_content_h, c_green, 0, c_white, 0, progress_bar_height * 0.5), 0, _draw_xy[0] - progress_bar_width * 0.5 + progress_bar_outline, _draw_xy[1] + progress_bar_outline);
		} else {
			draw_sprite(phgen_rectangle(pb_content_w, pb_content_h, c_green, 0, c_white, 0, progress_bar_height * 0.5), 0, _draw_xy[0] + progress_bar_width * 0.5 - progress_bar_outline - pb_content_w, _draw_xy[1] + progress_bar_outline);
		}
	}
		
	DrawCursor(_draw_xy[0], _draw_xy[1]);
}

function DrawBackground() {
	//var _draw_xy = WorldToGUI(x, y - 85);
	//var _w = progress_bar_width + 100;
	//var _h = progress_bar_height + 20;
	//draw_sprite(phgen_rectangle(_w, _h, c_gray, 0, c_gray, _w * 0.5, _h * 0.5), 0, _draw_xy[0], _draw_xy[1]);
}


function SetFeedbacksInitialState() {
	if (!sequence_exists(active_sequence)) {
		var _seq_x = x - 25 - (progress_bar_width * 0.5);
		var _seq_y = y - 85;
		
		active_sequence = layer_sequence_create("GUI", _seq_x, _seq_y, input_sequence);
	}
	
	layer_sequence_xscale(active_sequence, 0.35);
	layer_sequence_yscale(active_sequence, 0.35);
	layer_sequence_pause(active_sequence);
}

function OnReset() 
{
	is_right_target = true;
	current_fill = 0;
	is_checking_input = false;
	current_qte_time = 0;
	current_position = 0;
	current_fill_speed = min_fill_speed;
}