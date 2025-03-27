
function BindEvent(_event_holder, _to_bind) {
	if (_event_holder != noone) {
		var _subscriber = Subscriber( _to_bind).watch(_event_holder);
	}
	else {
		var _broadcast = Broadcast(_to_bind);
		_event_holder = _broadcast;
	}
	
	return _event_holder;
}


function BindEventToInput(_input_name, _input_event, _to_bind) {
	var _binding = global.input_bindings[$ _input_name];
	
	if (_binding == undefined)
	{
		_binding = {};
		_binding[$ "pressed_event"] = noone;
		_binding[$ "released_event"] = noone;
		_binding[$ "down_event"] = noone;
	}
	
	if (_input_event == INPUT_EVENTS.PRESSED)
		_binding.pressed_event = BindEvent(_binding.pressed_event, _to_bind);
	else if (_input_event == INPUT_EVENTS.RELEASED)
		_binding.released_event = BindEvent(_binding.released_event, _to_bind);
	else if (_input_event == INPUT_EVENTS.DOWN)
		_binding.down_event = BindEvent(_binding.down_event, _to_bind);
		
	global.input_bindings[$ _input_name] = _binding;
	if (_contains(global.input_bindings_keys, _input_name) == false)
	{
		_push(global.input_bindings_keys, _input_name);
	}
}