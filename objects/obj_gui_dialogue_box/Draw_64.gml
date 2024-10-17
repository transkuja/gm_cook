// Draw textbox
draw_self();

// Draw Text
draw_set_font(font_textbox);
draw_set_halign(fa_center);
draw_set_valign(fa_middle)
draw_text_ext_color(x,y, textToShow, lineHeight, textWidth, c_black, c_black, c_black, c_black, image_alpha);

// Draw talker box
draw_sprite(phgen_rectangle(talker_name_width, talker_name_height, c_white, 0, c_white, 0, 0), 0, draw_talker_x, draw_talker_y);

// Draw talker name
draw_text_ext_color(draw_talker_x + talker_name_width * 0.5,draw_talker_y + talker_name_height * 0.5, talker_name, lineHeight, textWidth, c_black, c_black, c_black, c_black, image_alpha);

if (show_extra_sprite)
	draw_sprite_ext(spr_op, 0, x, room_height * 0.5 - 175, 0.6, 0.6, 0,c_white, 1);