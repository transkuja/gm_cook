
if (is_magnetized && lerp_param < 1)
{
	if (!instance_exists(inst_player)) {
		is_magnetized = false;
		return;
	}
	
	var _toTargetVectorX = inst_player.x - x;
	var _toTargetVectorY = inst_player.y - y;
		
	var _sqrDist = VectorSqrLength(_toTargetVectorX, _toTargetVectorY);
	if (_sqrDist < end_radius * end_radius)
	{
		Collect();
		return;
	}
		
	//var _dir = NormalizeVector(toTargetVectorX, toTargetVectorY);
	var _dt = delta_time * 0.000001;
	lerp_param += _dt * magnet_speed;
	lerp_param = min(lerp_param, 1);
	
	x = EaseInBack(lerp_param, lerp_origin_x, inst_player.x - lerp_origin_x, 1);
	y = EaseInBack(lerp_param,lerp_origin_y, inst_player.y - lerp_origin_y + target_offset_y, 1);
	
	if (lerp_param >= 1)
		Collect();
}


depth = -y;