function mouse_get_yprevious(){
	var _my = mouse_xprevious;
	mouse_yprevious = device_mouse_y(0);
	
	return _my;
}