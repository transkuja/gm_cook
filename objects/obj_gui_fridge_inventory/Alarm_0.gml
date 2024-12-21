/// @description Destroy

// Destroy textbox
global.player_control++;

if (on_menu_close != noone) 
	on_menu_close.dispatch();
	
instance_destroy();