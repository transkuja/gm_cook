event_inherited()

if (array_length(items_in_ids) > 0)
{
	for (var _i = 0; _i < array_length(items_in_ids); _i++)
	{
		var _draw_x = x + (_i * 100);
		var _draw_y = y - 100;
		draw_sprite(phgen_circle(32, c_white, 2, c_black), 0, _draw_x - 32, _draw_y - 32);
		draw_sprite_ext(
			GetItemSprite(items_in_ids[_i]), 
			0, 
			_draw_x, _draw_y, 
			0.4, 0.4, 0, c_white, 1);
	}
}