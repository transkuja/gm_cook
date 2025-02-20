/// @description base player state
function TransformerState(_object, _args = {}): BaseState(_object, _args) constructor {
    transformer = object;
	
	process_interaction = function(_interactInstigator) {
    }
	
	process_item_interaction = function(_interactInstigator) {
    }
	
	process_cancel = function(_interactInstigator) {
    }
}



function TransformerEmptyState(_transformer, _args = {}): TransformerState(_transformer, _args) constructor {
    name = "empty";
	transformer = _transformer;
	
    enter_state = function() {
		transformer.state = TRANSFORMER_STATE.EMPTY;
		transformer.CreateQteHolder();
		
		transformer.image_blend = c_white;
    }


    process_step = function() {
			
    }
 
    process_interaction = function(_interactInstigator) {
        // No interaction, could eventually play feedback
    }
	
	process_item_interaction = function(_interactInstigator) {
		if (transformer.IsFilled())
			return false;
			
		if (instance_exists(_interactInstigator) && _interactInstigator.object_index == obj_player) {
			if (!_interactInstigator.HasItemInHands())
				return false;
		}
		
		_item_id = _interactInstigator.item_in_hands.item_id;
		if (!transformer.IsItemValid(_item_id)) {
			with (_interactInstigator.item_in_hands) {
				BlockedFeedback();
			}
			//_interactInstigator.item_in_hands.BlockedFeedback();
			return false; 
		}
		
        if (_item_id != "none") {
			_push(transformer.items_pending, _item_id);
			
			var _to_subscribe = Subscriber(function() { 
				transformer.ConfirmPendingItem();
				
				if (transformer.IsTransformable())
					transition_to(new TransformerCanTransformState(transformer));
				else
					transition_to(new TransformerWaitForPickupState(transformer));
				
			} );
			
			_interactInstigator.ClearItemInHands(transformer, _to_subscribe);
		}
		
		return true;
    }
	
}

function TransformerCanTransformState(_transformer, _args = {}): TransformerState(_transformer, _args) constructor {
    name = "can_transform";
	transformer = _transformer;
	
    enter_state = function() {
		transformer.state = TRANSFORMER_STATE.CAN_TRANSFORM;
		transformer.InitializeQteHolder();
		transformer.StartAnimItems();
		
		transformer.image_blend = c_aqua;
    }

	exit_state = function() {
		transformer.StopAnimItems();
	}

    process_step = function() {
    }
 
	process_draw = function() {
		// Draw item in + progression
		transformer.DrawItemsIn();
		//transformer.DrawBackground();
		//transformer.DrawProgress();
	}
	
	// Start transforming
    process_interaction = function(_interactInstigator) {
        if (instance_exists(_interactInstigator) && _interactInstigator.object_index == obj_player) {
			if (_interactInstigator.HasItemInHands())
				return;
		}
	
		if (transformer.IsTransformable()) {
			_interactInstigator.state = PLAYER_STATE.TRANSFORMING;
			transition_to(new TransformerInProgressState(transformer));
		}
    }
	
	send_item_in = function(_interactInstigator) {
		_item_id = _interactInstigator.item_in_hands.item_id;
		if (!transformer.IsItemValid(_item_id)) { 
			with (_interactInstigator.item_in_hands) {
				BlockedFeedback();
			}
			return;
		}
		
		if (_item_id != "none") {
			_push(transformer.items_pending, _item_id);
			
			var _to_subscribe = Subscriber(function() { 
				transformer.ConfirmPendingItem();
				
				if (transformer.IsTransformable())
					transition_to(new TransformerCanTransformState(transformer));
			} );
			
			_interactInstigator.ClearItemInHands(transformer, _to_subscribe);
		}
	}
	
	// Take item out
	process_item_interaction = function(_interactInstigator) {
		if (instance_exists(_interactInstigator) && _interactInstigator.object_index == obj_player) {
			if (_interactInstigator.HasItemInHands()) {
				if (!transformer.IsFilled()) {
					send_item_in(_interactInstigator);
				}
				else
				{
					with (_interactInstigator.item_in_hands) {
						BlockedFeedback();
					}
					return false;
				}
			}
			else {
				if (transformer.TakeFrom(_interactInstigator)) {
					if (!transformer.ContainsAnItem())
						transition_to(new TransformerEmptyState(transformer));
					else {
						if (!transformer.IsTransformable())	
							transition_to(new TransformerWaitForPickupState(transformer));
					}
				}
			}
		}
		
		return true;
    }
}

function TransformerInProgressState(_transformer, _args = {}): TransformerState(_transformer, _args) constructor {
    name = "in_progress";
	transformer = _transformer;
	
    enter_state = function() {
		transformer.state = TRANSFORMER_STATE.IN_PROGRESS;
		transformer.ActivateQteHolder();
		
		transformer.image_blend = c_orange;
    }


    process_step = function() {
			
    }
 
 	process_draw = function() {
		// Draw item in + progression
		transformer.DrawItemsIn();
		//transformer.DrawBackground();
		//transformer.DrawProgress();
	}
	
    process_interaction = function(_interactInstigator) {
        //if (transformer.Progress())
		//{
		//	transformer.OnTransformationFinished();
		//	transition_to(new TransformerResultState(transformer));
		//}
    }
	
	process_item_interaction = function(_interactInstigator) {
        //if (transformer.Progress())
		//{
		//	transformer.OnTransformationFinished();
		//	transition_to(new TransformerResultState(transformer));
		//}
		
		return false;
    }
	
	process_cancel = function(_interactInstigator) {
		if (transformer.IsTransformable())
			transition_to(new TransformerCanTransformState(transformer));
		else
			transition_to(new TransformerWaitForPickupState(transformer));
    }
}

function TransformerWaitForPickupState(_transformer, _args = {}): TransformerState(_transformer, _args) constructor {
    name = "wait_for_pickup";
	transformer = _transformer;
	
    enter_state = function() {
		transformer.state = TRANSFORMER_STATE.WAIT_FOR_PICKUP;
		//transformer.image_blend = c_yellow;
    }


    process_step = function() {
			
    }
 
 	process_draw = function() {
		// Draw item in + progression
		transformer.DrawItemsIn();
	}
	
    process_interaction = function(_interactInstigator) {
		// If interact but can't, feedback
		transformer.InteractionBlockedFeedback();
    }
	
	send_item_in = function(_interactInstigator) {
		_item_id = _interactInstigator.item_in_hands.item_id;
		if (!transformer.IsItemValid(_item_id)) { 
			with (_interactInstigator.item_in_hands) {
				BlockedFeedback();
			}
			return;
		}
		
		if (_item_id != "none") {
			_push(transformer.items_pending, _item_id);
			
			var _to_subscribe = Subscriber(function() { 
				transformer.ConfirmPendingItem();
				
				if (transformer.IsTransformable())
					transition_to(new TransformerCanTransformState(transformer));
			} );
			
			_interactInstigator.ClearItemInHands(transformer, _to_subscribe);
		}
	}
	
	// Take item out
	process_item_interaction = function(_interactInstigator) {
		if (instance_exists(_interactInstigator) && _interactInstigator.object_index == obj_player) {
			if (_interactInstigator.HasItemInHands()) {
				if (!transformer.IsFilled()) {
					send_item_in(_interactInstigator);
				}
				else
				{
					with (_interactInstigator.item_in_hands) {
						BlockedFeedback();
					}
					return false;
				}
			}
			else {
				if (transformer.TakeFrom(_interactInstigator)) {
					if (!transformer.ContainsAnItem())
						transition_to(new TransformerEmptyState(transformer));
				}
			}
		}
		
		return true;
		
    }
}

function TransformerResultState(_transformer, _args = {}): TransformerState(_transformer, _args) constructor {
    name = "result";
	transformer = _transformer;
	
    enter_state = function() {
		transformer.state = TRANSFORMER_STATE.RESULT;

		transformer.image_blend = c_green;
    }


    process_step = function() {
			
    }
 
 	process_draw = function() {
		// Draw item in + progression
		transformer.DrawItemsIn();
	}
	
	function Interact(_interactInstigator) {
		if (transformer.is_interact_locked)
			return;
			
		if (instance_exists(_interactInstigator) && _interactInstigator.object_index == obj_player) {
			if (_interactInstigator.HasItemInHands()) {	return; }
		}
			
		if (transformer.TakeFrom(_interactInstigator)) {
			transition_to(new TransformerEmptyState(transformer));
		}
	}
	
	// Can't interact with final item, should take it out
    process_interaction = function(_interactInstigator) {
		Interact(_interactInstigator); 
    }
		
	// Take item out
	process_item_interaction = function(_interactInstigator) {
		Interact(_interactInstigator);
    }
}