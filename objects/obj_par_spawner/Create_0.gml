event_inherited();

spawned_instance = noone;

function Spawn() {
	
	if (to_spawn == noone || to_spawn == undefined) return;
	
	if (!layer_exists("Instances"))
		layer_create(0,"Instances");
		
	instance_create_layer(x, y, "Instances", to_spawn);
	
	if (auto_respawn) { alarm[0] = spawn_cooldown * game_get_speed(gamespeed_fps); }
}

function Interact() {
	alarm[0] = -1;
	Spawn();
}

if (auto_spawn) {
	alarm[0] = spawn_cooldown * game_get_speed(gamespeed_fps);
}