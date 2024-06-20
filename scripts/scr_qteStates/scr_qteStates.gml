/// @description base player state
function QteState(_object, _args = {}): BaseState(_object, _args) constructor {
    qte_holder = object;
	
}



function QteNotReadyState(_qte_holder, _args = {}): QteState(_qte_holder, _args) constructor {
    name = "not_ready";
	qte_holder = _qte_holder;
	
    enter_state = function() {
		qte_holder.state = QTE_STATE.NOT_READY;
		// stop sequence if any
    }
	
}

function QteInitializedState(_qte_holder, _args = {}): QteState(_qte_holder, _args) constructor {
    name = "initialized";
	qte_holder = _qte_holder;
	
    enter_state = function() {
		qte_holder.state = QTE_STATE.INITIALIZED;
		
		// stop sequence
    }

	process_draw = function() {
		// Draw progression
		qte_holder.DrawBackground(); // TODO: move method from transformer to qte_holder
		qte_holder.DrawProgress(); // TODO: same as above
	}
	
}

function QteInProgressState(_qte_holder, _args = {}): QteState(_qte_holder, _args) constructor {
    name = "in_progress";
	qte_holder = _qte_holder;
	
    enter_state = function() {
		transformer.state = QTE_STATE.IN_PROGRESS;
		
		// play sequence
    }

 	process_draw = function() {
		// Draw progression
		qte_holder.DrawBackground(); // TODO: move method from transformer to qte_holder
		qte_holder.DrawProgress(); // TODO: same as above
	}
	
    process_step = function() {
		qte_holder.OnInputPressed();
    }
	
}
