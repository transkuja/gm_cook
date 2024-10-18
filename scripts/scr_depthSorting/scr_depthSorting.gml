
function AddToDepthGrid() {
	if (instance_number(obj_depthSorterTest) == 0)
		return;
	
	depthSorter = instance_find(obj_depthSorterTest, 0);
	
	with (depthSorter) {
		if (!ds_exists(ds_depthgrid, ds_type_grid)) {
			ds_depthgrid = ds_grid_create(2,1);
	
			ds_depthgrid[# 0,0] = other; // instance calling the script
	
			ds_depthgrid[# 1,0] = other.y;
		}
		else
		{
			var heightOfGrid = ds_grid_height(ds_depthgrid);
			ds_grid_resize(ds_depthgrid, 2, heightOfGrid + 1);
		
			ds_depthgrid[# 0,heightOfGrid] = other; // instance calling the script
	
			ds_depthgrid[# 1,heightOfGrid] = other.y;
		
		}
	
	}
}