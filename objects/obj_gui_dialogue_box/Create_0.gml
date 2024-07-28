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
has_choice = false;
loaded_choices = [];
choices_set = false;
choice_width = 300;
choice_height = 80;
choice_origin_x = x + (sprite_width * 0.5) - (choice_width * 0.5);
choices_buttons_inst = [];

function Initialize(_dialogue_id) {
	current_dialogue_data = GetDialogueData(_dialogue_id);
	// TODO: check struct
	
}

function CatchInput() {
	return !choices_set;
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
	
	_log(_dialogue_id);
	current_dialogue_data = inst_databaseLoader.dialogues[? _dialogue_id];
	if (current_dialogue_data == noone) {
		textToShow = "Dialogue not found !";
		return;
	}
	
	loaded_choices = current_dialogue_data.choices;
	has_choice = array_length(loaded_choices) > 0;

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

function OnChoiceSelected(_on_click_param) {
	choices_set = false;
	current_dialogue_data = noone;
	dialogue_progress = 0;
	
	for (var _i = array_length(choices_buttons_inst) - 1; _i >= 0; _i--)
		instance_destroy(choices_buttons_inst[_i]);
	
	Initialize(string("{0}_answer", _on_click_param));
}

function SetChoices() {
	choices_set = true;

	var nb_choices = array_length(loaded_choices);
	for (var _i = 0; _i < nb_choices; _i++)
	{
		var draw_xy = WorldToGUI(choice_origin_x, draw_talker_y - _i * (space_talker_dialogue + choice_height));
		var button_inst = instance_create_layer(draw_xy[0], draw_xy[1], "GUI", obj_gui_button);
		
		if (instance_exists(button_inst)) 
		{
			button_inst.image_xscale = choice_width / button_inst.sprite_width;
			button_inst.image_yscale = choice_height / button_inst.sprite_height;
			button_inst.depth = depth-1000;
			button_inst.on_click_param = loaded_choices[_i];
			
			var choice_text = inst_databaseLoader.localized_texts[? loaded_choices[_i]];
			if (array_length(choice_text) > 0)
				button_inst.button_text = choice_text[0].text_value;
			
			var _broadcast = Broadcast(function(_on_click_param) {
				OnChoiceSelected(_on_click_param);
			} );
			
			button_inst.on_clicked_event = _broadcast;
			
			//button_inst.on_clicked_event
			_push(choices_buttons_inst,button_inst);
		}
	}
	
}

function GoToNext() {
	dialogue_progress++;
	if (dialogue_progress >= array_length(texts_array)) {
		if (!has_choice) {
			CloseDialogue();
		}
		else
		{
			SetChoices();
		}
	}
	else {
		talker_name = current_talkers[dialogue_progress];
		textToShow = texts_array[dialogue_progress].text_value;
	}
}
