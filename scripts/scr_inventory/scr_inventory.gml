
function ItemData(_id = "empty", _qty = 0, _stack = 0) constructor {
    item_id = _id;
	qty = _qty;
	stack = _stack;
	
	function SaveData(_key) {
		save_data_set(_key + "_id", item_id);
		save_data_set(_key + "_qty", qty);
	}
	
	function LoadData(_key) {
		item_id = save_data_get(_key + "_id");
		qty = save_data_get(_key + "_qty");
		
		if (is_undefined(item_id) || is_undefined(qty))
		{
			item_id = "none";
			qty = 0;
		}
	}
	
	function IsValid() {
		if (item_id == "none" || qty == 0)
			return false;
			
		return true;
	}
} 

function Inventory(_slot_count) constructor {
	items = array_create(_slot_count, new ItemData());
	
	on_item_added = noone;
	on_item_removed = noone;
	
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
		var _found_index = array_find_index(items, method({item_id:_item_id} , function(_element) 
														{ return (_element.item_id == item_id )}));
	
		if (_found_index == -1)
		{
			var _empty_index = array_find_index(items, method({item_id:_item_id} , function(_element) 
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
	
		if (items[_index].item_id == "empty")
		{
			items[_index] = _data;
			//array_push(inventory, _data);
		}
		else
		{
			items[_index].qty += _data.qty;
			show_debug_message(_data.item_id + " was in inventory");
			show_debug_message("new quantity: {0}", items[_index].qty);
		}
		
		if (on_item_added != noone)
			on_item_added.dispatch();
	
		return true;
	}

	function RemoveItem(_id, _qty) {
		var _found_index = array_find_index(items, method({item_id:_id} , function(_element) 
														{ return (_element.item_id == item_id); }));
	
		if (_found_index != -1)
		{
			items[_found_index].qty -= _qty;
			show_debug_message(items[_found_index].item_id + " new quantity: {0}", items[_found_index].qty);
		
			if (items[_found_index].qty <= 0)
			{
				show_debug_message("Quantity 0, deleting " + items[_found_index].item_id);
				items[_found_index] = new ItemData();
			}
				
			if (on_item_removed != noone)
				on_item_removed.dispatch(_found_index);
		}
	}

	function HasItem(_item_id) {
		for (var _i = 0; _i < array_length(items); _i++) {
			if (!struct_exists(items[_i], "item_id"))
				continue;
			
			if (items[_i].item_id == _item_id)
				return true;
		}
	
		return false;
	}
}