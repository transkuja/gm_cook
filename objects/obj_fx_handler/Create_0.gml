/// @description Insert description here
// You can write your code in this editor
part_system_inst = noone;

function StartFx(_to_spawn, _duration, _x, _y) {
	part_system_inst = part_system_create(_to_spawn);
	if (part_system_exists(part_system_inst)) {
		part_system_layer(part_system_inst, layer_get_id("FX"));
		part_system_position(part_system_inst, _x, _y);
		
		alarm[0] = seconds(_duration);
	}
	else
		instance_destroy();
}