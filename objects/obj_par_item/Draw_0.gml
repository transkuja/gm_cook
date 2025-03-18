draw_self();

if (draw_debug)
{
	var _player = TryGetGlobalInstance(GLOBAL_INSTANCES.PLAYER);
	if (instance_exists(_player) && is_magnetized)
		draw_circle_colour(_player.x,_player.y+target_offset_y, end_radius, c_aqua, c_aqua, true); 
}
