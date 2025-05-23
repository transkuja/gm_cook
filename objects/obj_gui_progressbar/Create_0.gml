progress = 0;
delta_progress = 0;

on_value_changed = function(_value) { };
on_max_reached = function() { };

function SetProgress(_value, _max) {
    if (_max == 0)
        return;
    
    delta_progress = (_value / _max) - progress; // weird
    
    if (on_value_changed != noone)
        on_value_changed(progress);
}

function AddProgress(_value, _max) {
    if (_max == 0)
        return;
    
    delta_progress += (_value / _max);
    
    if (on_value_changed != noone)
        on_value_changed(progress);
}