text_width = 850;
line_height = 40;

// Stop player on open
global.inventory_mode = true;

// Init fade values
event_perform_object(obj_fading, ev_create, 0);
fadeMe = 1; // don't fade immediately

on_menu_close = noone;

depth = -9999;

can_close = false;

slot_count = 24;

slots_instances = array_create(slot_count);
slots_step = 50;
slot_width = 128;
slot_height = 128;
selected_slot = 0;

display_lines = 4;

bg_width = 100 + ((slot_count / display_lines) * (slots_step + slot_width));
bg_height = 100 + (display_lines * (slots_step + slot_height));

draw_origin = [view_wport[0] * 0.5, view_hport[0] * 0.5 - (slot_height + slots_step) * display_lines * 0.5 - 50];
x = draw_origin[0] - bg_width * 0.5;
y = (view_hport[0] - bg_height) * 0.5 - 75;

save_key = "fridge_item_";

inventory = noone;

is_closing = false;

input_validated = false;
//inventory.AddItemIfPossible("protaupe_egg", 1);
//inventory.AddItemIfPossible("protaupe_flour", 5);
global.ui_fridge_first_row = [];
global.ui_fridge_last_row = [];

function SetSize() {
	image_xscale = bg_width / sprite_width;
	image_yscale = bg_height / sprite_height;
}

function LockDirectionInput() {
	input_validated = true;
	alarm[2] = seconds(0.2);
}

function Initialize(_inventory) {
	//if (_item_id == undefined || _item_id == "" || _item_id == noone) {
	//	instance_destroy();
	//	return;
	//}
	
	inventory = _inventory;
	
	if (inventory == noone)
	{
		instance_destroy();
		return;
	}
	
	BindEventsToInventory();
	
	SetSize();

	image_alpha = 1;
	
	audio_play_sound(snd_on_popup_open, 10, false);
	
	// Create slots and draw items
	CreateGUISlots();
	DrawItems();
	
	// Clear selection on select inventory
	var _broadcast = Broadcast(function() {
		SetSelectedSlot(-1);
	} );
	
	global.ui_on_inventory_slot_selected = _broadcast;
	
	// Bind event on interact with player inventory
	var _broadcast_item_removed = function(item_data) {
		return AddItemIfPossible(item_data.item_id, item_data.qty);
	};
	
	global.ui_on_inventory_item_used = _broadcast_item_removed;
	
	//// Bind event on interact with player inventory
	//var _broadcast_condition = Broadcast(function(item_data) {
	//	AddItemIfPossible(item_data.item_id, item_data.qty);
	//} );
	//global.ui_is_transfer_from_inventory_possible = _broadcast_condition;
	
	SetSelectedSlot(0);
	
	if (global.on_should_hide_exit_cross != noone)
		global.on_should_hide_exit_cross();
	
	if (global.ui_on_fridge_opened != noone)
		global.ui_on_fridge_opened.dispatch();
	
	alarm[1] = 30; // enable closing
}

function CloseMenu() {
	audio_play_sound(snd_on_popup_close, 10, false);
	
	if (on_menu_close != noone) 
		on_menu_close.dispatch();
	
	is_closing = true;
	
	for (var _index = slot_count - 1; _index >= 0; _index--)
	{
		if (instance_exists(slots_instances[_index]))
			slots_instances[_index].can_interact = false;
	}

	StartFadeOut();
	alarm[0] = seconds(0.5);
}

function HandleSelectionInput() {
	if (is_closing)
		return;
	
	if (input_validated)
		return;
		
	if (selected_slot == -1)
		return;
	
	var _slot_to_select = noone;
	var _input_pressed = false;
	var _stick_input = false;
	if (input_get_pressed(0, "ui_up") || input_get(0, "ui_stick_up")) {
		if (instance_exists(slots_instances[selected_slot].up_slot))
		{
			_slot_to_select = slots_instances[selected_slot].up_slot;
			_input_pressed = true;
			_stick_input = input_get(0, "ui_stick_up");
		}
	}
	else if (input_get_pressed(0, "ui_down") || input_get(0, "ui_stick_down")) {
		if (instance_exists(slots_instances[selected_slot].down_slot))
		{
			_slot_to_select = slots_instances[selected_slot].down_slot;
			_input_pressed = true;
			_stick_input = input_get(0, "ui_stick_down");
		}
	}
	else if (input_get_pressed(0, "ui_left") || input_get(0, "ui_stick_left")) {
		if (instance_exists(slots_instances[selected_slot].left_slot))
		{
			_slot_to_select = slots_instances[selected_slot].left_slot;
			_input_pressed = true;
			_stick_input = input_get(0, "ui_stick_left");
		}
	}
	else if (input_get_pressed(0, "ui_right") || input_get(0, "ui_stick_right")) {
		if (instance_exists(slots_instances[selected_slot].right_slot))
		{
			_slot_to_select = slots_instances[selected_slot].right_slot;
			_input_pressed = true;
			_stick_input = input_get(0, "ui_stick_right");
		}
	}
	
	if (_input_pressed && instance_exists(_slot_to_select))
	{
		if (_slot_to_select.owner != self)
		{
			_slot_to_select.owner.LockDirectionInput();
			_slot_to_select.owner.SetSelectedSlot(_slot_to_select.slot_index);
		}
		else
			SetSelectedSlot(_slot_to_select.slot_index);
			
		if (_stick_input)
		{
			input_validated = true;
			alarm[2] = seconds(0.2);
		}
	}
}

function HandleInput() {
	if (!is_closing && selected_slot != -1)
	{
		if (input_get_pressed(0, "ui_validate_no_click")) {
			OnSlotClicked(selected_slot);
			return;
		}
		
		// transfer all input
		if (input_get_pressed(0, "ui_alt")) {
			if (IsSelectedItemValid())
			{
				var _item_qty = GetSelectedItemQty();
				var _item_data_to_use = new ItemData(GetSelectedItemId(), _item_qty);

				var _inventory = TryGetGlobalInstance(GLOBAL_INSTANCES.INVENTORY);
				if (instance_exists(_inventory)) {
					if (_inventory.AddItemIfPossible(_item_data_to_use.item_id, _item_data_to_use.qty))
						UseAllItemsSelected();
				}
			}
		
			return;
		}
	}
	
	if (!can_close)
		return;
		
	// TODO: add delay to prevent closing too fast
	if (input_get_pressed(0, "ui_cancel")) {
		CloseMenu();
	}
}

function BindEventsToInventory() {
	var _broadcast_add = Broadcast(function() {
		DrawItems();
	} );
			
	inventory.on_item_added = _broadcast_add;
			
	var _broadcast_remove = Broadcast(function(_found_index) {
		slots_instances[_found_index].Refresh(inventory.items[_found_index]);
	} );
			
	inventory.on_item_removed = _broadcast_remove;
}

// Functions
function GetNbrInventorySlotsTaken() {
}

function CanAddItem(_item_id, _qty) {
	return inventory.CanAddItem(_item_id, _qty);
}

function AddItemIfPossible(_item_id, _qty) {
	return inventory.AddItemIfPossible(_item_id, _qty);
}

//function RemoveItem(_id, _qty) {
//	inventory.Remove(_id, _qty);
//}

function DrawItems() {
		
	for (var i = 0; i < array_length(slots_instances); i += 1)
	{
		if (!instance_exists(slots_instances[i])) continue;
		if (i < array_length(inventory.items))
		{
			slots_instances[i].Refresh(inventory.items[i]);
		}
		else
			slots_instances[i].Refresh({});
	}
}

function SetSelectedSlot(_newValue) {
	if (_newValue >= array_length(slots_instances)) { return; }
	
	selected_slot = _newValue;
		
	for (var i = 0; i < array_length(slots_instances); i++) {
		if (instance_exists(slots_instances[i])) {
			slots_instances[i].SetSelected(slots_instances[i].slot_index == selected_slot);
		}
	}
	
	if (selected_slot >= 0 && global.ui_on_fridge_slot_selected != noone)
		global.ui_on_fridge_slot_selected.dispatch();
}

function OnSlotClicked(_slot_index) {
	if (selected_slot != _slot_index)
		SetSelectedSlot(_slot_index);
		
	if (IsSelectedItemValid())
	{
		_ctrl_input = keyboard_check(vk_lcontrol) || keyboard_check(vk_control);
		_item_data_to_use = new ItemData(GetSelectedItemId(), _ctrl_input ? GetSelectedItemQty() : 1);

		var _inventory = TryGetGlobalInstance(GLOBAL_INSTANCES.INVENTORY);
		if (instance_exists(_inventory)) {
			if (_inventory.AddItemIfPossible(_item_data_to_use.item_id, _item_data_to_use.qty))
			{
				if (_ctrl_input)
					UseAllItemsSelected();
				else
					UseSelectedItem();
			}
		}
	}
}

function GetNearSlot(_index, _nb_columns, _dir, _inventory_mode = false) {
	switch (_dir) {
		case "left":
			// Is on left column ?
			if (_index % _nb_columns == 0)
				return slots_instances[_index + _nb_columns - 1];
			else
				return slots_instances[_index - 1];
		case "right":
			// Is on right column ?
			if (_index % _nb_columns == _nb_columns - 1)
				return slots_instances[_index - (_nb_columns - 1)];
			else
				return slots_instances[_index + 1];		
		case "up":
			// Is on top line ?
			if (_index < _nb_columns)
			{
				if (!_inventory_mode)
					return slots_instances[_index + ((display_lines - 1) * _nb_columns)];		
				else
				{
					var _inventory = TryGetGlobalInstance(GLOBAL_INSTANCES.INVENTORY);
					if (instance_exists(_inventory))
						return GetClosest(slots_instances[_index], _inventory.slots_instances);
					else
						return slots_instances[_index + ((display_lines - 1) * _nb_columns)];
				}
			}
			else
				return slots_instances[_index - _nb_columns];
				
		case "down":
			// Is on bottom line ?
			if (_index >= _nb_columns * (display_lines - 1))
			{
				if (!_inventory_mode)
					return slots_instances[_index - ((display_lines - 1) * _nb_columns)];
				else
				{
					var _inventory = TryGetGlobalInstance(GLOBAL_INSTANCES.INVENTORY);
					if (instance_exists(_inventory))
						return GetClosest(slots_instances[_index], _inventory.slots_instances);
					else
						return slots_instances[_index - ((display_lines - 1) * _nb_columns)];
				}
			}
			else
				return slots_instances[_index + _nb_columns];
				
		default:
			return noone;
	}
}

function CreateGUISlots() {
	if (!layer_exists("GUI"))
		layer_create(-10000,"GUI");
	
	//instance_create_layer(view_wport[0] * 0.5, view_hport[0] - 200, "GUI", obj_debug_square);

	var _nb_columns = ceil(slot_count / display_lines);
	var _remaining_draw = slot_count;
	
	for (var _line_index = 0; _line_index < display_lines; _line_index++)
	{
		var _draw_xs = GetPositionsOnLineCenter(slot_width, slots_step, _nb_columns, draw_origin[0], SPRITE_ORIGIN.MIDDLE_CENTER); 
		var _to_draw_count = min(_nb_columns, _remaining_draw);
		
		// Draw slots
		for (var i = 0; i < _to_draw_count; i += 1)
		{
			var _slot_index = i + (_line_index * _nb_columns);

			slots_instances[_slot_index] = instance_create_layer(_draw_xs[i], draw_origin[1] + (slots_step + slot_height) * _line_index, "GUI", obj_gui_fridge_slot);
			slots_instances[_slot_index].slot_index = _slot_index;
			slots_instances[_slot_index].on_click_param = _slot_index;
			slots_instances[_slot_index].owner = self;
			
			var _broadcast = Broadcast(function(_slot_index) {
				OnSlotClicked(_slot_index);
			} );
			
			slots_instances[_slot_index].on_clicked_event = _broadcast;
		}
		
		_remaining_draw -= _nb_columns;
	}
	
	// Set navigation
	for (var _index = 0; _index < slot_count; _index++)
	{
		slots_instances[_index].up_slot = GetNearSlot(_index, _nb_columns, "up", true);
		slots_instances[_index].down_slot = GetNearSlot(_index, _nb_columns, "down", true);
		slots_instances[_index].left_slot = GetNearSlot(_index, _nb_columns, "left");
		slots_instances[_index].right_slot = GetNearSlot(_index, _nb_columns, "right");
	}
	
	global.ui_fridge_first_row = [];
	global.ui_fridge_last_row = [];
	
	// Set global arrays so inventory can pick them up
	for (var _index = 0; _index < _nb_columns; _index++)
	{
		_push(global.ui_fridge_first_row, slots_instances[_index]);
		_push(global.ui_fridge_last_row, slots_instances[_index + (display_lines -1) * _nb_columns]);
	}
	
	slots_instances[0].SetSelected(true);
}


// Return currently selected item in inventory and "none" if no valid item selected
function GetSelectedItemId() {
	var _currentSlotId = 
		variable_struct_get_or_else(slots_instances[selected_slot].item_data, "item_id", "none");
	//with (slots_instances[selected_slot]) {	
		//_currentSlotId = item_data.item_id;
	//}
	
	return _currentSlotId;
}

function GetSelectedItemQty() {
	var _currentSlotQty = 
		variable_struct_get_or_else(slots_instances[selected_slot].item_data, "qty", "none");
	//with (slots_instances[selected_slot]) {	
		//_currentSlotId = item_data.item_id;
	//}
	
	return _currentSlotQty;
}

function IsSelectedItemValid() {
	return selected_slot >= 0
		&& slots_instances[selected_slot] != noone && slots_instances[selected_slot] != undefined
		&& GetSelectedItemId() != "none" && GetSelectedItemQty() > 0;
}

// Returns the selected item id or "none" if no proper item was selected
function UseSelectedItem() {
	var _currentSlotId = GetSelectedItemId();
	
	inventory.RemoveItem(_currentSlotId, 1);
	
	return _currentSlotId;
}

function UseAllItemsSelected() {
	var _currentSlotId = GetSelectedItemId();
	
	inventory.RemoveItem(_currentSlotId, GetSelectedItemQty());
	return _currentSlotId;
}

function HasItem(_item_id) {
	return inventory.HasItem(_item_id);
}
