/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

preparation_type = PREPARATION_TYPE.HOVEN_COOK;


anim_result_speed = 0.02;
anim_qte_validated_speed = 0.04;

function OnInteract() {
	if (state == TRANSFORMER_STATE.IN_PROGRESS)
	{
		var _hoven_result = 0;
		// Stop hoven
		if (instance_exists(qte_holder))
		{
			_hoven_result = qte_holder.StopHoven();
		}
		
		if (_hoven_result == 0)
		{
			// Reset
			CreateQteHolder();
			
			if (current_state) 
				current_state.transition_to(new TransformerCanTransformState(id));
			return;
		}
		else
		{
			var _result_id = _hoven_result > 0 ? GetResultFromCombo() : "it_hoven_burnt";
			if (array_length(items_in_ids) > 0) {
				array_resize(items_in_ids, 1);
				items_in_ids[0] = _result_id;
			}
			else {
				_push(items_in_ids, _result_id);
			}
			
			// Transformer will go into result state
			if (instance_exists(qte_holder))
				qte_holder.Finish();
		}
	}
}

function IsItemValid(_itemId) {
	tags = GetItemTags(_itemId);
	return _contains(tags, ITEM_TYPE.HEATABLE_HOVEN);
	//return GetItemType(_itemId) == ITEM_TYPE.HEATABLE_PAN;
}

function StopAnimQteValidated() {
	if (anim_item_qte_validated != noone)
		instance_destroy(anim_item_qte_validated);
	
	offset_draw_item = 0;
}

function OnTransformationFinished() {
	//if (array_length(items_in_ids) > 0)
	//{
	//	items_in_ids[0] = GetResultFromCombo();
	//	array_resize(items_in_ids, 1);
	//}
	
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
