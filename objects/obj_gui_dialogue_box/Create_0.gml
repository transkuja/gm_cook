// Textbox variables
textToShow = "J'aime pas les gros singes."
talker_name = "Jean Bomber"
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
on_dialogue_close = noone;
		
current_dialogue_data = noone;
texts_array = array_create(0);
dialogue_progress = 0;

draw_x = view_wport[0] * 0.5;
draw_y = view_hport[0] - 200;
x = draw_x;
y = draw_y;

space_talker_dialogue = 10;
offset_talker_x = 50;
draw_talker_x = draw_x - (sprite_width * image_xscale) + offset_talker_x;
draw_talker_y = draw_y - (sprite_height * 0.5) - 50 - space_talker_dialogue;

talker_name_width = 250;
talker_name_height = 50;
depth = -11000;
image_xscale = 2.0;

current_talkers = [];

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
		var nb_talkers = array_length(current_dialogue_data.talkers);
		if (nb_talkers > 0) {
			// Initialize talkers array
			for (var _i = 0; _i < nb_talkers; _i++) {
				if (_contains(current_dialogue_data.talkers[_i].used, -1)) {
					current_talkers = array_create(array_length(texts_array), current_dialogue_data.talkers[_i].name_id);
					break;
				}
			}
			
			talker_name = current_talkers[0];
		}
		
		// Set talker names at correct indexes
		if (nb_talkers > 1) {
			var nb_texts = array_length(texts_array);
			for (var _i = 0; _i < nb_talkers; _i++) {
				if (_contains(current_dialogue_data.talkers[_i].used, -1)) { continue; }
				
				var talker_indexes_count = array_length(current_dialogue_data.talkers[_i].used);
				if (talker_indexes_count <= 0) { continue; }
				
				for (var _j = 0; _j < talker_indexes_count ; _j++) {
					var cur_index = current_dialogue_data.talkers[_i].used[_j];
					if (cur_index < nb_texts)
						current_talkers[cur_index] = current_dialogue_data.talkers[_i].name_id;
				}
			}
		}
	}
	else
		textToShow = string("No text in dialogue id {0}!", _dialogue_id);
	
}

function CloseDialogue() {
	StartFadeOut();
	alarm[0] = seconds(0.5);
}

function GoToNext() {
	dialogue_progress++;
	if (dialogue_progress >= array_length(texts_array)) {
		CloseDialogue();
	}
	else {
		talker_name = current_talkers[dialogue_progress];
		textToShow = texts_array[dialogue_progress].text_value;
	}
}
