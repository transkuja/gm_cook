if !is_enabled { return; }

for (var i = 0; i < view_wport[0]; i += current_cell_size) {
	draw_line_color(i, 0, i, view_hport[0], c_gray, c_gray);
}

for (var j = 0; j < view_hport[0]; j += current_cell_size) {
	draw_line_color(0, j, view_wport[0], j, c_gray, c_gray);	
}