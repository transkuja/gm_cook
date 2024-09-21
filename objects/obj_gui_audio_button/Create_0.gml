hovering_last_frame = false;
hovering = false;
clicked = false;

sound_state = 0;
option_save_key = is_music ? "option_music" : "option_sfx";

function ApplySoundSetting() {
	if (is_music) {
		audio_group_set_gain(audiogroup_music, 1 - sound_state, 0);
	}
	else {
		audio_group_set_gain(audiogroup_default, 1 - sound_state, 0);
	}
}

function HandleSave() {
	var _option_value = save_data_get(option_save_key);
	if (_option_value != undefined) {
		sound_state = _option_value;
		ApplySoundSetting();
	}
}

alarm[0] = 5; // Calls handleSave()