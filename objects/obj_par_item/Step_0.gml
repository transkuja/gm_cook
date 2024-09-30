
if (is_magnetized && lerp_param < 1)
{
	if (!instance_exists(player_ref)) {
		is_magnetized = false;
		return;
	}
	
	var _toTargetVectorX = player_ref.x - x;
	var _toTargetVectorY = player_ref.y - y;
		
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
	
	x = EaseInBack(lerp_param, lerp_origin_x, player_ref.x - lerp_origin_x, 1);
	y = EaseInBack(lerp_param,lerp_origin_y, player_ref.y - lerp_origin_y + target_offset_y, 1);
	
	if (lerp_param >= 1)
		Collect();
}


depth = -y;