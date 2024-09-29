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
	WAIT_FOR_PICKUP,
	RESULT
}

enum QTE_STATE {
	NOT_READY,
	INITIALIZED,
	IN_PROGRESS,
}
enum SPRITE_ORIGIN {
	TOP_LEFT,
	MIDDLE_CENTER
}

enum ITEM_TYPE {
	NONE,
	RAW_COMPO,
	TRANSFORMED_COMPO,
	HEATABLE_HOVEN,
	HEATABLE_PAN,
	RECIPE_FINAL,
	NON_TRANSFORMABLE_COMPO
}

enum INTERACTION_BLOCKED_REASON {
	WRONG_ITEMS_IN,
	NOT_FILLED
}