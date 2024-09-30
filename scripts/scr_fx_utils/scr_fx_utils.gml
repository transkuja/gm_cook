// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SpawnFx(_to_spawn, _duration, _x, _y){
	fx_handler = instance_create_layer(x,y, "Instances", obj_fx_handler);
	fx_handler.StartFx(_to_spawn, _duration, _x, _y);
}