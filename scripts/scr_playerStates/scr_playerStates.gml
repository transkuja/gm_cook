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
		player.UpdateItemInHands();
		
		if (!player.IsStopped() && global.player_control == 0 && !global.inventory_mode)
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
		   alarm[0] = 3;
		   // Inputs
		   ComputeVelocityFromInputs();
		   InteractInputCheck();
			CheckInputsInventory();
			
			//var _x_blocked = true;
			//var _y_blocked = true;
			
			//if (!collision_point(x + velocity_x, y, obj_static, true, true) && 
			//	!collision_point(x + velocity_x, y, obj_par_npc, true, true))
			//{
			//	_x_blocked = false;
			//}
		
			//if (!collision_point(x, y + velocity_y, obj_static, true, true) &&
			//	!collision_point(x, y + velocity_y, obj_par_npc, true, true))
			//{
			//	_y_blocked = false;
			//}
			
			//if (!_x_blocked)
			if (velocity_x != 0)
				x += velocity_x;
			
			if (velocity_y != 0)
				y += velocity_y;

		   UpdateFacingDirection();
		   UpdateItemInHands();
	   }
	   
	   if (player.IsCooking())
			transition_to(new PlayerTransformingState(player));
			
	   if (player.IsStopped())
			transition_to(new PlayerIdleState(player));
	}
	
	exit_state = function() {
		 player.alarm[0] = -1;
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
	   
	   if (!instance_exists(player.last_transformer_detected) || 
				player.last_transformer_detected.state == TRANSFORMER_STATE.RESULT) {
			transition_to(new PlayerIdleState(player))
		}
	}
 }
