event_inherited();

function StartTransforming() {
	// TODO: spawn object handling input + sequence for QTE gameplay (R&D)
	if (array_length(items_in_ids) > 0)
		items_in_ids[0] = GetChoppedResult(items_in_ids[0]);
}