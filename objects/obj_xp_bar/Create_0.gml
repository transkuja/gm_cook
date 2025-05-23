/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

on_max_reached = function() { OnLevelUp(); };

global.on_add_xp = function(_xp_added) {
    
    };


function OnValueChanged(_value) {
    // needed ?
}

function OnLevelUp() {
    
    // Tell GameState about level up
    if (global.on_lvl_up != noone)
        global.on_lvl_up(); 
}

function AddXp(_previous_xp, _xp) {
    layer_set_visible(global.ui_xp_bar_layer_name, true);
    AddProgress(_xp - _previous_xp, 100);
}