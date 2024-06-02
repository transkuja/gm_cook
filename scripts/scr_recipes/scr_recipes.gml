
function Recipe() constructor{
	var result_id = "none";
	var components = [];
	
	function IsValidRecipe(_components) {
		if (array_length(_components) !=  array_length(components))
			return "none";
		
		for (var i = 0; i < array_length(_components); i++)
		{
			if (!_contains(components, _components[i]))
				return "none";
		}
		
		return result_id;
	}
}