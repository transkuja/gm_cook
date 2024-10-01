
function SetEffectOutline(_instance) {
	if (!layer_exists("Outline_Instance")) {
		//_outline_layer = layer_create(-100, "Outline_Instance");
		return;
	}
	
	layer_add_instance("Outline_Instance", _instance);

}

function RemoveEffectOutline(_instance, _previousLayer) {
	layer_add_instance(_previousLayer, _instance);
}