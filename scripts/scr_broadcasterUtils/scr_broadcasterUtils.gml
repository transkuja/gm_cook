
function BindEvent(_event_holder, _to_bind, _subscribee) {
	if (_event_holder != noone) {
		_subscribee = Subscriber( _to_bind).watch(_event_holder);
	}
	else {
		var _broadcast = Broadcast(_to_bind);
		_event_holder = _broadcast;
	}
	
	return _event_holder;
}


function BindEventToInput(_input_name, _input_event, _to_bind, _scope = undefined) {
	var _binding = global.input_bindings[$ _input_name];
	
	if (_binding == undefined)
	{
		_binding = {};
		_binding[$ "pressed_event"] = Broadcast();
		_binding[$ "released_event"] = Broadcast();
		_binding[$ "down_event"] = Broadcast();
	}
	
	var _subscribee = noone;
	if (_input_event == INPUT_EVENTS.PRESSED)
		_subscribee = Subscriber( _to_bind).watch(_binding.pressed_event);
	else if (_input_event == INPUT_EVENTS.RELEASED)
		_subscribee = Subscriber( _to_bind).watch(_binding.released_event);
	else if (_input_event == INPUT_EVENTS.DOWN)
		_subscribee = Subscriber( _to_bind).watch(_binding.down_event);
		
	if (_subscribee == noone)
		_log("SUBSCRIBER NULL");
		
	global.input_bindings[$ _input_name] = _binding;
	if (_contains(global.input_bindings_keys, _input_name) == false)
	{
		_push(global.input_bindings_keys, _input_name);
	}
	
	return _subscribee;
}