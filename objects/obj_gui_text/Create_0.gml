/// @description Insert description here
// You can write your code in this editor

current_level = 1;
anim_scale_x = 0;
anim_scale_y = 0;

function GuiInit() {
    
}

function DrawTextShadow() {
    //draw_set_font(font_qte_score);
    //draw_text(x, y, "Lvl " + current_level);
    var _draw_xy = WorldToGUI(x, y);
    
    draw_set_halign(horizontal_align);
    draw_set_valign(vertical_align);
    
    if (max_width > 0)
    {
        draw_text_shadow_ext_transformed(
            _draw_xy[0], 
            _draw_xy[1], 
            text_to_draw,
            text_font, 
            shadow_size,
            shadow_color, 
            text_color,
            max_width, 
            base_scale_x + anim_scale_x,
            base_scale_y + anim_scale_y, 
            0
        );
    }
    else { 
        draw_text_shadow_transformed(
            _draw_xy[0], 
            _draw_xy[1], 
            text_to_draw,
            text_font, 
            shadow_size,
            shadow_color, 
            text_color,
            base_scale_x + anim_scale_x,
            base_scale_y + anim_scale_y, 
            0
        );
    }
}

function DrawText() {
    var _draw_xy = WorldToGUI(x, y);
    
    draw_set_font(text_font);
    draw_set_colour(text_color);
    
    draw_set_halign(horizontal_align);
    draw_set_valign(vertical_align);
    
    if (max_width > 0)
    {
        draw_text_ext_transformed(
            _draw_xy[0], 
            _draw_xy[1], 
            text_to_draw,
            -1,
            max_width, 
            base_scale_x + anim_scale_x,
            base_scale_y + anim_scale_y, 
            0
        );
    }
    else {
        
        draw_text_transformed(            
            _draw_xy[0], 
            _draw_xy[1], 
            text_to_draw,
            base_scale_x + anim_scale_x,
            base_scale_y + anim_scale_y, 
            0
        );
    }
}

function PlayLevelUpAnim() {
    var _sa_x = new polarca_animation("txt_scale_x", 0.2, ac_bump_scale_up_maintained, 0, anim_speed);
	var _sa_y = new polarca_animation("txt_scale_y", 0.2, ac_bump_scale_up_maintained, 0, anim_speed);
	polarca_animation_start([_sa_x, _sa_y]);
}