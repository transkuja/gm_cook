draw_self();

if (draw_debug)
{
	if (instance_exists(inst_player) && is_magnetized)
		draw_circle_colour(inst_player.x,inst_player.y, end_radius, c_aqua, c_aqua, true); 
}