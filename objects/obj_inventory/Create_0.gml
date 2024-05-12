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
		}
	}
}

function DrawItems() {
		
	for (var i = 0; i < array_length(slots_instances); i += 1)
	{
		if (!instance_exists(slots_instances[i])) continue;
		if (i < array_length(inventory))
		{
			slots_instances[i].Refresh(inventory[i].sprite, inventory[i].qty);
		}
		else
			slots_instances[i].Refresh(-1, 0);
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
	var _xoffset = ((slot_width * slot_count) + (slots_step * (slot_count - 1))) * 0.5;

	if (!layer_exists("GUI"))
		layer_create(-10000,"GUI");
	
	instance_create_layer(view_wport[0] * 0.5, view_hport[0] - 200, "GUI", obj_debug_square);

	// Draw slots
	for (var i = 0; i < slot_count; i += 1)
	{
		show_debug_message("i offset: {0}", (slots_step + slot_width) * i);
		var _x = (view_wport[0] * 0.5) +( (slot_width + slots_step) * i) - _xoffset;
		slots_instances[i] = instance_create_layer(_x, view_hport[0] - 200, "GUI", obj_gui_inventory_slot);
		slots_instances[i].slot_index = i;
		if (i == 0) {
			slots_instances[0].SetSelected(true);
		}
	}
}

// Create process
DrawSlots();