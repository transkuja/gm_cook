event_inherited();

drawn_item_animated_xscale = 0
drawn_item_animated_yscale = 0

function IsItemValid(_itemId) {
	return GetItemType(_itemId) == ITEM_TYPE.RAW_COMPO;
}

function IsTransformable() {
	if (IsFilled())
		return GetChoppedResult(items_in_ids[0]) != "none";
		
	return false;
}

function OnTransformationFinished() {
	if (array_length(items_in_ids) > 0)
		items_in_ids[0] = GetChoppedResult(items_in_ids[0]);
	
	initial_item_mash_count = 0;
}

function DrawItemsIn() {
	if (array_length(items_in_ids) > 0)	{
		draw_sprite_ext(
			GetItemSprite(items_in_ids[0]), 0,
				x, y,
				0.8 + drawn_item_animated_xscale, 0.8 + drawn_item_animated_yscale, 
				0, c_white, 1
			);
	}
	
	//_log("DRAWN ITEM ANIMATED SCALE:", drawn_item_animated_xscale);
}

cur_qte_validated_anim = noone;
cur_item_anim = noone;
function OnQteValidatedFeedbacks(_progress) {
	// Anim transformer
	//instance_destroy(cur_qte_validated_anim);
	//image_xscale = initial_scale_x;
	//image_yscale = initial_scale_y;
	
	//var anim_scale_x = new polarca_animation("image_xscale", 1.15, ac_bump_scale, 0, 0.08);
	//var anim_scale_y = new polarca_animation("image_yscale", 0.85, ac_bump_scale, 0, 0.08);
	//cur_qte_validated_anim = polarca_animation_start([anim_scale_x, anim_scale_y]);
	
	// Anim drawn item
	instance_destroy(cur_item_anim);
	drawn_item_animated_xscale = 0
	drawn_item_animated_yscale = 0
	
	var anim_item_sx = new polarca_animation("drawn_item_animated_xscale", 0.15, ac_bump_scale_down, 0, 0.1);
	var anim_item_sy = new polarca_animation("drawn_item_animated_yscale", 0.15, ac_bump_scale_down, 0, 0.1);
	cur_item_anim = polarca_animation_start([anim_item_sx, anim_item_sy]);
	
}