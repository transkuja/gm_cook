
sprite_index = visual;

start_pos = [x,y]
start_scale = [image_xscale, image_yscale]

function ResetPos() {
	x = start_pos[0];
	y = start_pos[1];
}

function ResetScale() {
	image_xscale = start_scale[0];
	image_yscale = start_scale[1];
}

function PlayScaleAnimation() {
	_log("Start play scale animation");
	var sxa;
	var sya;
	
	var _broadcast = Broadcast(function() {
		_log("Animation scale finished");
		if (auto_reset)
			ResetScale();
	} );
		
	if (animcurve_exists(scale_curve_to_play_xy)) {
		var curve_data = animcurve_get(scale_curve_to_play_xy);
		if (array_length(curve_data.channels) == 0) {
			_log("No channel in scale xy animation");
			return;
		}
		
		sxa = new polarca_animation("image_xscale", scale_value_x ,scale_curve_to_play_xy,0,scale_move_speed_x);
		if (array_length(curve_data.channels) > 1) {
			sya = new polarca_animation("image_yscale", scale_value_y ,scale_curve_to_play_xy,1,scale_move_speed_y);
		}
		else {
			_log("Only one channel in scale xy animation, playing same anim on both axis");
			sya = new polarca_animation("image_yscale", scale_value_y ,scale_curve_to_play_xy,0,scale_move_speed_y);
		}
	
		polarca_animation_start([sxa, sya]).on_animation_finished = _broadcast;		
	} 
	else if (animcurve_exists(scale_curve_to_play_x)) {
		var curve_data = animcurve_get(scale_curve_to_play_x);
		if (array_length(curve_data.channels) > 0) {
			sxa = new polarca_animation("image_xscale", scale_value_x ,scale_curve_to_play_xy,0,scale_move_speed_x);
		
			polarca_animation_start([sxa]).on_animation_finished = _broadcast;
		}
		else {
			_log("Missing channel in scale x animation");
		}
	}
	else if (animcurve_exists(scale_curve_to_play_y)) {
		var curve_data = animcurve_get(scale_curve_to_play_y);
		if (array_length(curve_data.channels) > 0) {
			sya = new polarca_animation("image_yscale", scale_value_y ,scale_curve_to_play_xy,0,scale_move_speed_y);
		
			polarca_animation_start([sya]).on_animation_finished = _broadcast;
		}
		else {
			_log("Missing channel in scale y animation");
		}
	}
	else {
		_log("No valid scale animation");
	}
	
}

function PlayTranslateAnimation() {
	_log("Start play translate animation");
	
	if (animcurve_exists(trans_curve_to_play)) {
		var curve_data = animcurve_get(trans_curve_to_play);
		if (array_length(curve_data.channels) > 0) {
			tra = new polarca_animation("x", x + translate_distance ,trans_curve_to_play,0,scale_move_speed_x);
		
			var _broadcast = Broadcast(function() {
				_log("Animation translate finished");
				if (auto_reset)
					ResetPos()();
			} );
		
			polarca_animation_start([tra]).on_animation_finished = _broadcast;
		}
		else {
			_log("Missing channel in translate animation");
		}
	}
	else {
		_log("Invalid translate animation");
	}
}