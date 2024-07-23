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
texts_array = array_create(0);
dialogue_progress = 0;

draw_x = view_wport[0] * 0.5;
draw_y = view_hport[0] - 200;
x = draw_x;
y = draw_y;

depth = -11000;
image_xscale = 2.0;

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
			GoToNext();
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
	if (!instance_exists(inst_databaseLoader)) {
		_log("CRITICAL ERROR: Database Loader not found ! /!\\");
	}
	
	current_dialogue_data = inst_databaseLoader.dialogues[? _dialogue_id];
	if (current_dialogue_data == noone) {
		textToShow = "Dialogue not found !";
	}
	
	texts_array = inst_databaseLoader.localized_texts[? _dialogue_id];
	if (array_length(texts_array) > 0) {
		textToShow = texts_array[0].text_value;
	}
	else
		textToShow = string("No text in dialogue id {0}!", _dialogue_id);
	
}

function CloseDialogue() {
	// TODO: add broadcast to free player and clear NPC
	instance_destroy(self);
}

function GoToNext() {
	dialogue_progress++;
	if (dialogue_progress >= array_length(texts_array)) {
		CloseDialogue();
	}
	else
		textToShow = texts_array[dialogue_progress].text_value;
}
