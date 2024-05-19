if (current_state)
	current_state.process_step();

ItemDetection();
InteractibleDetection();
TransformerDetection();
InteractInputCheck();

// Depth sorting
depth = -y;