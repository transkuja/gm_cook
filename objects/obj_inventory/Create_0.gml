slot_count = 3;

inventory = array_create(0);
item_box = [];

slots_instances = array_create(slot_count);
slots_step = 75;
slot_width = 128;
selected_slot = 0;

// Functions
function GetNbrInventorySlotsTaken() {
}

function AddItem(_data) {
	var _foundIndex = array_find_index(inventory, method({data:_data} , function(_element) 
													{ return (_element.item_id == data.item_id); }));
	
	if (_foundIndex == -1)
	{
		array_push(inventory, _data);
	}
	else
	{
		inventory[_foundIndex].qty += _data.qty;
		show_debug_message(_data.item_id + " was in inventory");
		show_debug_message("new quantity: {0}", inventory[_foundIndex].qty);
	}
	
	DrawItems();
}

function RemoveItem(_id, _qty) {
	var _foundIndex = array_find_index(inventory, method({item_id:_id} , function(_element) 
													{ return (_element.item_id == item_id); }));
	
	if (_foundIndex != -1)
	{
		inventory[_foundIndex].qty -= _qty;
		show_debug_message(inventory[_foundIndex].item_id + " new quantity: {0}", inventory[_foundIndex].qty);
		
		if (inventory[_foundIndex].qty <= 0)
		{
			show_debug_message("Quantity 0, deleting " + inventory[_foundIndex].item_id);
			array_delete(inventory, _foundIndex, 1);
			slots_instances[_foundIndex].Refresh({});
		}
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
	
	instance_create_layer(view_wport[0] * 0.5, view_hport[0] - 200, "GUI", obj_debug_square);

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
	return GetSelectedItemId() != "none";
}

// Returns the selected item id or "none" if no proper item was selected
function UseSelectedItem() {
	var _currentSlotId = GetSelectedItemId();
	
	RemoveItem(_currentSlotId, 1);
	return _currentSlotId;
}

// Create process
DrawSlots();