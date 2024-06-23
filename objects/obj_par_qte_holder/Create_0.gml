on_qte_completed = noone;
current_state = noone;
active_sequence = noone;

function OnInit(_items_id) {
	return true;
}

function Init(_items_id) {
	if (!OnInit(_items_id)) { return; }
	
	if (current_state)
		current_state.transition_to(new QteInitializedState(id, {}));
	else
		current_state = new QteInitializedState(id, {});
}

function OnStart() {
}

function Start() {
	if (current_state)
		current_state.transition_to(new QteInProgressState(id, {}));
	else
		current_state = new QteInProgressState(id, {});
		
	OnStart();
}

function CheckInputIsValid() {
	return true;
}

function OnInputValidated() {
	
}

function OnInputFailed() {
	
}

function OnInputPressed() {
	if (input_get_pressed(0, "qte")) {
		if (CheckInputIsValid()) {
			OnInputValidated();
		}
		else {
			OnInputFailed();
		}
	}
}

function Finish() {
	if (on_qte_completed != noone) 
		on_qte_completed.dispatch();
		
	if (current_state)
		current_state.transition_to(new QteNotReadyState(id, {}));
	else
		current_state = new QteNotReadyState(id, {});
}

function GetProgressRatio() {
	return 1;
}

function DrawProgress() {
}

function DrawBackground() {
}


function SetFeedbacksInitialState() {
}

function SetPlayerInteractingFeedbacks() {
	var _s_id = layer_sequence_get_sequence(active_sequence);
	if (sequence_exists(_s_id))
		layer_sequence_play(active_sequence);
}

function HideFeedbacks() {
	var _s_id = layer_sequence_get_sequence(active_sequence);
	if (sequence_exists(_s_id))
		layer_sequence_destroy(active_sequence);
}

function Reset() {
	if (current_state)
		current_state.transition_to(new QteNotReadyState(id, {}));
	else
		current_state = new QteNotReadyState(id, {});
		
	on_qte_completed = noone;
}

state = QTE_STATE.NOT_READY;
current_state = new QteNotReadyState(id, {});
current_state.enter_state();