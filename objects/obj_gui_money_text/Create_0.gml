/// @description Insert description here
// You can write your code in this editor

event_inherited();

current_money = 0;

function UpdateText() {
    current_money = save_data_get("money", 0);
    text_to_draw = string(current_money);
}

function Lol() {
    current_money = save_data_get("money", 0);
    text_to_draw = string(current_money);
}

function GuiInit() {
        _log("Gui init money text");
    var _subscribee = BindEvent(global.on_money_updated, function() { Lol(); });
    UpdateText();
}

on_play_anim = function () { UpdateText(); }