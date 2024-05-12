if !is_enabled { return; }

var x_mouse = device_mouse_x_to_gui(0);
var y_mouse = device_mouse_y_to_gui(0);
var text_value = string(x_mouse) + "," + string(y_mouse);

draw_text_color(x_mouse + 5, y_mouse - 5, text_value, c_green, c_green, c_green, c_green, 1);