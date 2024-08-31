assemble_combos = [];
recipes_data = [];
dialogues = ds_map_create();
localized_texts = ds_map_create();
quests = ds_map_create();
dialogues_requirements = ds_map_create();

function LoadAssembleCombos() {
	assemble_combos = load_database("assemble_combos.txt");
}

function LoadRecipes() {
	recipes_data = load_database("recipes.txt");
	
	//file = file_text_open_read("recipes.txt");
	
	//if (file == -1) {
	//	_log("Can't open Recipes file !");
	//	return;
	//}
	
	//while (!file_text_eof(file)) {
	//	to_parse = file_text_readln(file);
	//	_log(to_parse);
		
	//	var recipe = json_parse(to_parse);
	//	_push(recipes_data, recipe);
	//}
	
	//file_text_close(file);
	//_log("Recipes DB entries count:", array_length(recipes_data));
	//for (var _i = 0; _i < array_length(recipes_data); _i++)
	//	_log(recipes_data[_i]);
}

function LoadDialogues() {
	dialogues = load_database_to_map("dialogues.txt", "dialogue_id");
	
	//_log("Dialogues DB size: ", ds_map_size(dialogues));
	//var _map_keys = ds_map_keys_to_array(dialogues);
	//for (var _i = 0; _i < array_length(_map_keys); _i++) {
	//	_log("Key ", _map_keys[_i]);
	//	_log("Value ", dialogues[? _map_keys[_i]]);
	//}
	
	dialogues_requirements = load_database_to_map("dialoguesRequirements.txt", "dialogue_id");
}

function LoadLocTexts(_loc) {
	var filename = "texts_" + _loc + ".txt";
	localized_texts = load_texts_database(filename);
	
	//_log("Texts DB size: ", ds_map_size(localized_texts));
	//var _map_keys = ds_map_keys_to_array(localized_texts);
	//for (var _i = 0; _i < array_length(_map_keys); _i++) {
		//_log("Key ", _map_keys[_i]);
		//_log("Nb texts: ", array_length(result[? _map_keys[_i]]));
	//	for (var _j = 0; _j < array_length(result[? _map_keys[_i]]); _j++) {
	//		var _to_log = string("Text {0}:", _j);
	//		_log(_to_log, result[? _map_keys[_i]][_j]);
	//	}
		
	//}
}

function LoadQuests() {
	quests = load_database_to_map("quests.txt", "quest_id");
}