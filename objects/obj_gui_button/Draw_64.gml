/// @description Insert description here
// You can write your code in this editor
draw_self();

draw_set_font(font_button);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

var str_width = string_width(button_text);

if (str_width >= sprite_width - 25) {
	var width_ratio = (sprite_width - 25) / str_width;
	var scale_value = clamp(width_ratio, 0.5, 1);
	draw_text_ext_transformed(x, y - 1, button_text, (sprite_height - 20) * 0.5, 1000, scale_value, scale_value, 0);
}
else
	draw_text(x, y, button_text);