slot_count = 4;

inventory = new Inventory(slot_count);
save_prefixe = "inventory_item_";
item_box = [];

slots_instances = array_create(slot_count);
slots_step = 50;
slot_width = 128;
slot_height = 128;
selected_slot = 0;

display_lines = 1;

draw_origin = [view_wport[0] * 0.5, view_hport[0] - 200];

global.inventory_instance = self;

function BindEventsToInventory() {
	var _broadcast_add = Broadcast(function() {
		DrawItems();
	} );
			
	inventory.on_item_added = _broadcast_add;
			
	var _broadcast_remove = Broadcast(function(_found_index) {
		slots_instances[_found_index].Refresh(inventory.items[_found_index]);
	} );
			
	inventory.on_item_removed = _broadcast_remove;
	
	// Clear selection
	var _broadcast = Broadcast(function() {
		SetSelectedSlot(-1);
	} );
			
	global.ui_on_fridge_slot_selected = _broadcast;
	
	var _reset_selection = Broadcast(function() {
		if (selected_slot < 0)
			SetSelectedSlot(0);
	} );
	
	global.ui_on_fridge_closed = _reset_selection;
	
	var _link_fridge_slots = Broadcast(function() {
		LinkInventoryToOtherPanelSlots();
	} );
	
	global.ui_on_fridge_opened = _link_fridge_slots;
}

BindEventsToInventory();

function PerformLoad() {
	for (var _i = 0; _i < slot_count; _i++)
	{
		var _new_item = new ItemData();
		_new_item.LoadData(save_prefixe + string(_i));

		if (_new_item.IsValid())
			inventory.items[_i] = _new_item;
	}
	
	DrawItems();
}

function PerformSave() {
	for (var _i = 0; _i < slot_count; _i++)
	{
		if (_i >= array_length(inventory.items))
		{
			var _empty_item = new ItemData();
			_empty_item.SaveData(save_prefixe + string(_i));
			continue;
		}
		
		//if (inventory.items[_i].item_id != "none" && inventory.items[_i].qty > 0)
		//{
		inventory.items[_i].SaveData(save_prefixe + string(_i));
		//}
	}
}


// Functions
function GetNbrInventorySlotsTaken() {
}

function CanAddItem(_item_id, _qty) {
	return inventory.CanAddItem(_item_id, _qty);
}

function AddItemIfPossible(_item_id, _qty) {
	var _item_added = inventory.AddItemIfPossible(_item_id, _qty);
	
	if (_item_added)
		PerformSave();
		
	return _item_added;
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

function LockDirectionInput() {
	input_validated = true;
	alarm[2] = seconds(0.2);
}

function SetSelectedSlot(_newValue) {
	if (_newValue >= array_length(slots_instances)) { return; }
	
	selected_slot = _newValue;
		
	for (var i = 0; i < array_length(slots_instances); i++) {
		if (instance_exists(slots_instances[i])) {
			slots_instances[i].SetSelected(slots_instances[i].slot_index == selected_slot);
		}
	}
	
	if (selected_slot >= 0 && variable_global_exists("ui_on_inventory_slot_selected"))
	{
		if (global.ui_on_inventory_slot_selected != noone)
			global.ui_on_inventory_slot_selected.dispatch();
	}
	
}

function OnSlotClicked(_slot_index) {
	if (selected_slot != _slot_index)
		SetSelectedSlot(_slot_index);
		
	if (!IsSelectedItemValid())
		return;
			
	// Checks if another menu is opened
	if (global.inventory_mode)
	{
		if (global.ui_on_inventory_item_used != noone)
		{
			_ctrl_input = keyboard_check(vk_lcontrol) || keyboard_check(vk_control);
			_item_data_to_use = new ItemData(GetSelectedItemId(), _ctrl_input ? GetSelectedItemQty() : 1);
			if (global.ui_on_inventory_item_used(_item_data_to_use))
			{
				if (_ctrl_input)
					UseAllItemsSelected();
				else
					UseSelectedItem();
			}
		}
	}
	else
	{
		var _player = TryGetGlobalInstance(GLOBAL_INSTANCES.PLAYER);
		if (instance_exists(_player)) {
			_player.GetItemFromInventoryToHands();
		}
	}
	
}

input_validated = false;
function HandleSelectionInput() {
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
	if (global.inventory_mode && selected_slot != -1)
	{
		if (input_get_pressed(0, "ui_validate_no_click")) {
			OnSlotClicked(selected_slot);
			return;
		}
		
		// Transfer all input
		if (input_get_pressed(0, "ui_alt")) {
			if (!IsSelectedItemValid())
						return;
			
			// Checks if another menu is opened
			if (global.inventory_mode)
			{
				if (global.ui_on_inventory_item_used != noone)
				{
					var _item_qty = GetSelectedItemQty();
					var _item_data_to_use = new ItemData(GetSelectedItemId(), _item_qty);
					if (global.ui_on_inventory_item_used(_item_data_to_use))
						UseAllItemsSelected();
				}
			}
		
			return;
		}
	}
}

function GetNearSlot(_index, _dir) {
	switch (_dir) {
		case "left":
			// Is on the far left ?
			if (_index == 0)
				return slots_instances[slot_count - 1];
			else
				return slots_instances[_index - 1];
		case "right":
			// Is on the far right ?
			if (_index == slot_count - 1)
				return slots_instances[0];
			else
				return slots_instances[_index + 1];		
		case "up":
			if (!variable_global_exists("ui_fridge_last_row"))
				return noone;
				
			return GetClosest(slots_instances[_index], global.ui_fridge_last_row);
		case "down":
			if (!variable_global_exists("ui_fridge_first_row"))
				return noone;
				
			return GetClosest(slots_instances[_index], global.ui_fridge_first_row);	
				
		default:
			return noone;
	}
}

function LinkInventoryToOtherPanelSlots() {
	for (var _i = 0; _i < slot_count; _i += 1)
	{
		slots_instances[_i].up_slot = GetNearSlot(_i, "up");
		slots_instances[_i].down_slot = GetNearSlot(_i, "down");
		slots_instances[_i].left_slot = GetNearSlot(_i, "left");
		slots_instances[_i].right_slot = GetNearSlot(_i, "right");
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

			slots_instances[_slot_index] = instance_create_layer(_draw_xs[i], draw_origin[1] + (slots_step + slot_height) * _line_index, "GUI", obj_gui_inventory_slot);
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
	
	//input_position_x = draw_origin[0] - 150;
	//input_position_y = draw_origin[1];
	
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
		&& GetSelectedItemId() != "none";
}

// Returns the selected item id or "none" if no proper item was selected
function UseSelectedItem() {
	var _currentSlotId = GetSelectedItemId();
	
	inventory.RemoveItem(_currentSlotId, 1);
	
	DrawItems();
	
	PerformSave();
	
	return _currentSlotId;
}

function UseAllItemsSelected() {
	var _currentSlotId = GetSelectedItemId();
	
	inventory.RemoveItem(_currentSlotId, GetSelectedItemQty());
	
	DrawItems();
	
	PerformSave();
		
	return _currentSlotId;
}

function HasItem(_item_id) {
	return inventory.HasItem(_item_id);
}

// Create process
CreateGUISlots();