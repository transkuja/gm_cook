image_alpha = 1;
item_data = {};

is_selected = false;
_center_x = center_x(); //x + (sprite_width * 0.5);
_center_y = center_y(); //y + (sprite_height * 0.5);

item_scale = 0.85;
cur_qty = -1;

animated_scale_x = 0;
animated_scale_y = 0;
bump_anim_speed = 0.1;

function StartBumpAnimIncrease() {
	animated_scale_x = 0;
	animated_scale_y = 0;
	var _text_anim_scale_x = new polarca_animation("animated_scale_x", 0.25, ac_bump_scale_up_uniform, 0, bump_anim_speed);
	var _text_anim_scale_y = new polarca_animation("animated_scale_y", 0.25, ac_bump_scale_up_uniform, 0, bump_anim_speed);
	polarca_animation_start([_text_anim_scale_x, _text_anim_scale_y]);
}

function Refresh(_itemData) {
	if (cur_qty < _itemData.qty && _itemData.qty > 0) {
		// Play anim
		StartBumpAnimIncrease();
		
	}
	
	// TODO: check if data is copied or passed by ref
	item_data = _itemData;
	cur_qty = item_data.qty;
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
}

function OnMouseExit() {
	global.interact_blocked = false;
	UpdateVisual();
}

hovering_last_frame = false;
hovering = false;
clicked = false;

on_clicked_event = noone;
on_clicked = function() {
	if (global.player_control == false) return;
	audio_play_sound(Minimalist1, 10, false);

	if (is_selected) {
		if (instance_exists(inst_player)) {
			inst_player.GetItemFromInventoryToHands();
		}
	}
	
	if (instance_exists(inst_inventory)) {
		inst_inventory.SetSelectedSlot(slot_index);
	}
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