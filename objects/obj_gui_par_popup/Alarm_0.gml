// Destroy textbox
global.player_control = true;

if (on_popup_close != noone) 
	on_popup_close.dispatch();
	
instance_destroy();