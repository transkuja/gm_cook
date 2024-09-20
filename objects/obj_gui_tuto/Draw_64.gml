if (tuto_enabled) {
	draw_sprite_ext(spr_inventory_slot_bg, 0, x - 160, y - 170, 4.7, 1, 0, c_gray, 0.5);
	draw_set_font(font_textbox);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	draw_text_transformed(x - 150, y - 60, "Espace: Intéragir/Cuisiner\nClic Droit: Prendre/Remettre dans l'inventaire\nClic Gauche: Déposer/Ramasser un objet", 0.9, 0.9, 0);
}