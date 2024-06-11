
function GetItemSprite(_item_id) {
	switch (_item_id) {
		case "banana":
			return spr_banana;
		case "chopped_banana":
			return spr_lemon_without_stroke;
		case "apple":
			return spr_apple_without_stroke;
		case "chopped_apple":
			return spr_strawberry_without_stroke;
		case "fruit_salad":
			return spr_tinned_fruit_with_stroke;
		default:
			return noone;
	}
}

function GetChoppedResult(_item_id) {
	switch (_item_id) {
		case "banana":
			return "chopped_banana";
		case "apple":
			return "chopped_apple";
		default:
			return "none";
	}
}

function GetChopMashCount(_item_id) {
	switch (_item_id) {
		case "banana":
			return 5;
		default:
			return -1;
	}
}

function GetItemType(_item_id) {
		switch (_item_id) {
		case "banana":
			return ITEM_TYPE.RAW_COMPO;
		case "chopped_banana":
			return ITEM_TYPE.TRANSFORMED_COMPO;
		case "apple":
			return ITEM_TYPE.RAW_COMPO;
		case "chopped_apple":
			return ITEM_TYPE.TRANSFORMED_COMPO;
		case "fruit_salad":
			return ITEM_TYPE.RECIPE_FINAL;
		default:
			return ITEM_TYPE.NONE;
	}
}


