/// @description Insert description here
// You can write your code in this editor
is_loaded = false;

function LoadHighPriority() {
	if (!layer_exists("ControlObjects"))
		layer_create(0,"ControlObjects");
		
	// Delta
	delta_init();
	instance_create_layer(x,y, "ControlObjects", obj_delta);

	// Prio 0: Global var
	//GlobalEvents
	instance_create_layer(x,y, "ControlObjects", obj_global_events);

	//RoomControl
	instance_create_layer(x,y, "ControlObjects", obj_roomControl);
	
	//InputManager
	if (input_manager)
		instance_create_layer(x,y, "ControlObjects", obj_inputManager);
		
	alarm[0] = seconds(0.2);
}

function LoadMediumPriority() {
	// Prio 1: file loading -> once, have global.ref, if exists, skip
	
	//DatabaseLoader
	if (!instance_exists(TryGetGlobalInstance(GLOBAL_INSTANCES.DATABASE_MANAGER))) {
		instance_create_layer(x,y, "ControlObjects", obj_databaseLoader);
	}

	//SaveManager
	if (!instance_exists(TryGetGlobalInstance(GLOBAL_INSTANCES.SAVE_MANAGER))) {
		instance_create_layer(x,y, "ControlObjects", obj_saveManager);
	}
	
	alarm[1] = seconds(0.3);
}

function LoadLowPriority() {
	// Prio 2: Gameplay

	//Player -> if cosmetic, load player here, won't do it for now

	//Inventory
	if (inventory)
	{
		var _inventory = instance_create_layer(x,y, "ControlObjects", obj_inventory);
		if (instance_exists(_inventory))
		{
			_inventory.PerformLoad();
			//var _save_manager = TryGetGlobalInstance(GLOBAL_INSTANCES.SAVE_MANAGER);
			//if (instance_exists(_save_manager))
			//	_save_manager.bind_to_data_collection(_inventory, function(){_inventory.PerformSave();});
		}
	}
	
    // GameState
    var _game_state = instance_create_layer(x,y, "ControlObjects", obj_gameState);
    if (instance_exists(_game_state))
    {
        _game_state.GameStateInit();
        _game_state.LoadState();
    }
    
	// Prio 3: Load ressources
	//particle manager
	if (particle_manager)
		instance_create_layer(x,y, "ControlObjects", obj_particleManager);
		
	is_loaded = true;
}