/// @description base player state
function PlayerState(_object, _args = {}): BaseState(_object, _args) constructor {
    player = object;
}



function PlayerIdleState(_player, _args = {}): PlayerState(_player, _args) constructor {
    name = "idle";
	player = _player;
	
    enter_state = function() {
		player.state = PLAYER_STATE.IDLE;
		player.sprite_index = player.playerSpr[player.state];
    }


    process_step = function() {
		// Inputs
		player.ComputeVelocityFromInputs();
		player.InteractInputCheck();
		player.CheckInputsInventory();
		
		if (!player.IsStopped() && global.player_control == true)
			transition_to(new PlayerWalkState(player));
		
		if (player.IsCooking())
			transition_to(new PlayerTransformingState(player));
			
    }
 
    some_custom_state_specific_method = function() {
        // TODO:
    }
}

function PlayerWalkState(_player, _args = {}): PlayerState(_player, _args) constructor {
    name = "walk";
	player = _player;
	
    enter_state = function() {
		player.state = PLAYER_STATE.WALKING;
		player.sprite_index = player.playerSpr[player.state];
    }

    process_step = function() {
		
       with (player) {
		   // Inputs
		   ComputeVelocityFromInputs();
		   InteractInputCheck();
			CheckInputsInventory();
			
			if (!collision_point(x + velocity_x, y, obj_static, true, true))
				x += velocity_x;
		
			if (!collision_point(x, y + velocity_y, obj_static, true, true))
				y += velocity_y;

		   UpdateFacingDirection();
		   UpdateItemInHands();
	   }
	   
	   if (player.IsCooking())
			transition_to(new PlayerTransformingState(player));
			
	   if (player.IsStopped())
			transition_to(new PlayerIdleState(player));
	}
 }

function PlayerTransformingState(_player, _args = {}): PlayerState(_player, _args) constructor {
    name = "transform";
	player = _player;
	
	feedback_value = 0;
	feedback_speed = 4;
	
    enter_state = function() {
		player.state = PLAYER_STATE.TRANSFORMING;
		player.sprite_index = player.playerSpr[PLAYER_STATE.IDLE]; // -> cooking anim
    }

    process_step = function() {
		
		if (player.CheckCookingInput()) {
			feedback_value = 0;
			player.image_blend = merge_colour(c_green, c_white, feedback_value);
		}
			
		if (feedback_value < 1) {
			feedback_value = min(feedback_value + d(feedback_speed), 1);
			player.image_blend = merge_colour(c_green, c_white, feedback_value);
		}
	   
	   if (!player.IsCooking())
			transition_to(new PlayerIdleState(player))
	}
 }
