/// @description Insert description here
// You can write your code in this editor

if (!audio_group_is_loaded(audiogroup_music))
{
    audio_group_load(audiogroup_music);
	alarm[0] = 30;
}
else 
{
	if (music_to_play != noone && music_inst == noone) {
		// TODO: should be streamed
		music_inst = audio_play_sound(music_to_play, 100, true);
	}
}
