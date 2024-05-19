item_id = "";
is_init = false;
is_dropped = false;
sprite_item_ref = noone;

player_xoffset = 0.0;
player_yoffset = -200.0;

// Outline shader
handler=shader_get_uniform(shader_outline,"texture_Pixel")
handler_1=shader_get_uniform(shader_outline,"thickness_power")
handler_2=shader_get_uniform(shader_outline,"RGBA")

shader_enabled = false;

function Initialize(_itemId) {
	item_id = _itemId;
	if (item_id != "none")
	{
		sprite_item_ref = GetItemSprite(item_id);
		sprite_index = sprite_item_ref;
	}
	
	mask_index = spr_no_coll_mask;
	
	is_init = true;
}

function Drop(_x, _y) {
	x = _x;
	y = _y;
	is_dropped = true;
	mask_index = sprite_item_ref;
}

function PickUp() {
	is_dropped = false;
	mask_index = spr_no_coll_mask;
	CanBePickedUpFeedback(false);
}

function CanBePickedUpFeedback(_enable) {
	shader_enabled = _enable;
}

function MoveWithPlayer(_x, _y, _depth) {
	if (is_dropped) { return; }
	x = _x + player_xoffset;
	y = _y + player_yoffset;
	depth = _depth - 5;
}