recipes_data = [];

function LoadRecipes() {
	file = file_text_open_read("recipes.txt");
	
	if (file == -1) {
		_log("Can't open Recipes file !");
		return;
	}
	
	while (!file_text_eof(file)) {
		to_parse = file_text_readln(file);
		_log(to_parse);
		
		var recipe = json_parse(to_parse);
		_push(recipes_data, recipe);
	}
	
	file_text_close(file);
	_log("Recipes DB entries count:", array_length(recipes_data));
	for (var _i = 0; _i < array_length(recipes_data); _i++)
		_log(recipes_data[_i]);
}