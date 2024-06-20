on_qte_completed = noone;
current_state = noone;

function OnInit(_items_id) {
	return true;
}

function Init(_items_id) {
	if (!OnInit(_items_id)) { return; }
	
	current_state.transition_to(new QteInitializedState(id, {}));
}

function Start() {
	current_state.transition_to(new QteInProgressState(id, {}));
}

function CheckInputIsValid() {
	return true;
}

function OnInputValidated() {
	
}

function OnInputPressed() {
	if (input_get_pressed(0, "qte")) {
		if (CheckInputIsValid()) {
			OnInputValidated();
		}
	}
}

function Finish() {
	if (on_qte_completed != noone) 
		on_qte_completed.dispatch();
		
	current_state.transition_to(new QteNotReadyState(id, {}));
}

function GetProgressRatio() {
	return 1;
}

function DrawProgress() {
}

function DrawBackground() {
}

state = QTE_STATE.NOT_READY;
current_state = new QteNotReadyState(id, {});
current_state.enter_state();