slot_count = 3;

inventory = array_create(slot_count, new ItemData());
item_box = [];

slots_instances = array_create(slot_count);
slots_step = 75;
slot_width = 128;
selected_slot = 0;

// Functions
function GetNbrInventorySlotsTaken() {
}

function AddItemIfPossible(_item_id, _qty) {
	var _index = GetAvailableIndex(_item_id, _qty);
	if (_index != -1) {
		return AddItem(new ItemData(_item_id, _qty), _index);
	}
	
	return false;
}

function CanAddItem(_item_id, _qty) {
	return GetAvailableIndex(_item_id, _qty) != -1;
}

function GetAvailableIndex(_item_id, _qty) {
	var _found_index = array_find_index(inventory, method({item_id:_item_id} , function(_element) 
													{ return (_element.item_id == item_id )}));
	
	if (_found_index == -1)
	{
		var _empty_index = array_find_index(inventory, method({item_id:_item_id} , function(_element) 
													{ return (_element.item_id == "empty" )}));
													
		return _empty_index;
	}
	else 
	{
		// TODO: check stack
	}
	
	return _found_index;
}

function AddItem(_data, _index) {
	//var _foundIndex = array_find_index(inventory, method({data:_data} , function(_element) 
	//												{ return (_element.item_id == data.item_id); }));
	
	if (inventory[_index].item_id == "empty")
	{
		inventory[_index] = _data;
		//array_push(inventory, _data);
	}
	else
	{
		inventory[_index].qty += _data.qty;
		show_debug_message(_data.item_id + " was in inventory");
		show_debug_message("new quantity: {0}", inventory[_index].qty);
	}
	
	DrawItems();
	
	return true;
}

function RemoveItem(_id, _qty) {
	var _found_index = array_find_index(inventory, method({item_id:_id} , function(_element) 
													{ return (_element.item_id == item_id); }));
	
	if (_found_index != -1)
	{
		inventory[_found_index].qty -= _qty;
		show_debug_message(inventory[_found_index].item_id + " new quantity: {0}", inventory[_found_index].qty);
		
		if (inventory[_found_index].qty <= 0)
		{
			show_debug_message("Quantity 0, deleting " + inventory[_found_index].item_id);
			inventory[_found_index] = new ItemData();
			slots_instances[_found_index].Refresh({});
		}
		else
			slots_instances[_found_index].Refresh(inventory[_found_index]);
	}
}

function DrawItems() {
		
	for (var i = 0; i < array_length(slots_instances); i += 1)
	{
		if (!instance_exists(slots_instances[i])) continue;
		if (i < array_length(inventory))
		{
			slots_instances[i].Refresh(inventory[i]);
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
			slots_instances[i].SetSelected(i == selected_slot);
		}
	}
}

function DrawSlots() {
	if (!layer_exists("GUI"))
		layer_create(-10000,"GUI");
	
	//instance_create_layer(view_wport[0] * 0.5, view_hport[0] - 200, "GUI", obj_debug_square);

	var _draw_xs = GetPositionsOnLineCenter(slot_width, slots_step, slot_count, view_wport[0] * 0.5, SPRITE_ORIGIN.MIDDLE_CENTER); 
	
	// Draw slots
	for (var i = 0; i < slot_count; i += 1)
	{
		slots_instances[i] = instance_create_layer(_draw_xs[i], view_hport[0] - 200, "GUI", obj_gui_inventory_slot);
		slots_instances[i].slot_index = i;
		if (i == 0) {
			slots_instances[0].SetSelected(true);
		}
	}
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

function IsSelectedItemValid() {
	return slots_instances[selected_slot] != noone && slots_instances[selected_slot] != undefined
		&& GetSelectedItemId() != "none";
}

// Returns the selected item id or "none" if no proper item was selected
function UseSelectedItem() {
	var _currentSlotId = GetSelectedItemId();
	
	RemoveItem(_currentSlotId, 1);
	return _currentSlotId;
}

function HasItem(_item_id) {
	for (var _i = 0; _i < array_length(inventory); _i++) {
		if (!struct_exists(inventory[_i], "item_id"))
			continue;
			
		if (inventory[_i].item_id == _item_id)
			return true;
	}
	
	return false;
}
// Create process
DrawSlots();