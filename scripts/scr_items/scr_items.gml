
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
			return spr_salad_128x128px;
		
		case "protaupe_fruit_a":
			return spr_tomato_128x128px;
		case "protaupe_fruit_b":
			return spr_potato_128x128px;
		case "protaupe_chopped_fruit_a":
			return spr_tomato_cut_128x128px;
		case "protaupe_chopped_fruit_b":
			return spr_potato_cut_128x128px;
		case "protaupe_chopped_fruit_a_cooked":
			return spr_tomato_cooked_128x128px;
		case "protaupe_chopped_fruit_b_cooked":
			return spr_potato_fried_128x128px;
			
		//case "protaupe_egg":
		//	return spr_it_egg;
		//case "protaupe_flour":
		//	return spr_it_flour;
		//case "protaupe_crepe_batter":
		//	return spr_ph_crepe_batter;
		//case "protaupe_crepe":
		//	return spr_ph_crepe;
		//case "protaupe_ratatouille":
		//	return spr_ph_ratatouille;
		default:
			return asset_get_index("spr_" + _item_id);
	}
}

// Do better lol
function GetItemLocalizedName(_item_id) {
	switch (_item_id) {
		case "fruit_salad":
			return "Salade";
		case "protaupe_crepe":
			return "Galettes Bretonnes sans Lait";
		case "protaupe_ratatouille":
			return "Grosse Ratatouille des Familles";
		default:
			return "";
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
		case "it_fruit_1":
			return "it_c_fruit_1";
		case "it_vege_1":
			return "it_c_vege_1";
		case "it_vege_2":
			return "it_c_vege_2";
		default:
			return "none";
	}
}


function GetHeatablePanResult(_item_id) {
	switch (_item_id) {
		case "protaupe_crepe_batter":
			return "protaupe_crepe";
		case "protaupe_chopped_fruit_a":
			return "protaupe_chopped_fruit_a_cooked";
		case "protaupe_chopped_fruit_b":
			return "protaupe_chopped_fruit_b_cooked";
			
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
			return 5;
	}
}

function GetFryingInputCount(_item_id) {
	switch (_item_id) {
		case "protaupe_chopped_fruit_a":
			return 3;
		case "protaupe_chopped_fruit_b":
			return 5;
		case "protaupe_crepe_batter":
			return 8;
		default:
			return 3;
	}
}

function GetItemTags(_item_id) {
	switch (_item_id) {
		// Up to proto
		case "banana":
			return [ITEM_TYPE.RAW_COMPO];
		case "chopped_banana":
			return [ITEM_TYPE.TRANSFORMED_COMPO];
		case "apple":
			return [ITEM_TYPE.RAW_COMPO];
		case "chopped_apple":
			return [ITEM_TYPE.TRANSFORMED_COMPO];
		case "fruit_salad":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "protaupe_fruit_a":
			return [ITEM_TYPE.RAW_COMPO];
		case "protaupe_fruit_b":
			return [ITEM_TYPE.RAW_COMPO];
		case "protaupe_chopped_fruit_a":
			return [ITEM_TYPE.HEATABLE_PAN];
		case "protaupe_chopped_fruit_b":
			return [ITEM_TYPE.HEATABLE_PAN];
		case "protaupe_egg":
			return [ITEM_TYPE.NON_TRANSFORMABLE_COMPO];
		case "protaupe_flour":
			return [ITEM_TYPE.NON_TRANSFORMABLE_COMPO];
		case "protaupe_crepe_batter":
			return [ITEM_TYPE.HEATABLE_PAN];
		case "protaupe_crepe":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "protaupe_ratatouille":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "protaupe_chopped_fruit_a_cooked":
			return [ITEM_TYPE.NON_TRANSFORMABLE_COMPO];
		case "protaupe_chopped_fruit_b_cooked":
			return [ITEM_TYPE.NON_TRANSFORMABLE_COMPO];
			
		// New ones
		case "it_assembled_tart":
			return [ITEM_TYPE.RECIPE_FINAL, ITEM_TYPE.HEATABLE_HOVEN];
		case "it_c_fruit_1":
			return [ITEM_TYPE.TRANSFORMED_COMPO, ITEM_TYPE.HEATABLE_PAN];
		case "it_c_vege_1":
			return [ITEM_TYPE.TRANSFORMED_COMPO, ITEM_TYPE.HEATABLE_PAN];
		case "it_c_vege_2":
			return [ITEM_TYPE.TRANSFORMED_COMPO, ITEM_TYPE.HEATABLE_PAN];
		case "it_cake":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "it_clafoutis":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "it_crepe":
			return [ITEM_TYPE.SUB_RECIPE, ITEM_TYPE.HEATABLE_PAN];
		case "it_crepe_fruits":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "it_crepe_veggies":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "it_dough":
			return [ITEM_TYPE.SUB_RECIPE];
		case "it_egg":
			return [ITEM_TYPE.RAW_COMPO, ITEM_TYPE.HEATABLE_PAN];
		case "it_flour":
			return [ITEM_TYPE.RAW_COMPO];
		case "it_fruit_1":
			return [ITEM_TYPE.RAW_COMPO];
		case "it_fruit_salad":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "it_fruits_cake":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "it_milk":
			return [ITEM_TYPE.RAW_COMPO];
		case "it_milk_egg_flour_combo":
			return [ITEM_TYPE.SUB_RECIPE, ITEM_TYPE.HEATABLE_PAN];
		case "it_oeufs_plat":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "it_pizza":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "it_poelee_legumes":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "it_prep_cake":
			return [ITEM_TYPE.SUB_RECIPE, ITEM_TYPE.HEATABLE_HOVEN];
		case "it_prep_clafoutis":
			return [ITEM_TYPE.SUB_RECIPE, ITEM_TYPE.HEATABLE_HOVEN];
		case "it_prep_fruit_cake":
			return [ITEM_TYPE.SUB_RECIPE, ITEM_TYPE.HEATABLE_HOVEN];
		case "it_prep_pizza":
			return [ITEM_TYPE.SUB_RECIPE, ITEM_TYPE.HEATABLE_HOVEN];
		case "it_salad":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "it_sauce":
			return [ITEM_TYPE.SUB_RECIPE];
		case "it_tart":
			return [ITEM_TYPE.RECIPE_FINAL];
		case "it_vege_1":
			return [ITEM_TYPE.RAW_COMPO];
		case "it_vege_2":
			return [ITEM_TYPE.RAW_COMPO];
		case "it_water":
			return [ITEM_TYPE.RAW_COMPO];
		default:
			return [ITEM_TYPE.NONE];
	}
}

function GetStirCount(_item_id) {
	switch (_item_id) {
		case "protaupe_crepe_batter":
			return 5;
		case "fruit_salad":
			return 5;
		case "protaupe_ratatouille":
			return 5;
		default: return 5;
	}
}
