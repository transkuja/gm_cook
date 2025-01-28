draw_self();

draw_set_font(fnt_recipe_counter);
draw_set_halign(fa_center);
draw_set_valign(fa_middle)

	
draw_text_ext_transformed_color(x + (sprite_width * 0.5), y + (sprite_height * 0.5), 
	counter, sprite_height * 0.5, sprite_width, 1 + anim_txt_scale_x,1 + anim_txt_scale_y,0,
	c_purple, c_purple, c_purple, c_purple, image_alpha);
	