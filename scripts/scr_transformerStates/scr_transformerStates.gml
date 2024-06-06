/// @description base player state
function TransformerState(_object, _args = {}): BaseState(_object, _args) constructor {
    transformer = object;
	
	process_interaction = function(_interactInstigator) {
    }
	
	process_item_take = function(_interactInstigator) {
    }
}



function TransformerEmptyState(_transformer, _args = {}): TransformerState(_transformer, _args) constructor {
    name = "empty";
	transformer = _transformer;
	
    enter_state = function() {
		transformer.state = TRANSFORMER_STATE.EMPTY;
    }


    process_step = function() {
			
    }
 
    process_interaction = function(_interactInstigator) {
        // No interaction, could eventually play feedback
    }
	
	process_item_take = function(_interactInstigator) {
        if (_itemId != "none") {
			_push(items_pending, _itemId);
			
			if (transformer.IsTransformable())
				transition_to(new TransformerCanTransformState(transformer));
			else
				transition_to(new TransformerWaitForPickupState(transformer));
		}
    }
}

function TransformerCanTransformState(_transformer, _args = {}): TransformerState(_transformer, _args) constructor {
    name = "can_transform";
	transformer = _transformer;
	
    enter_state = function() {
		transformer.state = TRANSFORMER_STATE.CAN_TRANSFORM;
		// TODO: spawn seq paused
    }


    process_step = function() {
			
    }
 
	process_draw() = function() {
		// Draw item in + progression
	}
	
	// Start transforming
    process_interaction = function(_interactInstigator) {
        if (instance_exists(_interactInstigator) && _interactInstigator.object_index == obj_player) {
			if (_interactInstigator.HasItemInHands())
				return;
		}
	
		if (array_length(items_in_ids) == max_items && IsTransformable()) {
			transformer.StartTransforming();
			transition_to(new TransformerInProgressState(transformer));
		}
    }
	
	// Take item out
	process_item_take = function(_interactInstigator) {
		if (transformer.TakeFrom(_interactInstigator))
			transition_to(new TransformerEmptyState(transformer));
    }
}

function TransformerInProgressState(_transformer, _args = {}): TransformerState(_transformer, _args) constructor {
    name = "in_progress";
	transformer = _transformer;
	
    enter_state = function() {
		transformer.state = TRANSFORMER_STATE.IN_PROGRESS;
    }


    process_step = function() {
			
    }
 
    process_interaction = function(_interactInstigator) {
        // TODO:
    }
	
	process_item_take = function(_interactInstigator) {
        // TODO:
    }
}

function TransformerWaitForPickupState(_transformer, _args = {}): TransformerState(_transformer, _args) constructor {
    name = "wait_for_pickup";
	transformer = _transformer;
	
    enter_state = function() {
		transformer.state = TRANSFORMER_STATE.WAIT_FOR_PICKUP;
    }


    process_step = function() {
			
    }
 
	// Can't interact with final item, should take it out
    process_interaction = function(_interactInstigator) {
		// feedback ?    
    }
	
	// Take item out
	process_item_take = function(_interactInstigator) {
		if (transformer.TakeFrom(_interactInstigator))
			transition_to(new TransformerEmptyState(transformer));
    }
}