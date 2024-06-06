// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function CreateRecipesDB(){
	var recipes = new Recipe(
		"result", 
		["banana", "apple"], 
		[new RecipeStep(["banana"], PREPARATION_TYPE.CHOP),
			new RecipeStep(["chopped_banana", "apple"], PREPARATION_TYPE.ASSEMBLE)]);
	
	var _json_string = json_stringify(recipes, true);
	
	var file;
	file = file_text_open_write(
		working_directory + "recipes.txt");
	
	if (file == -1)
		_log("File could not be created");
		
	file_text_write_string(file, _json_string);
	file_text_close(file);
	
	_log("Database created at", working_directory);
	
	_log(_json_string);
}