
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
		
		case "protaupe_fruit_a":
			return spr_protaupe_fruit_a;
		case "protaupe_fruit_b":
			return spr_protaupe_fruit_b;
		case "protaupe_chopped_fruit_a":
			return spr_protaupe_chop_fruit_a;
		case "protaupe_chopped_fruit_b":
			return spr_protaupe_chop_fruit_b;
			
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
		case "protaupe_fruit_a":
			return "protaupe_chopped_fruit_a";
		case "protaupe_fruit_b":
			return "protaupe_chopped_fruit_b";
		default:
			return "none";
	}
}

function GetChopMashCount(_item_id) {
	switch (_item_id) {
		case "banana":
			return 5;
		case "protaupe_fruit_a":
			return 5;
		case "protaupe_fruit_b":
			return 8;
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
		case "protaupe_fruit_a":
			return ITEM_TYPE.RAW_COMPO;
		case "protaupe_fruit_b":
			return ITEM_TYPE.RAW_COMPO;
		case "protaupe_chopped_fruit_a":
			return ITEM_TYPE.TRANSFORMED_COMPO;
		case "protaupe_chopped_fruit_b":
			return ITEM_TYPE.TRANSFORMED_COMPO;
		default:
			return ITEM_TYPE.NONE;
	}
}


