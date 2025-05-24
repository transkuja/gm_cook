money = 0;
experience = 0;
level = 1;

show_debug_message(experience);

// For animation
previous_money = 0;
previous_exp = 0;
previous_level = 1;

global.game_state = self;
global.on_lvl_up = Broadcast(); // event

function GameStateInit() {
    var _subscribee = BindEvent(global.on_lvl_up, function() { LvlUp(); });
}

function AddMoney(_delta) {
    previous_money = money;
    money += _delta;
    
    SaveState();
}

function CheckEnoughMoney(_value) {
    return money >= _value;    
}

function TryPayMoney(_value) {
    if (money < _value)
        return false;
    
    previous_money = money;
    money -= _value;
    
    SaveState();
    return true;
}

function LvlUp() {
    if (experience < 100)
        return;
    
    experience -= 100;
    
    previous_level = level;
    level++;
    
    SaveState();
}

function AddXp(_delta) {
   
    show_debug_message(experience);
    
    previous_exp = experience;
    experience = experience + _delta;
    
    //if (instance_exists(inst_xp_bar))
    inst_xp_bar.AddXp(previous_exp, experience);
    
    SaveState(); 
}

function SaveState() {
    save_data_set("money", money);
    save_data_set("experience", experience);
    save_data_set("level", level);
}

function LoadState() {
    money = save_data_get("money", 0);
    experience = save_data_get("experience", 0);
    level = save_data_get("level", 1);
}