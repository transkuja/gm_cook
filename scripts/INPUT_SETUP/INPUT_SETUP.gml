#region			Input manager by: Gizmo199
/* BY Creative Commons license. See "License" for information about use, adaptation, and distribution. */

	#region	V 1.1.0 - Update info
	/*
		I have added a couple of new functions! :D You can also find this and any previous
		version info in the "License" as this "region" will only be for updates to this version.
		
		Version 1.1.0 updates:
		+ "input_add" function: This function allows you to add inputs through a global script now
		
		+ global variables mouse_xprevious & mouse_yprevious
		+ mouse_get_xprevious() & mouse_get_yprevious(): Allows you to get the previous mouse x/y position
	
-->								**NOTE**								<--
			The global variables "mouse_xprevious" and "mouse_yprevious" will only be updated when these functions are called.
			If you want to have a constant global mouse_x/y previous value calculated you will need to create an object
			and in the "END STEP EVENT" add:
				_____________________________________________
				|											|
				|	mouse_xprevious = mouse_x;				|
				|	mouse_yprevious = mouse_y;				|
				|___________________________________________|
			
			or any other mouse_ function you would like. :D
			
	1.1.1 --
		+/- Fixed some documentation
	*/
	#endregion
	
#endregion
//	---------------------------------------------------------	
//				~ Table of Contents	~

#region		1) HOW TO USE
/*
Use the 'input_add' function to add inputs like so:
	
	input_add( * Input name * , * keyboard / mouse button *, * Gamepad button * );
	
BOOM! Your done! :D now all you need to do is whenever you want to call for an input you can use the functions found in the
"User Functions" folder. An example of how to use the user functions would be something like this:

	// Make player move left
	if ( input_get(0, "ui_left") ){
		x -= 4;
	}
	
	// Make player attack
	if ( input_get_pressed(0, "ui_attack") ){
		instance_create_depth(x, y, depth, obj_sword);
	}
	
Where I have "ui_left" and "ui_attack" you can change to any string value you want. You cannot use duplicate names or it
might throw an error / give you undesired results.

Included are 5 functions:

- input_add
- input_get
- input_get_pressed
- input_get_released
- input_change

input_add : adds an input with specified name and button / key press
input_get : gets the value of the input held from specific device
input_get_pressed : gets when the input is just pressed from specific device
input_get_released : gets when the input is just released from specific device


*/
#endregion
#region		2) Gamepad axis macros
/*
There are some pre-defined macro values that correlate to gamepad axis specific values.
These values determine specific directions for each gamepad axis and should be used like so:

	example 1a_______________________________________
	|												|
	| input_add("ui_down", vk_down, gp_axisL_down)	|
	|_______________________________________________|
	
	*Example 1a shows that we have created an input called "ui_down" that uses the
	keyboard arrow key down and/or the LEFT gamepad axis pointing down


The values below are all of the macro values for each directional axis input. 
	_________________________________________________
	|       macro		|	       value			|
	|_______________________________________________|
	| gp_axisL_left		| gamepad left axis left	|
	| gp_axisL_right	| gamepad left axis right	|
	| gp_axisL_down		| gamepad left axis down	|
	| gp_axisL_up		| gamepad left axis up		|
	|-----------------------------------------------|
	| gp_axisR_left		| gamepad right axis left	|
	| gp_axisR_right	| gamepad right axis right	|
	| gp_axisR_down		| gamepad right axis down	|
	| gp_axisR_up		| gamepad right axis up		|
	|_______________________________________________|


** note that if you want to set the value for the DPAD or any other gamepad button you would
	use the regular terminaology like:
	
	example 1b_______________________________________
	|												|
	| input_add("ui_down", vk_down, gp_padd)			|
	|_______________________________________________|
	
	*Examples 1b shows that we can use any of the other gamepad default values such as
	"gp_padd" to set our "ui_down" value to. Can be used with any value including "gp_face1" ect.
*/
#endregion
#region		3) Input example
/*			
This is an example of what an input scheme might look like for a platformer:

	example 2a___________________________________________
	|													|
	| input_add("ui_left", ord("A"), gp_axisL_left)		|
	| input_add("ui_right", ord("D"), gp_axisL_right)	|
	| input_add("ui_jump", vk_space, gp_face1)			|
	|___________________________________________________|
	
	*Example 2a shows an example of adding inputs for left, right, and jump for a platformer
	
*/
#endregion

//	---------------------------------------------------------

// Create our input map
//global.input_list = ds_map_create();

//// Gamepad Settings
//for ( var i=0; i<4; i++ ){
//	gamepad_set_axis_deadzone(i, 0.5);
//	gamepad_set_button_threshold(i, 0.5);
//}

//// Define your inputs:
//input_add("ui_left", ord("A"), gp_axisL_left);
//input_add("ui_right", ord("D"), gp_axisL_right);
//input_add("ui_up", ord("W"), gp_axisL_up);
//input_add("ui_down", ord("S"), gp_axisL_down);