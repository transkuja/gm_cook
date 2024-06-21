on_qte_completed = noone;
current_state = noone;
active_sequence = noone;

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

state = QTE_STATE.NOT_READY;
current_state = new QteNotReadyState(id, {});
current_state.enter_state();