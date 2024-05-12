event_inherited()

items_in_ids = array_create(0, "");

// On X pressed
function Interact() {
	
}

// On A pressed
function PutItemIn() {
	if (IsFilled()) {
		PlayFilledFeedbacks()
		return;
	}
	
	if (instance_exists(inst_inventory)) {
		with (inst_inventory) {
			UseSelectedItem();
		}
	}
}

// After operation, A
function TakeFrom() {
	
}

// Retrieve what has been put in, in case of mistake
function EmptyTransformer() {
	
}

function IsFilled() {
	return array_length(items_in_ids) == max_items;
}

function PlayFilledFeedbacks() {
}