event_inherited();

anim_result_speed = 0.02;
anim_qte_validated_speed = 0.04;

preparation_type = PREPARATION_TYPE.PAN_COOK;

// Inherited delegates
on_transformation_finished = OnTransformationFinished;
on_qte_validated_feedbacks = OnQteValidatedFeedbacks;
get_items_drawn_offsets = GetItemsDrawnOffsets;

function IsItemValid(_itemId) {
	tags = GetItemTags(_itemId);
	return _contains(tags, ITEM_TYPE.HEATABLE_PAN);
	//return GetItemType(_itemId) == ITEM_TYPE.HEATABLE_PAN;
}

function StopAnimQteValidated() {
	if (anim_item_qte_validated != noone)
		instance_destroy(anim_item_qte_validated);
	
	offset_draw_item = 0;
}

function OnTransformationFinished() {
	if (array_length(items_in_ids) > 0)
	{
		items_in_ids[0] = GetResultFromCombo();
		array_resize(items_in_ids, 1);
	}
	
	initial_item_mash_count = 0;
	initial_progress_received = -1;
	
	StopAnimQteValidated();
	
	var _sa_x = new polarca_animation("item_in_scale_x", 0.5, ac_bump_scale_up_maintained, 0, anim_result_speed);
	var _sa_y = new polarca_animation("item_in_scale_y", 0.5, ac_bump_scale_up_maintained, 0, anim_result_speed);
	polarca_animation_start([_sa_x, _sa_y]);
}

anim_item_qte_validated = noone;
function StartAnimQteValidated() {
	StopAnimQteValidated();
		
	var _offset_y = new polarca_animation("offset_draw_item", 20, ac_bump_translate_y_2, 0, anim_qte_validated_speed);
	//var _offset_y = new polarca_animation("item_in_scale_y", 0.5, ac_bump_scale_up_uniform, 0, anim_qte_validated_speed);
	anim_item_qte_validated = polarca_animation_start([_offset_y]);
	//anim_item_qte_validated.is_ping_pong = true;
	//anim_item_qte_validated.on_animation_finished = Broadcast(function() { offset_draw_item = 0;});	
}


function GetItemInBgColor(_item_index) {
	if (state == TRANSFORMER_STATE.CAN_TRANSFORM) {
		bg_color_lerp = 1;
		return make_color_rgb(16, 235, 147);
	}
	
	return items_in_bg_draw_color[_item_index];
}

frying_bg_color = make_color_rgb(238, 134, 30);
initial_progress_received = -1;
function OnQteValidatedFeedbacks(_progress) {
	if (initial_progress_received < 0)
		initial_progress_received = _progress;
	
	var _lerp =  _progress + initial_progress_received;
	for (var _index = 0; _index < array_length(items_in_ids); _index++)
	{
		items_in_bg_draw_color[_index] = merge_color(c_white, frying_bg_color, _lerp);
	}
	
	StartAnimQteValidated();
}