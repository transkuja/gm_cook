
function AssembleCombo(_ids = [], _result_id = "none") constructor {
	ids = _ids;
	result_id = _result_id;
	
	function IsCombo(_in_ids = []) {
		if (array_length(ids) !=  array_length(_in_ids))
			return "none";
		
		for (var i = 0; i < array_length(_in_ids); i++)
		{
			if (!_contains(ids, _in_ids[i]))
				return "none";
		}
		
		return result_id;
	}
}

function RecipeStep(_step_components = [], _preparation_type = PREPARATION_TYPE.ASSEMBLE) constructor {
	step_components = _step_components;
	preparation_type = _preparation_type;
}

function Recipe(_result_id = "none", _raw_components = [], _steps = []) constructor {
	result_id = _result_id;
	raw_components = _raw_components;
	recipe_steps = _steps;
	
	function IsValidRecipe(_components) {
		if (array_length(_components) !=  array_length(raw_components))
			return "none";
		
		for (var i = 0; i < array_length(_components); i++)
		{
			if (!_contains(raw_components, _components[i]))
				return "none";
		}
		
		return result_id;
	}
}