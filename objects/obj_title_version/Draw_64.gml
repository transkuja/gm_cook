// Draw Text
draw_set_font(font_textbox);
draw_set_halign(fa_right);
draw_set_valign(fa_middle)

var _text_to_draw = phase + "_" 
	+ string(current_day) + "." 
	+ string(current_month) + "." 
	+ string(current_year);
	
draw_text_ext_transformed_color(x,y, _text_to_draw, 
	0, 1000, // sep, width
	0.8, 0.8, // scale
	0, // angle
	color, color, color, color, 1); // color