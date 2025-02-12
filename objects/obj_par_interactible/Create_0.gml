// Outline shader
handler=shader_get_uniform(shader_outline,"texture_Pixel")
handler_1=shader_get_uniform(shader_outline,"thickness_power")
handler_2=shader_get_uniform(shader_outline,"RGBA")

initial_layer = layer_get_name(layer);

function InRangeFeedback() {
	var layer_id = layer_get_id("Outline_Instance");
	layer_add_instance(layer_id, self);
}

function ResetFeedback() {
	var layer_id = layer_get_id(initial_layer);
	layer_add_instance(layer_id, self);
}

function Interact(_interactInstigator) constructor {
	
}

function ItemInteractio(_interactInstigator) constructor {
	
}