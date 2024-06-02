if (current_state)
	current_state.process_step();

ItemDetection();
InteractibleDetection();
TransformerDetection();
PortableItemDetection();
InteractInputCheck();
CheckInputsInventory();

if (mouse_check_button_pressed(mb_left)) {
	image_blend = c_green;
}

// Depth sorting
depth = -y;