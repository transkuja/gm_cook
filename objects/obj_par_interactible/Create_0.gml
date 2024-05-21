// Outline shader
handler=shader_get_uniform(shader_outline,"texture_Pixel")
handler_1=shader_get_uniform(shader_outline,"thickness_power")
handler_2=shader_get_uniform(shader_outline,"RGBA")

shader_enabled = false;

function InRangeFeedback() {
	shader_enabled = true;
}

function ResetFeedback() {
	shader_enabled = false;
}

function Interact(_interactInstigator) constructor {
	
}