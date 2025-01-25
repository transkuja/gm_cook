/// @description Insert description here
// You can write your code in this editor
depth = -10000;

is_enabled = true;

show = function() {
	is_enabled = true;
}

hide = function() {
	is_enabled = false;
}

global.on_should_hide_exit_cross = hide;
global.on_should_show_exit_cross = show;

