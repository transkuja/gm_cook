tuto_enabled = true;
button_inst = noone;
save_key = "tuto";

is_init = false;

function OnClicked() {
	tuto_enabled = !tuto_enabled;
	if (tuto_enabled) {
		button_inst.button_text = "Hide tuto";
	}
	else {
		button_inst.button_text = "Show tuto";
	}
	
	save_data_set(save_key, true);
}

function CreateButton() {
	button_inst = instance_create_layer(x, y, "GUI", obj_gui_button);
	if (instance_exists(button_inst)) {
		button_inst.image_xscale = 200 / button_inst.sprite_width;
		button_inst.image_yscale = 70 / button_inst.sprite_height;
		button_inst.depth = -10000;
			
		if (tuto_enabled) {
			button_inst.button_text = "Hide tuto";
		}
		else {
			button_inst.button_text = "Show tuto";
		}
		
		button_inst.on_clicked_event = Broadcast(function(_on_click_param) { OnClicked(); });
	}
	
}

function Init() {
	if (save_data_get(save_key) != undefined)
		tuto_enabled = !save_data_get(save_key);
	
	CreateButton();
	
	is_init = true;
}

// Delayed init
alarm[0] = 5;