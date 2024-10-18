/// @description Insert description here
// You can write your code in this editor

if (!ds_exists(ds_depthgrid, ds_type_grid))
	return;
	
ds_grid_sort(ds_depthgrid, 1, true);

for (var yy = 0; yy < ds_grid_height(ds_depthgrid); yy++)
{
	var inst = ds_depthgrid[# 0, yy];
	
	with(inst) { 
		draw_self();
	}
}

ds_grid_destroy(ds_depthgrid);