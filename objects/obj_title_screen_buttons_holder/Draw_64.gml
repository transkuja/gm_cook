
if (draw_credits) {
	draw_set_font(font_textbox);
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	draw_text_transformed(room_width - 160, room_height - 100, "Game & script: le vieux pote Antho\nSupport art: Océ la fan de babouins", 0.9, 0.9, 0);
	draw_text_ext_transformed(room_width - 160, room_height - 50, "Aucun dindon n'a été maltraité durant le développement", 35, 800, 0.65, 0.65, 0);
}