function scr_magnetMove(_inst, _target, _dt_, _magnetSpeed = 600, _endRadius = 20) {
	if (_inst != noone && _inst != undefined && _target != noone && _target != undefined)
	{
		var toTargetVectorX = _target.x - _inst.x;
		var toTargetVectorY = _target.y - _inst.y;
		
		var sqrDist = VectorSqrLength(toTargetVectorX, toTargetVectorY);
		if (sqrDist < _endRadius * _endRadius)
		{
			return true;
		}
		
		var dir = NormalizeVector(toTargetVectorX, toTargetVectorY);
		_inst.x += _dir[0] * _dt * _magnetSpeed;
		_inst.y += _dir[1] * _dt * _magnetSpeed;
		
	}
	
	return false;
}