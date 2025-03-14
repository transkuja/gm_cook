filepath = "Datas/";
assemble_combos = [];
marmite_combos = [];
mixer_combos = [];
stir_combos = [];
pan_combos = [];
hoven_combos = [];

recipes_data = [];
dialogues = ds_map_create();
localized_texts = ds_map_create();
quests = ds_map_create();
dialogues_requirements = ds_map_create();
	
use_txt_not_ini = true;

global.database_manager = self;

function LoadCombosFromFile(_filename) {
	if (!use_txt_not_ini)
	{
		zip_unzip(filepath + _filename + ".ini", working_directory + "extracted/");
		return load_database(working_directory + "extracted/" + _filename + ".txt");
	}
	else
	{
		return load_database(filepath + _filename + ".txt");
	}
}

function LoadAssembleCombos() {
	assemble_combos = LoadCombosFromFile("assemble_combos");
	marmite_combos = LoadCombosFromFile("marmite_combos");
	mixer_combos = LoadCombosFromFile("mixer_combos");
	stir_combos = LoadCombosFromFile("stir_combos");
	pan_combos = LoadCombosFromFile("pan_combos");
	hoven_combos = LoadCombosFromFile("hoven_combos");
}

function LoadRecipes() {
	recipes_data = load_database(filepath + "recipes.txt");
	
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
	dialogues = load_database_to_map(filepath + "dialogues.txt", "dialogue_id");
	
	//_log("Dialogues DB size: ", ds_map_size(dialogues));
	//var _map_keys = ds_map_keys_to_array(dialogues);
	//for (var _i = 0; _i < array_length(_map_keys); _i++) {
	//	_log("Key ", _map_keys[_i]);
	//	_log("Value ", dialogues[? _map_keys[_i]]);
	//}
	
	dialogues_requirements = load_database_to_map(filepath + "dialoguesRequirements.txt", "dialogue_id");
}

function LoadLocTexts(_loc) {
	zip_unzip(filepath + "texts_fr.ini", working_directory + "extracted/");
		
	var filename = "texts_" + _loc + ".txt";
	
	localized_texts = load_texts_database(working_directory + "extracted/" + filename);
	
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
	quests = load_database_to_map(filepath + "quests.txt", "quest_id");
}

function GetDatabaseFromPreparationType(_preparation_type)
{
	switch (_preparation_type)
	{
		//case PREPARATION_TYPE.CHOP:
		//	return chop;
		case PREPARATION_TYPE.PAN_COOK:
			return pan_combos;
		case PREPARATION_TYPE.HOVEN_COOK:
			return hoven_combos;
		case PREPARATION_TYPE.STIR:
			return stir_combos;
		case PREPARATION_TYPE.MIX:
			return mixer_combos;
		case PREPARATION_TYPE.ASSEMBLE:
			return assemble_combos;
		default:
			return [];
	}
}

LoadAssembleCombos();
LoadRecipes();

LoadDialogues();
LoadLocTexts("fr");

LoadQuests();
