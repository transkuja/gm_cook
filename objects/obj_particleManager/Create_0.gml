global.pt_flare_particles = part_type_create();

part_type_shape(global.pt_flare_particles, pt_shape_sphere);

part_type_size(global.pt_flare_particles, 0.30, 0.30, 0, 0);

part_type_scale(global.pt_flare_particles, 3, 1);

part_type_orientation(global.pt_flare_particles, 0, 0, 0, 0, 0);

part_type_color3(global.pt_flare_particles, 16777215, 16776960, 16776960);

part_type_alpha3(global.pt_flare_particles, 1, 1, 0);

part_type_blend(global.pt_flare_particles, 1);

part_type_life(global.pt_flare_particles, 30, 30);

part_type_speed(global.pt_flare_particles, 0, 0, 0, 0);

part_type_direction(global.pt_flare_particles, 0, 360, 0, 0);

part_type_gravity(global.pt_flare_particles, 0, 0); 

global.ps_above = part_system_create();