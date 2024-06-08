// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ScreenToWorld(_screen_x, _screen_y) {
	var _gui_x_normalised = _screen_x / display_get_gui_width();
	var _gui_y_normalised = _screen_y / display_get_gui_height();
	var _camera_x = _gui_x_normalised * camera_view_get_width(view_camera[0]);
	var _camera_y = _gui_y_normalised * camera_view_get_height(view_camera[0]);
	room_xpos = camera_view_get_x(view_camera[0]) + _camera_x;
	room_ypos = camera_view_get_y(view_camera[0]) + _camera_y;

	return [room_xpos, room_ypos];
}

function WorldToGUI(_world_x, _world_y) {

	var camera = view_camera[0];
	var gui_x = _world_x - camera_get_view_x(camera);
	var gui_y = _world_y - camera_get_view_y(camera);

	return [gui_x, gui_y];
}