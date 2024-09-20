if (music_to_play != noone && music_inst == noone) {
	// TODO: should be streamed
	music_inst = audio_play_sound(music_to_play, 100, true);
}