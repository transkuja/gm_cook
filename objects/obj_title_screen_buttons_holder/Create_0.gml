/// @description Insert description here
// You can write your code in this editor

start_y = room_height * 0.5 - 50;
buttons_offset = 50;
spawn_x = room_width - 350;
title_screen_manager_inst = noone;
buttons = [];
catch_input = false;

//if (instance_number(obj_title_screen_manager) > 0)
//	title_screen_manager_inst = instance_find(obj_title_screen_manager, 0);
//else 
//	title_screen_manager_inst = instance_create_layer(0,0,"GLOBAL_INSTANCES", obj_title_screen_manager);
	
function CreateButton(_text, _y, _broadcast, _up, _down) {
	var button_inst = instance_create_layer(spawn_x, _y, "GUI", obj_gui_button);
	if (instance_exists(button_inst)) {
		button_inst.image_xscale = 250 / button_inst.sprite_width;
		button_inst.image_yscale = 75 / button_inst.sprite_height;
		//button_inst.depth = depth-1000;
			
		button_inst.button_text = _text;
		button_inst.on_clicked_event = _broadcast;
	}
	
	return button_inst;
}

function LinkButtons(_to_link, _up, _down) {
	if (instance_exists(_to_link)) {
		_to_link.up_slot = _up;
		_to_link.down_slot = _down;
	}
}

function OnContinueClicked(_on_click_param) {
	room_goto(rm_gameMain);
}

function OnNewClicked(_on_click_param) {
	if (instance_exists(title_screen_manager_inst) && !title_screen_manager_inst.isSaveEmpty) {
		// Popup ?
		title_screen_manager_inst.saveManagerInst.clear_save();
	}
	
	fridge_items_new_game = array_create(0);
	// Base ingredients
	_push(fridge_items_new_game, new ItemData("it_vege_1", 100));
	_push(fridge_items_new_game, new ItemData("it_vege_2", 100));
	_push(fridge_items_new_game, new ItemData("it_fruit_1", 100));
	_push(fridge_items_new_game, new ItemData("it_flour", 100));
	_push(fridge_items_new_game, new ItemData("it_egg", 100));
	_push(fridge_items_new_game, new ItemData("it_milk", 100));
	_push(fridge_items_new_game, new ItemData("it_water", 100));

	// Test
	//_push(fridge_items_new_game, new ItemData("it_assembled_tart", 100));
	//_push(fridge_items_new_game, new ItemData("it_c_fruit_1", 100));
	//_push(fridge_items_new_game, new ItemData("it_c_vege_1", 100));
	//_push(fridge_items_new_game, new ItemData("it_c_vege_2", 100));
	//_push(fridge_items_new_game, new ItemData("it_cake", 100));
	//_push(fridge_items_new_game, new ItemData("it_clafoutis", 100));
	//_push(fridge_items_new_game, new ItemData("it_crepe", 100));
	//_push(fridge_items_new_game, new ItemData("it_crepe_fruits", 100));
	//_push(fridge_items_new_game, new ItemData("it_crepe_veggies", 100));
	//_push(fridge_items_new_game, new ItemData("it_dough", 100));
	
	//_push(fridge_items_new_game, new ItemData("it_fruit_salad", 100));
	//_push(fridge_items_new_game, new ItemData("it_fruits_cake", 100));
	//_push(fridge_items_new_game, new ItemData("it_milk_egg_flour_combo", 100));
	
	//_push(fridge_items_new_game, new ItemData("it_oeufs_plat", 100));
	//_push(fridge_items_new_game, new ItemData("it_pizza", 100));
	//_push(fridge_items_new_game, new ItemData("it_poelee_legumes", 100));
	//_push(fridge_items_new_game, new ItemData("it_prep_cake", 100));
	//_push(fridge_items_new_game, new ItemData("it_prep_clafoutis", 100));
	//_push(fridge_items_new_game, new ItemData("it_prep_fruit_cake", 100));
	_push(fridge_items_new_game, new ItemData("it_prep_pizza", 100));
	//_push(fridge_items_new_game, new ItemData("it_salad", 100));
	//_push(fridge_items_new_game, new ItemData("it_sauce", 100));
	//_push(fridge_items_new_game, new ItemData("it_tart", 100));
	
	for (var _i = 0; _i < array_length(fridge_items_new_game); _i++)
		fridge_items_new_game[_i].SaveData("fridge_item_" + string(_i));
		
	room_goto(rm_gameMain);
}

draw_credits = false;
function OnCreditsClicked(_on_click_param) {
	draw_credits = !draw_credits;
}

function CreateReadableSave(_on_click_param) {
	if (instance_exists(title_screen_manager_inst) && !title_screen_manager_inst.isSaveEmpty) {
		title_screen_manager_inst.saveManagerInst.convert_to_readable_save_file();
	}
}

function OnExitClicked(_on_click_param) {
	game_end();
}

#region Inputs
function OnUpPressed() {
	if (input_validated)
		return;
		
	if (selected_slot == -1)
		return;
	
	if (instance_exists(buttons[selected_slot].up_slot))
	{
		var _button_to_select = buttons[selected_slot].up_slot;
		SetSelectedButton(_button_to_select.slot_index);
		
		input_validated = true;
		alarm[0] = seconds(0.2);
	}
}

function OnUpStick(_stick_value) {
	if (input_validated)
		return;
		
	if (selected_slot == -1)
		return;
	
	if (instance_exists(buttons[selected_slot].up_slot))
	{
		var _button_to_select = buttons[selected_slot].up_slot;
		SetSelectedButton(_button_to_select.slot_index);
			
		input_validated = true;
		alarm[0] = seconds(0.2);
	}
}

function OnDownPressed() {
	if (input_validated)
		return;
		
	if (selected_slot == -1)
		return;
	
	if (instance_exists(buttons[selected_slot].down_slot))
	{
		var _button_to_select = buttons[selected_slot].down_slot;
		SetSelectedButton(_button_to_select.slot_index);
		
		input_validated = true;
		alarm[0] = seconds(0.2);
	}
}

function OnDownStick() {
	if (input_validated)
		return;
		
	if (selected_slot == -1)
		return;
	
	if (instance_exists(buttons[selected_slot].down_slot))
	{
		var _button_to_select = buttons[selected_slot].down_slot;
		SetSelectedButton(_button_to_select.slot_index);
			
		input_validated = true;
		alarm[0] = seconds(0.2);
	}
}

#endregion

function Init() {
	if (!layer_exists("GUI"))
		layer_create(-10000,"GUI");

	// Continue button
	// TODO: check save
	
	var _button = noone;
	
	buttons_count = 0;
	if (instance_exists(title_screen_manager_inst) && !title_screen_manager_inst.is_save_empty) {
		_button = CreateButton("Continue", start_y, Broadcast(function(_on_click_param) {
					OnContinueClicked(_on_click_param);}) 
				);
		
		if (instance_exists(_button))
		{
			_push(buttons, _button);
			buttons_count++;
		}
	}

	// New button
	_button = CreateButton("New", start_y + (buttons_offset + 50) * buttons_count, Broadcast(function(_on_click_param) {
					OnNewClicked(_on_click_param);}) 
				); 
	if (instance_exists(_button))
	{
		_push(buttons, _button);
		buttons_count++;
	}

	// Credits button
	_button = CreateButton("Credits", start_y + (buttons_offset + 50) * buttons_count, Broadcast(function(_on_click_param) {
					OnCreditsClicked(_on_click_param);}) 
				); 
	if (instance_exists(_button))
	{
		_push(buttons, _button);
		buttons_count++;
	}

	// Credits button
	_button = CreateButton("DebugSave", start_y + (buttons_offset + 50) * buttons_count, Broadcast(function(_on_click_param) {
					CreateReadableSave(_on_click_param);}) 
				); 
	if (instance_exists(_button))
	{
		_push(buttons, _button);
		buttons_count++;
	}
	
	// Exit button
	_button = CreateButton("Exit", start_y + (buttons_offset + 50) * buttons_count, Broadcast(function(_on_click_param) {
					OnExitClicked(_on_click_param);}) 
				); 
	
	if (instance_exists(_button))
		_push(buttons, _button);
	
	for (var _index = 0; _index < array_length(buttons); _index++)
	{
		var _previous = _index - 1;
		var _next = (_index + 1) % array_length(buttons);
		if (_previous < 0) _previous = array_length(buttons) - 1;
		
		LinkButtons(buttons[_index], buttons[_previous], buttons[_next]);
		
		buttons[_index].slot_index = _index;
	}
	
	SetSelectedButton(0);
	
	// BindInputs
	BindEventToInput("ui_up", INPUT_EVENTS.PRESSED, OnUpPressed);
	//BindEventToInput("ui_stick_up", INPUT_EVENTS.DOWN, OnUpStick);
	//BindEventToInput("ui_down", INPUT_EVENTS.PRESSED, OnDownPressed);
	//BindEventToInput("ui_stick_down", INPUT_EVENTS.DOWN, OnDownStick);
	
	catch_input = true;
}

input_validated = false;
selected_slot = 0;
function SetSelectedButton(_index) {
	if (_index >= array_length(buttons)) { return; }
	
	selected_slot = _index;
		
	for (var i = 0; i < array_length(buttons); i++) {
		if (instance_exists(buttons[i])) {
			buttons[i].SetSelected(buttons[i].slot_index == selected_slot);
		}
	}
	
}


function OnSlotClicked(_slot_index) {
	buttons[_slot_index].on_clicked();

}

function HandleSelectionInput() {
	if (input_validated)
		return;
		
	if (selected_slot == -1)
		return;
	
	var _button_to_select = noone;
	var _input_pressed = false;
	var _stick_input = false;
	if (input_get_pressed(0, "ui_up") || input_get(0, "ui_stick_up")) {
		if (instance_exists(buttons[selected_slot].up_slot))
		{
			_button_to_select = buttons[selected_slot].up_slot;
			_input_pressed = true;
			_stick_input = input_get(0, "ui_stick_up");
		}
	}
	else if (input_get_pressed(0, "ui_down") || input_get(0, "ui_stick_down")) {
		if (instance_exists(buttons[selected_slot].down_slot))
		{
			_button_to_select = buttons[selected_slot].down_slot;
			_input_pressed = true;
			_stick_input = input_get(0, "ui_stick_down");
		}
	}
		
	if (_input_pressed && instance_exists(_button_to_select))
	{
		SetSelectedButton(_button_to_select.slot_index);
			
		if (_stick_input)
		{
			input_validated = true;
			alarm[0] = seconds(0.2);
		}
	}
}

function HandleInput() {
	if (selected_slot != -1)
	{
		if (input_get_pressed(0, "ui_validate_no_click")) {
			OnSlotClicked(selected_slot);
		}
	}
}
