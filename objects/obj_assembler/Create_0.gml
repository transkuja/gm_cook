event_inherited();

expected_result = "none";
offset_draw_item_x = 0;
max_offset_draw_item_x = 0;
anim_speed = 0.1;
anim_result_speed = 0.02;

function IsItemValid(_itemId) {
	return GetItemType(_itemId) != ITEM_TYPE.RECIPE_FINAL;
}

function IsTransformable() {
	if (IsFilled())	{
		if (!instance_exists(inst_databaseLoader)) {
			_log("ERROR! Obj database loader does not exist !");
			return false;
		}
		
		for (var _index = 0; _index < array_length(inst_databaseLoader.assemble_combos); _index++) {
			var tmp = new AssembleCombo(inst_databaseLoader.assemble_combos[_index].ids, inst_databaseLoader.assemble_combos[_index].result_id );
			var result = tmp.IsCombo(items_in_ids);
			
			if (result != "none") {
				expected_result = result;
				break;
			}
		}
		
		if (expected_result == "none")
			return false;
		else
			return true;
	}	
	
	return false;
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
	if (_index == 0)
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
		max_offset_draw_item_x = _progress * _gap;
	}
	
	StartAnimQteValidated();
}