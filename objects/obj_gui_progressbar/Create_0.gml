progress = 0;
delta_progress = 0;

target_progress = 0;

on_value_changed = function(_value) { };
on_max_reached = function() { };

function SetProgress(_value, _max) {
    if (_max == 0)
        return;
    
    delta_progress = (_value / _max) - progress; // weird
    
    target_progress = _value;
    
    if (on_value_changed != noone)
        on_value_changed(progress);
}

function AddProgress(_value, _max) {
    if (_max == 0)
        return;
    
    var _to_add = _value / _max;
    delta_progress += _to_add;
    
    var _total_target_value = progress + delta_progress;
    target_progress = _total_target_value - floor((_total_target_value));
    
    if (on_value_changed != noone)
        on_value_changed(progress);
}