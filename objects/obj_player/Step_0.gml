if (current_state)
	current_state.process_step();

ItemDetection();
InteractibleDetection();
TransformerDetection();
PortableItemDetection();

// TODO: inputs should be in states step and not here

// Depth sorting
//if (x > min_x_depth_sorting && x < max_x_depth_sorting 
//	&& y > min_y_depth_sorting && y < max_y_depth_sorting)
//	depth = 1;
//else
	//depth = -y;

if (depth_override)
	depth = depth_override_value;
else
	depth = -y;
	
CheckEnviroAround();

if (sprinting && (abs(velocity_x) > 10 || abs(velocity_y) > 10))
{
	CreateTrailParticle();
}
