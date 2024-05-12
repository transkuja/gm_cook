if (current_state)
	current_state.process_step();

ItemDetection();
InteractibleDetection();
InteractInputCheck();

// Depth sorting
depth = -y;