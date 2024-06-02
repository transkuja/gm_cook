// Inherit the parent event
event_inherited();

function OnInputPressed() {
	mash_count--;
	OnInputValidated();
}

function OnInputValidated() {
	if (mash_count <= 0)
		Finish();
}
