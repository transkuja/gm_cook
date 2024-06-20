// Inherit the parent event
event_inherited();

function OnInputPressed() {
	mash_count--;
	OnInputValidated();
}

function OnInputValidated() {
	if (mash_count <= 0)
		Finish();
}

progress_bar_width = 100;
progress_bar_height = 25;
progress_bar_outline = 2.5;

function GetProgressRatio() {
	return 1;
}

function DrawProgress() {
	var _draw_xy = WorldToGUI(x, y - 85);
	draw_sprite(phgen_rectangle(progress_bar_width, progress_bar_height, c_white, 0, c_white, progress_bar_width * 0.5, progress_bar_height * 0.5), 0, _draw_xy[0], _draw_xy[1]);
	
	var pb_content_w = (progress_bar_width - 2*progress_bar_outline) * GetProgressRatio();
	var pb_content_h = progress_bar_height - 2*progress_bar_outline;
	if (pb_content_w > 0 && pb_content_h > 0)
		draw_sprite(phgen_rectangle(pb_content_w, pb_content_h, c_green, 0, c_white, 0, progress_bar_height * 0.5), 0, _draw_xy[0] - progress_bar_width * 0.5 + progress_bar_outline, _draw_xy[1] + progress_bar_outline);
}

function DrawBackground() {
	//var _draw_xy = WorldToGUI(x, y - 85);
	//var _w = progress_bar_width + 100;
	//var _h = progress_bar_height + 20;
	//draw_sprite(phgen_rectangle(_w, _h, c_gray, 0, c_gray, _w * 0.5, _h * 0.5), 0, _draw_xy[0], _draw_xy[1]);
}
