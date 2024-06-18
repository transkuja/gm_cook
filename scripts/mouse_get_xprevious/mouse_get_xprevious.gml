function mouse_get_xprevious(){
	var _mx = mouse_xprevious;
	mouse_xprevious = device_mouse_x(0);
	
	return _mx;
}