
if (event_data[? "event_type"] == "sprite_event") {
	switch (event_data[? "message"]) {
		case "footstep":
			audio_play_sound(Footsteps_Parquet_05, 10, false);
			break;
		case "footstep2":
			audio_play_sound(Footsteps_Parquet_10, 10, false);
			break;
		default:
			break;
	}
}