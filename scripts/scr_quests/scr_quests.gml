// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function QuestData() constructor {
	quest_id = "";
	requirements = [ { save_key : "", save_key_param : "" } ]
	initial_dialogue = ""
	accept_dialogue = ""
	refuse_dialogue = ""
    pending_dialogue = ""
    final_dialogue = ""
    quest_objectives = []
	
    //"quest_id":"quest_1",
    //"requirements":[
    //    {
    //        "save_key":"",
    //        "save_key_param":""
    //    }
    //],
    //"initial_dialogue":"",
    //"pending_dialogue":"",
    //"final_dialogue":"",
    //"quest_objectives":[]

}

function SaveQuestStatus(_quest_id, _new_status) {
	save_data_set(_quest_id, _new_status);
}

function GetQuestStatus(_quest_id) {
	q_status = save_data_get(_quest_id);
	if (is_undefined(q_status)) {
		return "not_started";
	}
		
	return q_status; // done or pending
}

function IsQuestRequirementsMet(_quest_id) {
	var _db_inst = TryGetGlobalInstance(GLOBAL_INSTANCES.DATABASE_MANAGER);
	if (!instance_exists(_db_inst)) { return false; }
	
	var q_data = _db_inst.quests[? _quest_id];
		
	// check quest valid
	if (!struct_exists(q_data, "requirements")) { return true; }
		
	for (var i = 0; i < array_length(q_data.requirements); i++) {
		if (q_data.requirements[i].save_key == "")
			continue;
			
		save_value = save_data_get(q_data.requirements[i].save_key);
		if (is_undefined(save_value)) { return false; }
			
		if (q_data.requirements[i].save_key_param != "" && q_data.requirements[i].save_key_param != save_value)
			return false;
				
	}
		
	return true;
}

function CanQuestItemBeValidated(_quest_data) {
	var _inventory = TryGetGlobalInstance(GLOBAL_INSTANCES.INVENTORY);
	if (!instance_exists(_inventory)) { return false; }
	
	if (!struct_exists(_quest_data, "quest_objectives")) { return true; }

	var item_count = array_length(_quest_data.quest_objectives);
	if (item_count == 0) 
		return true;
	
	var item_in_hand_id = "";
	
	var _player = TryGetGlobalInstance(GLOBAL_INSTANCES.PLAYER);
	if (!instance_exists(_player)) { return false; }
	if (_player.HasItemInHands())
		item_in_hand_id = _player.item_in_hands.item_id;
		
	for (var _i = 0; _i < item_count; _i++) {
		if (!_inventory.HasItem(_quest_data.quest_objectives[_i]) && item_in_hand_id != _quest_data.quest_objectives[_i])
			return false;
	}
	
	return true;
}

inst_dialogue_box = noone;
current_quest_id = "";

function SetQuestToPending() {
	SaveQuestStatus(current_quest_id, "pending");
}

function SetQuestToFinished() {
	SaveQuestStatus(current_quest_id, "done");
		
	if (!struct_exists(cur_quest_data, "quest_objectives")) { return; }
	var item_count = array_length(cur_quest_data.quest_objectives);
	if (item_count == 0) return;

	var _inventory = TryGetGlobalInstance(GLOBAL_INSTANCES.INVENTORY);
	if (!instance_exists(_inventory)) { return; }	
	
	var _player = TryGetGlobalInstance(GLOBAL_INSTANCES.PLAYER);
	if (!instance_exists(_player)) { return; }
	var item_in_hands = "";
	if (_player.HasItemInHands())
		item_in_hands = _player.item_in_hands.item_id;
	
	for (var _i = 0; _i < item_count; _i++) {
		if (item_in_hands == cur_quest_data.quest_objectives[_i])
			_player.ClearItemInHands(noone, noone);
		else
			_inventory.RemoveItem(cur_quest_data.quest_objectives[_i], 1);
	}
	
}

function PlayQuestStartingDialogue(_quest_id, _always = false) {
	PlayQuestDialogue(_quest_id, "not_started", _always);
}

function PlayQuestDialogue(_quest_id, _forced_status = "", _always = false) {
	if (!is_string(_quest_id) || _quest_id == "") { return false; }

	var quest_status = is_string(_forced_status) && _forced_status != "" ? _forced_status : GetQuestStatus(_quest_id);
	if (quest_status == "done") { return false; }

	var _db_inst = TryGetGlobalInstance(GLOBAL_INSTANCES.DATABASE_MANAGER);
	if (!instance_exists(_db_inst)) { return false; }
	
	current_quest_id = _quest_id;
	
	var cur_quest_data = _db_inst.quests[? current_quest_id];
		
	var current_dialogue_id = "";
	
	if (quest_status == "pending" && struct_exists(cur_quest_data, "pending_dialogue")) {
		current_dialogue_id = cur_quest_data.pending_dialogue;
	}
	else if (quest_status == "not_started" && struct_exists(cur_quest_data, "initial_dialogue")) {
		current_dialogue_id = cur_quest_data.initial_dialogue;
	}
	
	// Play first time only
	if (!_always && save_data_get(current_dialogue_id + "_played") != undefined)
		return;
		
	if (instance_exists(inst_dialogue_box))
		instance_destroy(inst_dialogue_box);
		
	// Create dialogue box
	inst_dialogue_box = instance_create_layer(0, 0, "GUI", obj_gui_dialogue_box);
	
	// Init with current id
	if (instance_exists(inst_dialogue_box)) {
		if (quest_status == "not_started") {
			var _accept_dialogue = "";
			var _refuse_dialogue = "";
			if (struct_exists(cur_quest_data, "accept_dialogue")) _accept_dialogue = cur_quest_data.accept_dialogue;
			if (struct_exists(cur_quest_data, "refuse_dialogue")) _refuse_dialogue = cur_quest_data.refuse_dialogue;
			
			inst_dialogue_box.Initialize(current_dialogue_id, _accept_dialogue, _refuse_dialogue, 
											Broadcast( function() { SetQuestToPending(); }) );
		}
		else if (quest_status == "pending") {
			var _final_dialogue = "";
			if (struct_exists(cur_quest_data, "final_dialogue")) _final_dialogue = cur_quest_data.final_dialogue;
			
			inst_dialogue_box.opt_no_choice = !CanQuestItemBeValidated(cur_quest_data);
			inst_dialogue_box.Initialize(current_dialogue_id, _final_dialogue, "", Broadcast(function() { SetQuestToFinished(); }));
		}
		else
			inst_dialogue_box.Initialize(current_dialogue_id);
			
		var _broadcast = Broadcast(function() {
			inst_dialogue_box = noone;
		} );
	
		inst_dialogue_box.on_dialogue_close = _broadcast;
	}
	
	return true;
}