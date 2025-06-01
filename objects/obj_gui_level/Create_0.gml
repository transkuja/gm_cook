/// @description Insert description here
// You can write your code in this editor

event_inherited();

current_level = 1;

function UpdateText() {
    current_level = save_data_get("level", 1);
    text_to_draw = "Lvl " + string(current_level);
}

function GuiInit() {
    var _subscribee = BindEvent(global.on_lvl_up, function() { PlayLevelUpAnim(); });
    UpdateText();
}

on_play_anim = function () { UpdateText(); }