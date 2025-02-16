image_alpha = 1;

is_selected = false;
draw_feedback_selection = false;

_center_x = center_x(); //x + (sprite_width * 0.5);
_center_y = center_y(); //y + (sprite_height * 0.5);
slot_index = 0;

// Animations -> button anim rather than item anim ?
//bump_anim_speed = 0.1;
//anim_scale_x = 0;
//anim_scale_y = 0;
//cur_anim = noone;

left_slot = noone;
right_slot = noone;
up_slot = noone;
down_slot = noone;

can_interact = true;
owner = noone;

hovering_last_frame = false;
hovering = false;
clicked = false;

on_clicked_event = noone;

function DrawSelectedFeedback() {
	//draw_sprite_ext(spr_ui_slot_selected, 0, _center_x, _center_y, 1, 1, 0, c_orange, 1);
}

function EnableSelectedFeedback() {
}

function RemoveSelectedFeedback() {
}

function SetSelected(_value) {
	is_selected = _value;
	
	if (_value == false)
		RemoveSelectedFeedback();
	
	if (_value == true)
		EnableSelectedFeedback();
}

function OnMouseEnter() {
	global.interact_blocked = true;
	UpdateVisual();
	
	draw_debug = true;
}

function OnMouseExit() {
	global.interact_blocked = false;
	UpdateVisual();
	
	draw_debug = false;
}


on_clicked = function() {
	if (global.player_control < 0) return;
	audio_play_sound(snd_on_clicked, 10, false);
	
	if (on_clicked_event != noone)
		on_clicked_event.dispatch(on_click_param);
}

on_click_param = {};

function UpdateVisual() {
	if (clicked) 
	{
		image_index = 2;
	} 
	else if (hovering) 
	{
		image_index = 1;
	} 
	else 
	{
		image_index = 0;
	}
}

debug_enabled = false;
draw_debug = false;
function DrawDebugPattern(_origin, _target, _color) {
	draw_line_color(_origin.x + sprite_width * 0.5, _origin.y + sprite_height * 0.5,
		_target.x + sprite_width * 0.5, _target.y + sprite_height * 0.5, _color, _color);
	draw_circle_color(_target.x + sprite_width * 0.5, _target.y + sprite_height * 0.5, 10, _color, _color, false);
	//draw_circle(_target.x, _target.y, 10, false);
}

function DrawDebug() {
	if (debug_enabled && draw_debug)
	{
		
		if (instance_exists(up_slot))
			DrawDebugPattern(self, up_slot, c_fuchsia);
		if (instance_exists(down_slot))
			DrawDebugPattern(self, down_slot, c_green);
		if (instance_exists(left_slot))
			DrawDebugPattern(self, left_slot, c_yellow);
		if (instance_exists(right_slot))
			DrawDebugPattern(self, right_slot, c_red);	
		
		draw_circle_color(x + sprite_width * 0.5, y + sprite_height * 0.5, 10, c_aqua, c_aqua, false);
	}
}