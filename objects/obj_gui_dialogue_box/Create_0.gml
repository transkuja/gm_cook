// Textbox variables
textToShow = "J'aime pas les gros singes."
textWidth = 450;
lineHeight = 28;

// Stop player on open
global.player_control = false;

// Init fade values
event_perform_object(obj_fading, ev_create, 0);

// Play UI sound
//audio_play_sound(snd_pop01,1,0);

//function acts_as(){
//	gml_pragma("forceinline");
//	event_object_perform(argument0, event_type, event_number);
//}

current_dialogue_data = noone;
function Initialize(_dialogue_id) {
	current_dialogue_data = GetDialogueData(_dialogue_id);
	// TODO: check struct
	
}

function CatchInput() {
	return true;
}

function HandleInput() {
	if (CatchInput()) {
		if (input_get_pressed(0, "ui_validate")) {
			
		}
	}
}

function GetText(_id, _loc_code) {
	
}

// Dialogue data structure
// dialogue_id, line_count, talkers 
// talkers: "name_id" and "used" array. if used = -1, then talker used for any line without talker
// choices: array, pops at the end of dialogue. Contains 2 text_id
// --------- text_id is used to get localized text to display choice
// --------- upon selection, look for [text_id]_selected in DialogueData
// Might have an issue if don't want to have a dialogue AFTER selection
function GetDialogueData(_dialogue_id) {
	
}

function GoToNext() {
	
}
