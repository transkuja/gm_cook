/// @description Insert description here
// You can write your code in this editor
if (instance_exists(music_inst))
	audio_stop_sound(music_inst);
	
audio_group_stop_all(audiogroup_music);