hovering_last_frame = false;
hovering = false;
clicked = false;

on_clicked_event = noone;
on_clicked = function() {
}

on_click_param = {};

function UpdateVisual() {
	if (clicked) 
	{
		image_index = 2;
	} 
	else if (hovering) 
	{
		image_index = 1;
	} 
	else 
	{
		image_index = 0;
	}
}