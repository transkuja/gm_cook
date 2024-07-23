// Destroy textbox
global.player_control = true;

if (on_dialogue_close != noone) 
	on_dialogue_close.dispatch();
	
instance_destroy();