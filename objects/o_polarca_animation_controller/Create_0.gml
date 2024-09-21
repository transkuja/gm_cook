animations = []
len = 0
objects = []
pong = false;

init = function(){
	len = array_length_1d(animations)

	for (var i = 0; i < len; ++i) {		
		animations[i].update_initial_value()
	    objects[i] = {
			position: 0,
			animation: animations[i]
		}
	}

}

on_animation_finished = noone;
is_looping = false;
is_ping_pong = false;
