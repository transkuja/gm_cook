/// @description Adds a shadow to text.
/// @function draw_text_shadow(x, y, string, font, shadow_size, shadow_colour, text_colour);
/// @param x
/// @param y
/// @param string
/// @param font
/// @param shadow_size
/// @param shadow_color
/// @param text_color
function draw_text_shadow(){
    var _x, _y, _string, _font, _shadow_size, _shadow_colour, _text_colour;
    _x = argument[0];
    _y = argument[1];
    _string = argument[2];
    _font = argument[3];
    _shadow_size = argument[4];
    _shadow_colour = argument[5];
    _text_colour = argument[6];
    draw_set_font(_font);
    draw_set_colour(_shadow_colour);
    draw_text((_x + _shadow_size), (_y + _shadow_size), string(_string));
    draw_set_colour(_text_colour);
    draw_text(_x, _y, string(_string));
}

/// @description Adds a shadow to text.
/// @function draw_text_shadow_transformed(x, y, string, font, shadow_size, shadow_colour, text_colour, xscale, yscale, angle);
/// @param x
/// @param y
/// @param string
/// @param font
/// @param shadow_size
/// @param shadow_color
/// @param text_color
/// @param xscale
/// @param yscale
/// @param angle
function draw_text_shadow_transformed(){
    var _x, _y, _string, _font, _shadow_size, _shadow_colour, _text_colour, _xscale, _yscale, _angle;
    _x = argument[0];
    _y = argument[1];
    _string = argument[2];
    _font = argument[3];
    _shadow_size = argument[4];
    _shadow_colour = argument[5];
    _text_colour = argument[6];
    _xscale = argument[7];
    _yscale = argument[8];
    _angle = argument[9];
    draw_set_font(_font);
    draw_set_colour(_shadow_colour);
    draw_text_transformed((_x + _shadow_size), (_y + _shadow_size), string(_string), _xscale, _yscale, _angle);
    draw_set_colour(_text_colour);
    draw_text_transformed(_x, _y, string(_string), _xscale, _yscale, _angle);
}

/// @description Adds a shadow to text.
/// @function draw_text_shadow_transformed(x, y, string, font, shadow_size, shadow_colour, text_colour, width);
/// @param x
/// @param y
/// @param string
/// @param font
/// @param shadow_size
/// @param shadow_color
/// @param text_color
/// @param width
function draw_text_shadow_ext(){
    var _x, _y, _string, _font, _shadow_size, _shadow_colour, _text_colour, _width;
    _x = argument[0];
    _y = argument[1];
    _string = argument[2];
    _font = argument[3];
    _shadow_size = argument[4];
    _shadow_colour = argument[5];
    _text_colour = argument[6];
    _width = argument[7];
    draw_set_font(_font);
    draw_set_colour(_shadow_colour);
    draw_text_ext((_x + _shadow_size), (_y + _shadow_size), string(_string), -1, _width);
    draw_set_colour(_text_colour);
    draw_text_ext(_x, _y, string(_string), -1, _width);
}

/// @description Adds a shadow to text.
/// @function draw_text_shadow_transformed(x, y, string, font, shadow_size, shadow_colour, text_colour, width, xscale, yscale, angle);
/// @param x
/// @param y
/// @param string
/// @param font
/// @param shadow_size
/// @param shadow_color
/// @param text_color
/// @param width
/// @param xscale
/// @param yscale
/// @param angle
function draw_text_shadow_ext_transformed(){
    var _x, _y, _string, _font, _shadow_size, _shadow_colour, _text_colour, _width, _xscale, _yscale, _angle;
    _x = argument[0];
    _y = argument[1];
    _string = argument[2];
    _font = argument[3];
    _shadow_size = argument[4];
    _shadow_colour = argument[5];
    _text_colour = argument[6];
    _width = argument[7];
    _xscale = argument[8];
    _yscale = argument[9];
    _angle = argument[10];
    draw_set_font(_font);
    draw_set_colour(_shadow_colour);
    draw_text_ext_transformed((_x + _shadow_size), (_y + _shadow_size), string(_string), -1, _width, _xscale, _yscale, _angle);
    draw_set_colour(_text_colour);
    draw_text_ext_transformed(_x, _y, string(_string), -1, _width, _xscale, _yscale, _angle);
}