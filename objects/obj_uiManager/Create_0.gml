global.ui_main_hud_layer_name = "MainHUD";
global.ui_xp_bar_layer_name = "XpBarLayer";
global.ui_money_layer_name = "MoneyLayer";

layer_set_visible(global.ui_main_hud_layer_name, true);
layer_set_visible(global.ui_xp_bar_layer_name, false);
layer_set_visible(global.ui_money_layer_name, false);

function GuiInit() {
    for (var i = 0; i < instance_number(obj_gui_level); ++i;)
    {
        var _cur_instance = instance_find(obj_gui_level,i);
        if (instance_exists(_cur_instance))
            _cur_instance.GuiInit();
    }    
}
