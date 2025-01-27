/// @description Insert description here
// You can write your code in this editor

counter = "20/20";

count = 0;

function Initialize() {
	var _save_manager = save_get_manager();
	if (is_undefined(_save_manager))
		return;
		
	var recipes_unlocked = _save_manager.get_all_key_containing("_unlocked");
	count = array_length(recipes_unlocked);
	
	counter = string(count) + "/20";
	
	alarm[0] = seconds(0.5);
}

function Bump() {
	count++;
	counter = string(count) + "/20";
}