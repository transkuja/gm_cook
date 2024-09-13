
// Play footstep
play_left_footstep = !play_left_footstep;
if (play_left_footstep)
	audio_play_sound(Footsteps_Parquet_05, 10, false);
else
	audio_play_sound(Footsteps_Parquet_10, 10, false);
	
alarm[0] = 3