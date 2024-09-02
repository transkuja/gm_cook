
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
	
		case "protaupe_egg":
			return spr_ph_egg;
		case "protaupe_flour":
			return spr_ph_flour;
		case "protaupe_crepe_batter":
			return spr_ph_crepe_batter;
		case "protaupe_crepe":
			return spr_ph_crepe;
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


function GetHeatablePanResult(_item_id) {
	switch (_item_id) {
		case "protaupe_crepe_batter":
			return "protaupe_crepe";
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
		case "protaupe_egg":
			return ITEM_TYPE.NON_TRANSFORMABLE_COMPO;
		case "protaupe_flour":
			return ITEM_TYPE.NON_TRANSFORMABLE_COMPO;
		case "protaupe_crepe_batter":
			return ITEM_TYPE.HEATABLE_PAN;
		case "protaupe_crepe":
			return ITEM_TYPE.RECIPE_FINAL;
		default:
			return ITEM_TYPE.NONE;
	}
}


