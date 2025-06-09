global.ui_main_hud_layer_name = "MainHUD";
global.ui_xp_bar_layer_name = "XpBarLayer";
global.ui_money_layer_name = "MoneyLayer";

function GuiInit() {
    for (var i = 0; i < instance_number(obj_gui_text); ++i;)
    {
        var _cur_instance = instance_find(obj_gui_text,i);
        if (instance_exists(_cur_instance))
            _cur_instance.GuiInit();
    }
    
    layer_set_visible(global.ui_main_hud_layer_name, true);
    layer_set_visible(global.ui_xp_bar_layer_name, false);
    
    if (room == rm_mainMenu)
        layer_set_visible(global.ui_money_layer_name, false);
    else {
    	layer_set_visible(global.ui_money_layer_name, true);
    }
}
