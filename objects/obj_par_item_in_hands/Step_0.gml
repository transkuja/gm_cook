
//if (is_dropped && !instance_exists(move_target))
//{
//	depth = -y;
//}

//else
//{
//	if (instance_exists(holder))
//		depth = holder.depth - 10;
//}

// TODO: remove from STEP
if (shader_enabled) {
	var layer_id = layer_get_id("Outline_Instance");
	layer_add_instance(layer_id, self);
}
else
{
	var layer_id = layer_get_id(initial_layer);
	layer_add_instance(layer_id, self);
}