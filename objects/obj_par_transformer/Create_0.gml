event_inherited()

items_in_ids = array_create(0, "none");

// On X pressed
function StartTransforming() {
	
}

// On A pressed
function PutItemIn(_itemId) {
	if (IsFilled()) {
		PlayFilledFeedbacks()
		return;
	}
	
	if (_itemId != "none")
		_push(items_in_ids, _itemId);
	
	_log("Transformer content:");
	for (var i = 0; i < array_length(items_in_ids); i++)
		_log(items_in_ids[i]);
}

// After operation, A
function TakeFrom() {
	if (array_length(items_in_ids) == 0) { return; }
	
	var _item_removed = items_in_ids[array_length(items_in_ids) - 1];
	array_remove(items_in_ids, _item_removed);
	return _item_removed;
}


// On A pressed
function Interact(_interactInstigator) {
	if (instance_exists(_interactInstigator) && _interactInstigator.object_index == obj_player) {
		if (_interactInstigator.HasItemInHands())
			return;
	}
	
	if (IsFilled()) {
		StartTransforming();
	}
}

// Retrieve what has been put in, in case of mistake
function EmptyTransformer() {
	
}

// At least one item in
function ContainsAnItem() {
	return array_length(items_in_ids) > 0;
}

function IsFilled() {
	// array_remove(items_in_ids, "none");
	return array_length(items_in_ids) == max_items;
}


function PlayFilledFeedbacks() {
	_log("Filled !");
}