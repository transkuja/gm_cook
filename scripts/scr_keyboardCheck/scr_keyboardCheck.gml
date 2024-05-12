function CheckKeyDown(_key) {
	var _tmpKey = keyboard_lastchar;
	show_debug_message(_tmpKey + " is pressed");
	return ord(_tmpKey) == ord(_key);
}
