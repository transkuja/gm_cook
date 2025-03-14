/// @description Insert description here
// You can write your code in this editor

function LoadHighPriority() {
	// Delta
	delta_init();
	instance_create_layer(x,y, "ControlObjects", obj_delta);

	// Prio 0: Global var
	//GlobalEvents
	instance_create_layer(x,y, "ControlObjects", obj_global_events);

	//RoomControl
	instance_create_layer(x,y, "ControlObjects", obj_roomControl);
}

function LoadMediumPriority() {
	// Prio 1: file loading -> once, have global.ref, if exists, skip
	//DatabaseLoader
	if (!instance_exists(TryGetGlobalInstance(MANAGERS.DATABASE_MANAGER))) {
		instance_create_layer(x,y, "ControlObjects", obj_databaseLoader);
	}

	//SaveManager
	if (!instance_exists(TryGetGlobalInstance(MANAGERS.SAVE_MANAGER))) {
		instance_create_layer(x,y, "ControlObjects", obj_saveManager);
	}
}

function LoadLowPriority() {
	// Prio 2: Gameplay
	//InputManager
	if (input_manager)
		instance_create_layer(x,y, "ControlObjects", obj_inputManager);

	//Player -> if cosmetic, load player here, won't do it for now

	//Inventory
	if (inventory)
		instance_create_layer(x,y, "ControlObjects", obj_inventory);

	// Prio 3: Load ressources
	//particle manager
	if (particle_manager)
		instance_create_layer(x,y, "ControlObjects", obj_particleManager);
}