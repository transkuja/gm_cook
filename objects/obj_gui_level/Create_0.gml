/// @description Insert description here
// You can write your code in this editor

current_level = 1;
anim_speed = 0.03;
txt_scale_x = 0;
txt_scale_y = 0;

function GuiInit() {
    var _subscribee = BindEvent(global.on_lvl_up, function() { PlayLevelUpAnim(); });
}

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
        0.75 + txt_scale_x,
        0.75 + txt_scale_y, 
        0
    );
}

function PlayLevelUpAnim() {
    var _sa_x = new polarca_animation("txt_scale_x", 0.2, ac_bump_scale_up_maintained, 0, anim_speed);
	var _sa_y = new polarca_animation("txt_scale_y", 0.2, ac_bump_scale_up_maintained, 0, anim_speed);
	polarca_animation_start([_sa_x, _sa_y]);
}