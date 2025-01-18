slot_count = 4;

inventory = new Inventory(slot_count);

item_box = [];

slots_instances = array_create(slot_count);
slots_step = 50;
slot_width = 128;
slot_height = 128;
selected_slot = 0;

display_lines = 1;

draw_origin = [view_wport[0] * 0.5, view_hport[0] - 200];

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
}

BindEventsToInventory();

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
	
	if (selected_slot >= 0 && global.ui_on_inventory_slot_selected != noone)
		global.ui_on_inventory_slot_selected.dispatch();
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
		}
		
		_remaining_draw -= _nb_columns;
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

function IsSelectedItemValid() {
	return selected_slot >= 0 
		&& slots_instances[selected_slot] != noone && slots_instances[selected_slot] != undefined
		&& GetSelectedItemId() != "none";
}

// Returns the selected item id or "none" if no proper item was selected
function UseSelectedItem() {
	var _currentSlotId = GetSelectedItemId();
	
	inventory.RemoveItem(_currentSlotId, 1);
	return _currentSlotId;
}

function HasItem(_item_id) {
	return inventory.HasItem(_item_id);
}

// Create process
CreateGUISlots();