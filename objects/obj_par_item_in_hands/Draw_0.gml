//if (shader_enabled) {
//	shader_set(shader_outline)
//	var tex=sprite_get_texture(sprite_index,image_index)
//	var tex_w=texture_get_texel_width(tex)
//	var tex_h=texture_get_texel_height(tex)
//	shader_set_uniform_f(handler,tex_w,tex_h)
//	shader_set_uniform_f(handler_1,4)//line thickness
//	shader_set_uniform_f(handler_2,1,1,1,1.0)//rgba

//	draw_self()

//	shader_reset()
//}
//else
//{
//	
//}

//if (is_dropped && instance_exists(move_target))
//	return;

draw_self();