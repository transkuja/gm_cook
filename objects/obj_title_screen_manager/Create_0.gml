save_manager_inst = noone;
is_save_empty = true;

function InitMenu() {
	save_manager_inst = TryGetGlobalInstance(GLOBAL_INSTANCES.SAVE_MANAGER)
	if (instance_exists(save_manager_inst)) {
		is_save_empty = ds_map_size(save_manager_inst.current_save_data) == 0;
	}

	buttons_holder = instance_create_layer(0, 0, "Instances", obj_title_screen_buttons_holder);
	if (instance_exists(buttons_holder)) {
		buttons_holder.title_screen_manager_inst = self;
		buttons_holder.Init();
	}
}