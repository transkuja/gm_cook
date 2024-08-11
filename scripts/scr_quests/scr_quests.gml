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
	if (!instance_exists(inst_databaseLoader)) { return false; }
	
	var q_data = inst_databaseLoader.quests[? _quest_id];
		
	// check quest valid
	if (!struct_exists(q_data, "requirements")) { return; }
		
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