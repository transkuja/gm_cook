/// @description Insert description here
// You can write your code in this editor

start_y = room_height * 0.5 - 50;
buttons_offset = 50;
spawn_x = room_width - 350;
title_screen_manager_inst = noone;

//if (instance_number(obj_title_screen_manager) > 0)
//	title_screen_manager_inst = instance_find(obj_title_screen_manager, 0);
//else 
//	title_screen_manager_inst = instance_create_layer(0,0,"Managers", obj_title_screen_manager);
	
function CreateButton(_text, _y, _broadcast) {
	var button_inst = instance_create_layer(spawn_x, _y, "GUI", obj_gui_button);
	if (instance_exists(button_inst)) {
		button_inst.image_xscale = 250 / button_inst.sprite_width;
		button_inst.image_yscale = 75 / button_inst.sprite_height;
		//button_inst.depth = depth-1000;
			
		button_inst.button_text = _text;
		button_inst.on_clicked_event = _broadcast;
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
	_push(fridge_items_new_game, new ItemData("protaupe_egg", 2));
	_push(fridge_items_new_game, new ItemData("protaupe_flour", 4));
	
	for (var _i = 0; _i < array_length(fridge_items_new_game); _i++)
		fridge_items_new_game[_i].SaveData("fridge_item_" + string(_i));
		
	room_goto(rm_gameMain);
}

draw_credits = false;
function OnCreditsClicked(_on_click_param) {
	draw_credits = !draw_credits;
}

function OnExitClicked(_on_click_param) {
	game_end();
}

function Init() {
	if (!layer_exists("GUI"))
		layer_create(-10000,"GUI");

	// Continue button
	// TODO: check save
	buttons_count = 0;
	if (instance_exists(title_screen_manager_inst) && !title_screen_manager_inst.isSaveEmpty) {
		CreateButton("Continue", start_y, Broadcast(function(_on_click_param) {
					OnContinueClicked(_on_click_param);}) 
				); 
		buttons_count++;
	}

	// New button
	CreateButton("New", start_y + (buttons_offset + 50) * buttons_count, Broadcast(function(_on_click_param) {
					OnNewClicked(_on_click_param);}) 
				); 
	buttons_count++;

	// Credits button
	CreateButton("Credits", start_y + (buttons_offset + 50) * buttons_count, Broadcast(function(_on_click_param) {
					OnCreditsClicked(_on_click_param);}) 
				); 
	buttons_count++;

	// Exit button
	CreateButton("Exit", start_y + (buttons_offset + 50) * buttons_count, Broadcast(function(_on_click_param) {
					OnExitClicked(_on_click_param);}) 
				); 
}