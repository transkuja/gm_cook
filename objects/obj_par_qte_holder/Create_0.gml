
function OnInputPressed() {
	
}

function OnInputValidated() {
	
}

function Finish() {
	if (instance_exists(inst_player)) {
		with (inst_player) {
			inst_player.cooking_input_object = noone;
		}
	}
	
	instance_destroy();
}