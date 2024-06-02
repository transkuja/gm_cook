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
		player.ComputeVelocityFromInputs();
		
		if (!player.IsStopped() && global.player_control == true)
			transition_to(new PlayerWalkState(player));
			
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
		   ComputeVelocityFromInputs();
		   
			if (!collision_point(x + velocity_x, y, obj_static, true, true))
				x += velocity_x;
		
			if (!collision_point(x, y + velocity_y, obj_static, true, true))
				y += velocity_y;

		   UpdateFacingDirection();
		   UpdateItemInHands();
	   }
	   
	   if (player.IsStopped())
			transition_to(new PlayerIdleState(player))
	}
 }

function PlayerTransformingState(_player, _args = {}): PlayerState(_player, _args) constructor {
    name = "transform";
	player = _player;
	
    enter_state = function() {
		player.state = PLAYER_STATE.TRANSFORMING;
		player.sprite_index = player.playerSpr[player.state];
    }

    process_step = function() {
		
       with (player) {
			CheckCookingInput();
	   }
	   
	   if (!instance_exists(player.cooking_input_object))
			transition_to(new PlayerIdleState(player))
	}
 }
