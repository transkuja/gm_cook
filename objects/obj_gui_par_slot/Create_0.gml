image_alpha = 1;
item_data = {};

is_selected = false;
_center_x = center_x(); //x + (sprite_width * 0.5);
_center_y = center_y(); //y + (sprite_height * 0.5);

item_scale = 0.85;
cur_qty = -1;

// Animations
anim_txt_scale_x = 0;
anim_txt_scale_y = 0;
bump_anim_speed = 0.1;

anim_item_scale_x = 0;
anim_item_scale_y = 0;
cur_anim = noone;
//bump_item_anim_speed = 0.1;

left_slot = noone;
right_slot = noone;
up_slot = noone;
down_slot = noone;

can_interact = true;
owner = noone;

function StartBumpAnimIncrease() {
	instance_destroy(cur_anim);
	anim_txt_scale_x = 0;
	anim_txt_scale_y = 0;
	anim_item_scale_x = 0;
	anim_item_scale_y = 0;
	
	var _text_sa_x = new polarca_animation("anim_txt_scale_x", 0.25, ac_bump_scale_up_uniform, 0, bump_anim_speed);
	var _text_sa_y = new polarca_animation("anim_txt_scale_y", 0.25, ac_bump_scale_up_uniform, 0, bump_anim_speed);
	
	var _item_sa_x = new polarca_animation("anim_item_scale_x", 0.2, ac_bump_scale_up_uniform, 0, bump_anim_speed);
	var _item_sa_y = new polarca_animation("anim_item_scale_y", 0.2, ac_bump_scale_up_uniform, 0, bump_anim_speed);
	
	cur_anim = polarca_animation_start([_text_sa_x, _text_sa_y, _item_sa_x, _item_sa_y]);
}

function StartBumpAnimDecrease() {
	instance_destroy(cur_anim);
	anim_txt_scale_x = 0;
	anim_txt_scale_y = 0;
	anim_item_scale_x = 0;
	anim_item_scale_y = 0;
	
	var _cur_anim_speed = bump_anim_speed * 0.75;
	
	var _item_sa_x = new polarca_animation("anim_item_scale_x", 0.3, ac_bump_scale_down, 0, _cur_anim_speed);
	var _item_sa_y = new polarca_animation("anim_item_scale_y", 0.3, ac_bump_scale_down, 0, _cur_anim_speed);
	
	cur_anim = polarca_animation_start([_item_sa_x, _item_sa_y]);
}

function Refresh(_itemData) {
	if (struct_exists(_itemData, "qty")) 
	{
		if (cur_qty != _itemData.qty) {
			if (_itemData.qty > 0)
			{
				// Play anim
				if (cur_qty < _itemData.qty)
					StartBumpAnimIncrease();
				else
					StartBumpAnimDecrease();
			}	
			cur_qty = _itemData.qty;
		}
	}
	else {
		cur_qty = 0;
	}
	
	// TODO: check if data is copied or passed by ref
	item_data = _itemData;
	
}

function SetSelected(_value) {
	is_selected = _value;
}

function DrawSelectedFeedback() {
	draw_sprite_ext(spr_ui_slot_selected, 0, _center_x, _center_y, 1, 1, 0, c_orange, 1);
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

hovering_last_frame = false;
hovering = false;
clicked = false;

on_clicked_event = noone;
on_clicked = function() {
	if (global.player_control < 0) return;
	audio_play_sound(Minimalist1, 10, false);

	//if (is_selected) {
	//	if (instance_exists(inst_player)) {
	//		inst_player.GetItemFromInventoryToHands();
	//	}
	//}
	
	//if (instance_exists(inst_inventory)) {
	//	inst_inventory.SetSelectedSlot(slot_index);
	//}
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
		//var x_mouse = device_mouse_x_to_gui(0);
		//var y_mouse = device_mouse_y_to_gui(0);
		//var text_value = string(x_mouse) + "," + string(y_mouse);

		//draw_text_color(x_mouse + 5, y_mouse - 5, text_value, c_green, c_green, c_green, c_green, 1);
	}
}