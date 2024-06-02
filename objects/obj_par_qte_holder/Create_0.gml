on_qte_completed = noone;

function OnInputPressed() {
	
}

function OnInputValidated() {
	
}

function Finish() {
	if (on_qte_completed != noone) 
		on_qte_completed.dispatch();
		
	if (instance_exists(inst_player)) {
		with (inst_player) {
			inst_player.cooking_input_object = noone;
		}
	}
	
	instance_destroy();
}