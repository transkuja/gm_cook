saveManagerInst = instance_create_layer(0, 0, "Managers", obj_saveManager);
if (instance_exists(saveManagerInst)) {
	saveManagerInst.perform_load();
	isSaveEmpty = ds_map_size(saveManagerInst.current_save_data) == 0;
}

buttons_holder = instance_create_layer(0, 0, "Instances", obj_title_screen_buttons_holder);
if (instance_exists(buttons_holder)) {
	buttons_holder.title_screen_manager_inst = self;
	buttons_holder.Init();
}