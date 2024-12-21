// Textbox variables
textToShow = "J'aime pas les gros singes."
talker_name = "Jean Bomber"
textWidth = 850;
lineHeight = 40;

// Stop player on open
global.player_control--;

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
current_id = "";
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
choice_width = 350;
choice_height = 80;
choice_origin_x = x + (sprite_width * 0.5) - (choice_width * 0.5);
choices_buttons_inst = [];

on_choice_selected = [];
// If set to true, will skip the choice of the current dialogue. Must be set before Initialize.
opt_no_choice = false;

// TO DELETE
show_extra_sprite = false;
can_go_to_next = true;
putaing_kong = false;

function HandleTextAppearSound() {
	audio_stop_sound(sound_inst);
	show_extra_sprite = false;
	putaing_kong = false;
	can_go_to_next = false;
	alarm[1] = 15;

	var lower_text = string_lower(textToShow);
	if (lower_text == "...")
		return;
		
	if (string_pos("zzzz", lower_text) != 0) {
		sound_inst = audio_play_sound(snore_sound, 10, false);
		return;
	}
	
	if (string_pos("*crunch*", lower_text) != 0) {
		sound_inst = audio_play_sound(crunch_sound, 10, false);
		return;
	}
	
	if (string_pos("*burp*", lower_text) != 0) {
		sound_inst = audio_play_sound(burp_sound, 10, false);
		return;
	}
	
	if (string_pos("*pro", lower_text) != 0) {
		sound_inst = audio_play_sound(fart_sound, 10, false);
		return;
	}
	
	if (string_pos("oh putaing kong", lower_text) != 0) {
		textToShow = string_upper(textToShow);
		putaing_kong = true;
		sound_inst = audio_play_sound(snd_monkey, 10, false);
		return;
	}
	
	if (string_pos("one piece le 28 octobre", lower_text) != 0) {
		audio_play_sound(goodresult_sound, 10, false);
		show_extra_sprite = true;

		alarm[1] = 90;
	}

	var char_count = string_length(textToShow);
	if (char_count < 50)
		sound_inst = audio_play_sound(snd_text_appear, 10, false, 1, random_range(5, 6));
	else if (char_count < 100)
		sound_inst = audio_play_sound(snd_text_appear, 10, false, 1, random_range(3, 4));
	else
		sound_inst = audio_play_sound(snd_text_appear, 10, false);
}

function Initialize(_dialogue_id, _choice_positive_id = "", _choice_negative_id = "", _on_choice_pos_selected = noone, _on_choice_neg_selected = noone) {
	GetDialogueData(_dialogue_id);
	current_id = _dialogue_id;
	
	if (current_dialogue_data == noone || current_dialogue_data == undefined) {
		CloseDialogue();
		return;
	}
	
	on_choice_selected = [];
	if (!has_choice || opt_no_choice)
		return;
		
	// Bypass choices from external source and not use data from dialogue (to avoid multiple chained dialogues)
	var _next_dialogue_pos = _choice_positive_id;
	var _next_dialogue_neg = _choice_negative_id;
	
	// If no override, use default suffixe answer to look for dialogue
	if (_next_dialogue_pos == "" && array_length(loaded_choices) > 0) 
		_next_dialogue_pos = string("{0}_ans", loaded_choices[0]);
		
	if (_next_dialogue_neg == "" && array_length(loaded_choices) > 1) 
		_next_dialogue_neg = string("{0}_ans", loaded_choices[1]);
		
	_push(on_choice_selected, { next_dialogue : _next_dialogue_pos, on_select : _on_choice_pos_selected });
	_push(on_choice_selected, { next_dialogue : _next_dialogue_neg, on_select : _on_choice_neg_selected });
	
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
	
	_log("Check dialogue from DB:", _dialogue_id);
	current_dialogue_data = inst_databaseLoader.dialogues[? _dialogue_id];
	if (current_dialogue_data == noone || current_dialogue_data == undefined) {
		_log(string("Dialogue {0} not found !", _dialogue_id));
		return;
	}
	
	if (struct_exists(current_dialogue_data, "choices"))
		loaded_choices = current_dialogue_data.choices;
	else 
		loaded_choices = [];
		
	has_choice = array_length(loaded_choices) > 0;

	texts_array = inst_databaseLoader.localized_texts[? _dialogue_id];
	if (array_length(texts_array) > 0) {
		textToShow = texts_array[0].text_value;
		HandleTextAppearSound();
		
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
	audio_stop_sound(sound_inst);
	StartFadeOut();
	save_data_set(current_id + "_played", true);
	alarm[0] = seconds(0.5);
}

function OnChoiceSelected(_on_click_param) {
	choices_set = false;
	current_dialogue_data = noone;
	dialogue_progress = 0;
	
	for (var _i = array_length(choices_buttons_inst) - 1; _i >= 0; _i--)
		instance_destroy(choices_buttons_inst[_i]);
	
	// Call choice delegate set from dialogue caller
	if (struct_exists(_on_click_param, "on_select")) {
		if (_on_click_param.on_select != noone)
			_on_click_param.on_select.dispatch();
	}
	
	if (struct_exists(_on_click_param, "next_dialogue"))
	{
		save_data_set(current_id + "_played", true);
		Initialize(_on_click_param.next_dialogue);
	}
	else
		CloseDialogue()
}

function SetChoices() {
	if (opt_no_choice)
		return;
		
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
			button_inst.on_click_param = on_choice_selected[_i];
			
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

sound_inst = noone;
function GoToNext() {
	if (!can_go_to_next) return;
	
	audio_play_sound(FUI_Button_Beep_Clean, 10, false);
	
	dialogue_progress++;
	if (dialogue_progress >= array_length(texts_array)) {
		if (!has_choice || opt_no_choice) {
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
		HandleTextAppearSound();
	}
}
