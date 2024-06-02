if (current_state)
	current_state.process_step();

ItemDetection();
InteractibleDetection();
TransformerDetection();
PortableItemDetection();

// TODO: inputs should be in states step and not here

// Depth sorting
depth = -y;