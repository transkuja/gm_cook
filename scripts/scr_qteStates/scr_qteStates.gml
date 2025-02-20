/// @description base player state
function QteState(_object, _args = {}): BaseState(_object, _args) constructor {
    qte_holder = object;
	
}



function QteNotReadyState(_qte_holder, _args = {}): QteState(_qte_holder, _args) constructor {
    name = "not_ready";
	qte_holder = _qte_holder;
	
    enter_state = function() {
		qte_holder.state = QTE_STATE.NOT_READY;
		qte_holder.HideFeedbacks();
    }
	
}

function QteInitializedState(_qte_holder, _args = {}): QteState(_qte_holder, _args) constructor {
    name = "initialized";
	qte_holder = _qte_holder;
	
    enter_state = function() {
		qte_holder.state = QTE_STATE.INITIALIZED;
		qte_holder.SetFeedbacksInitialState();
    }

	process_draw = function() {
		// Draw progression
		qte_holder.DrawBackground();
		qte_holder.DrawProgress();
	}
	
}

function QteInProgressState(_qte_holder, _args = {}): QteState(_qte_holder, _args) constructor {
    name = "in_progress";
	qte_holder = _qte_holder;
	was_input_pressed = false;
	
    enter_state = function() {
		qte_holder.state = QTE_STATE.IN_PROGRESS;
		qte_holder.SetPlayerInteractingFeedbacks();
		was_input_pressed = input_get_pressed(0, "qte");
    }

 	process_draw = function() {
		// Draw progression
		qte_holder.DrawBackground();
		qte_holder.DrawProgress();
	}
	
    process_step = function() {
		// Prevent taking the input from interacting with transformer
		if (was_input_pressed) {
			was_input_pressed = false;
			return;
		}
		
		qte_holder.OnInputPressed();
		qte_holder.SpecificInputBehavior();
    }
	
}

function QtePausedState(_qte_holder, _args = {}): QteState(_qte_holder, _args) constructor {
    name = "in_progress";
	qte_holder = _qte_holder;
	
    enter_state = function() {
		qte_holder.state = QTE_STATE.PAUSED;
		qte_holder.SetPausedFeedbacks();
    }

 	process_draw = function() {
		// Draw progression
		qte_holder.DrawBackground();
		qte_holder.DrawProgress();
	}
	
}
