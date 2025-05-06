event_inherited();

expected_result = "none";
offset_draw_item_x = 0;
max_offset_draw_item_x = 0;
anim_speed = 0.1;
anim_result_speed = 0.02;
anim_speed_conditions_not_met = 0.02;

preparation_type = PREPARATION_TYPE.STIR;

// Inherited delegates
on_transformation_finished = OnTransformationFinished;
on_qte_validated_feedbacks = OnQteValidatedFeedbacks;
get_items_drawn_offsets = GetItemsDrawnOffsets;

function IsItemValid(_itemId) {
	return !_contains(GetItemTags(_itemId), ITEM_TYPE.RECIPE_FINAL);
	//return GetItemType(_itemId) != ITEM_TYPE.RECIPE_FINAL;
}

function OnTransformationFinished() {
	items_in_ids = array_create(1, expected_result);
	
	initial_item_mash_count = 0;
	instance_destroy(anim_item_qte_validated);
	offset_draw_item_x = 0;
	
	var _sa_x = new polarca_animation("item_in_scale_x", 0.5, ac_bump_scale_up_maintained, 0, anim_result_speed);
	var _sa_y = new polarca_animation("item_in_scale_y", 0.5, ac_bump_scale_up_maintained, 0, anim_result_speed);
	polarca_animation_start([_sa_x, _sa_y]);
}

function GetItemsDrawnOffsets(_index = 0, _max = 1) {
	var _max_modulo = _max % 2;
	var _half_max = 0;
	if (_max_modulo == 0)
	{
		_half_max = _max * 0.5;
	}
	else
	{
		_half_max = (_max - 1) * 0.5;
		// If odd and _index is the middle
		if (_index == _half_max)
			return [0, offset_draw_item];
	}
	
	if (_half_max == 0)
		return [offset_draw_item_x, offset_draw_item];
		
	if (_index < _half_max)
		return [offset_draw_item_x, offset_draw_item];
	
	return [-offset_draw_item_x, offset_draw_item];
}

anim_item_qte_validated = noone;
function StartAnimQteValidated() {
	StopAnimQteValidated();
		
	var _offset_ya = new polarca_animation("offset_draw_item_x", max_offset_draw_item_x, ac_bump_x_assemble,0, anim_speed);
	anim_item_qte_validated = polarca_animation_start([_offset_ya]);
	anim_item_qte_validated.on_animation_finished = Broadcast(function() { offset_draw_item_x = max_offset_draw_item_x;});	
	//anim_item.is_ping_pong = true;
}

function StopAnimQteValidated() {
	if (anim_item_qte_validated != noone)
		instance_destroy(anim_item_qte_validated);
	
	//offset_draw_item = 0;
}

function OnQteValidatedFeedbacks(_progress) {
	var _nb_items_to_draw = (state == TRANSFORMER_STATE.RESULT) ? 1 : max_items;
	var _draw_xs = GetPositionsOnLineCenter(draw_circle_radius, 50, _nb_items_to_draw, x, SPRITE_ORIGIN.TOP_LEFT);
	if (array_length(_draw_xs) > 0) {
		var _gap = (x - _draw_xs[0]) * 0.5;
		if (_nb_items_to_draw == 2)
			_gap = (_draw_xs[array_length(_draw_xs) -1] -  _draw_xs[0]) * 0.5 * 0.5;

		max_offset_draw_item_x = (_progress * _gap);
	}
	
	StartAnimQteValidated();
}

anim_interaction_blocked = noone;
function StopInteractionBlockedFeedback() {
	instance_destroy(anim_interaction_blocked);
	items_in_bg_draw_color = array_create(max_items, c_white);
}

function InteractionBlockedFeedback() {
	if (IsFilled())
		items_in_bg_draw_color = array_create(max_items, c_red);
	else {
		for (var _i = array_length(items_in_ids); _i < max_items; _i++) {
			items_in_bg_draw_color[_i] = c_red;
		}
	}
	
	instance_destroy(anim_interaction_blocked);
	bg_color_lerp = 0;
	var _feedback_anim = new polarca_animation("bg_color_lerp", 100, ac_on_off_three, 0, anim_speed_conditions_not_met);
	anim_interaction_blocked = polarca_animation_start([_feedback_anim]);
	anim_interaction_blocked.on_animation_finished = Broadcast(
		function() { 
			bg_color_lerp = 0; 
			items_in_bg_draw_color = array_create(max_items, c_white);
	});
}

function DrawDebug() {
	
	if (should_draw && draw_debug)
	{
		draw_line_color(x - max_offset_draw_item_x, debug_y,
			x + max_offset_draw_item_x, debug_y, c_fuchsia, c_fuchsia);
			
		draw_line_color(x + max_offset_draw_item_x, debug_y - 50,
			x + max_offset_draw_item_x, debug_y + 50, c_fuchsia, c_fuchsia);
			
		draw_line_color(x - max_offset_draw_item_x, debug_y - 50,
			x - max_offset_draw_item_x, debug_y + 50, c_fuchsia, c_fuchsia);

		draw_circle_color(x, debug_y, 10, c_aqua, c_aqua, false);
		
	}
}