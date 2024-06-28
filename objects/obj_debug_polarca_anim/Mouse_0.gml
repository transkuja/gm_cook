if collision_point(mouse_x, mouse_y, id, true, false) { //Arguments are (x, y, obj, prec, notme)
	if (is_scale)
		PlayScaleAnimation();
	
	if (is_translate)
		PlayTranslateAnimation();
}