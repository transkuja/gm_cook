/// @description Insert description here
// You can write your code in this editor
draw_self();

if (progress > 0)
{
    var _draw_xy = WorldToGUI(x, y);
	//draw_sprite(phgen_rectangle(image_xscale * sprite_width, image_yscale * sprite_height, fill_color, 0, c_white, 0,0), 0, _draw_xy[0], _draw_xy[1]);
	
	var pb_content_w = (sprite_width - 2*margin_sides) * progress;
	var pb_content_h = sprite_height - 2*margin_top_bottom;
    
	if (pb_content_w <= 0.0 || pb_content_h <= 0.0)
        return;
    
    draw_sprite(
        phgen_rectangle(
            pb_content_w, 
            pb_content_h, 
            fill_color, 
            0, c_white, 0, 0), 0, 
            _draw_xy[0] + margin_sides, 
            _draw_xy[1] + margin_top_bottom);
}