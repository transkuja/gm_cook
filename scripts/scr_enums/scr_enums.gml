enum PLAYER_STATE {
	IDLE,
	WALKING,
	TRANSFORMING
}

// Directions
enum DIRECTION_ENUM
{
	UP,
	DOWN,
	LEFT,
	RIGHT
}

// Fade states
enum FADE_STATE {
	IDLE,
	FADE_IN,
	FADE_OUT,
}

// Preparation enum
enum PREPARATION_TYPE {
	CHOP,
	PAN_COOK,
	HOVEN_COOK,
	ASSEMBLE,
	PEEL // or mix idk yet
}

enum TRANSFORMER_STATE {
	EMPTY,
	CAN_TRANSFORM,
	IN_PROGRESS,
	WAIT_FOR_PICKUP
}