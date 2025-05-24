/// @description Insert description here
// You can write your code in this editor

current_level = 1;

function DrawText() {
    current_level = save_data_get("level", 1);
    //draw_set_font(font_qte_score);
    //draw_text(x, y, "Lvl " + current_level);
    var _draw_xy = WorldToGUI(x, y);
    draw_text_shadow_transformed(
        _draw_xy[0], 
        _draw_xy[1], 
        "Lvl " + string(current_level), 
        font_qte_score, 
        1, 
        c_black, 
        c_white, 
        0.75,
        0.75, 
        0
    );
}

function PlayLevelUpAnim() {
    
}