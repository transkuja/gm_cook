
function GetItemSprite(_item_id) {
	switch (_item_id) {
		case "banana":
			return spr_banana;
		default:
			return noone;
	}
}