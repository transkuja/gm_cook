on_qte_completed = noone;
on_qte_validated = noone;

current_state = noone;
active_sequence = noone;

validate_fx_inst = noone;
transformer_x = 0;
transformer_y = 0;

function OnInit(_items_id) {
	return true;
}

function Init(_items_id, _x, _y) {
	transformer_x = _x;
	transformer_y = _y;
	
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

function OnPause() {
	
}

function Pause() {
	if (current_state)
		current_state.transition_to(new QtePausedState(id, {}));
	else
		current_state = new QtePausedState(id, {});
		
	OnPause();
}

function PlayValidateFx() {
	//if (!part_system_exists(validate_fx_inst))
		validate_fx_inst = part_system_create(fx_on_validate);
		part_system_layer(validate_fx_inst, layer_get_id("FX"));
		
	part_system_position(validate_fx_inst, transformer_x, transformer_y + fx_on_validate_offset_y);
	
}

function PlayFinishedFx() {
	validate_fx_inst = part_system_create(fx_on_finish);
	part_system_layer(validate_fx_inst, layer_get_id("FX"));
		
	part_system_position(validate_fx_inst, transformer_x, transformer_y + fx_on_finished_offset_y);
	
}

function CheckInputIsValid() {
	return true;
}

// Overridable
function OnInputValidated() {
	
}

// Not overridable
function InputValidated() {
	OnInputValidated();
	PlayValidateFx();
	
	if (on_qte_validated != noone) 
		on_qte_validated.dispatch(GetProgressRatio());
}

function OnInputFailed() {
	
}

function OnInputPressed() {
	if (input_get_pressed(0, "qte")) {
		if (CheckInputIsValid()) {
			InputValidated();
		}
		else {
			OnInputFailed();
		}
	}
}

function SpecificInputBehavior() {
}

function Finish() {
	if (on_qte_completed != noone) 
		on_qte_completed.dispatch();
		
	PlayFinishedFx();
	
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

function SetPausedFeedbacks() {
	var _s_id = layer_sequence_get_sequence(active_sequence);
	if (sequence_exists(_s_id))
	{
		layer_sequence_pause(active_sequence);
		layer_sequence_headpos(active_sequence, 0);
	}
}

function HideFeedbacks() {
	var _s_id = layer_sequence_get_sequence(active_sequence);
	if (sequence_exists(_s_id))
		layer_sequence_destroy(active_sequence);
}

function OnReset() {
}

function Reset() {
	OnReset();
	
	if (current_state)
		current_state.transition_to(new QteNotReadyState(id, {}));
	else
		current_state = new QteNotReadyState(id, {});
		
	on_qte_completed = noone;
}

state = QTE_STATE.NOT_READY;
current_state = new QteNotReadyState(id, {});
current_state.enter_state();