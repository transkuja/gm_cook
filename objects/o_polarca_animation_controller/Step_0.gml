var _index = 0
var _should_destroy = true

repeat(len){
	
	//setup
	var _obj = objects[_index]
	var _pos = _obj.position
	var _animation = _obj.animation
		
	//work
	with(_animation){
		_pos+=d(curve_speed)
		instance_update(_pos)
	}
	
	//endup
	_pos = clamp(_pos,0,1)
	_obj.position = _pos
	_index++
	
	//check if is not over
	if(_pos<1) _should_destroy = false
}

if(_should_destroy){
	if (on_animation_finished != noone) 
		on_animation_finished.dispatch();
		
	show_debug_message("arrp -> animationsended. killing controller " +string(id))
	instance_destroy()
}




