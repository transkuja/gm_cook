/// @description this is a generic, base class for all object states, a concrete object state must be inherited from it
/// @param {Id.Instance}     _object    The unique instance ID value of the instance to track state.
/// @param {Struct}     _args      optional struct with params available in state instance
function BaseState(_object, _args = {}) constructor {
    name = ""
    previous_state_name = ""
    object = _object
    args = _args
 
    enter_state = function() { }
 
    process_begin_step = function() { }
 
    process_step = function() { }
 
    process_end_step = function() { }
 
    process_draw_begin = function() { }
 
    process_draw = function() { }
 
    exit_state = function() { }
 
    animation_end = function() { }
 
    transition_to = function(_new_state) {
        _new_state.previous_state_name = name
        object.current_state.exit_state()
        _new_state.enter_state()
        object.current_state = _new_state
        show_debug_message(_new_state.name)
    }
}

