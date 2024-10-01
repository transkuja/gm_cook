
if (is_dropped)
{

	
	depth = -y;
}

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