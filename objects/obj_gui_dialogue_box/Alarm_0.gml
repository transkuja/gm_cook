// Destroy textbox
global.player_control++;

if (on_dialogue_close != noone) 
	on_dialogue_close.dispatch();
	
instance_destroy();