/// @description Destroy

// Destroy textbox
global.player_control++;

if (on_popup_close != noone) 
	on_popup_close.dispatch();
	
instance_destroy();