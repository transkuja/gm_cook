// Init fade values
event_perform_object(obj_fading, ev_create, 0);
fadeMe = 1; // don't fade immediately

counter = "20/20";

count = 0;

text_color = make_color_rgb(251, 208, 77);	

if (!in_menu)
{
	image_xscale = 5;
	image_yscale = 3;
	
	draw_x = view_wport[0] * 0.5 - (sprite_width * 0.5);
	draw_y = view_hport[0] * 0.5 - 300 - (sprite_height * 0.5);
	x = draw_x;
	y = draw_y;
}


// TODO: put bump anim into reusable script ??

anim_txt_scale_x = 0;
anim_txt_scale_y = 0;
can_kill = false;

function Initialize() {
	var _save_manager = save_get_manager();
	if (is_undefined(_save_manager))
	{
		instance_destroy();
		return;
	}
	
	var recipes_unlocked = _save_manager.get_all_key_containing("_unlocked");
	count = array_length(recipes_unlocked);
	
	if (in_menu && count == 0)
	{
		instance_destroy();
		return;
	}
	
	counter = string(count) + "/20";
	
	if (in_menu)
		return;
		
	image_alpha = 1;

	alarm[0] = seconds(0.75);
}

cur_anim = noone;
bump_anim_speed = 0.1;

function BumpCounter() {
	if (cur_anim != noone)
		return;
	
	instance_destroy(cur_anim);
	anim_txt_scale_x = 0;
	anim_txt_scale_y = 0;
	
	var _text_sa_x = new polarca_animation("anim_txt_scale_x", 0.25, ac_bump_scale_up_uniform, 0, bump_anim_speed);
	var _text_sa_y = new polarca_animation("anim_txt_scale_y", 0.25, ac_bump_scale_up_uniform, 0, bump_anim_speed);
	
	cur_anim = polarca_animation_start([_text_sa_x, _text_sa_y]);
	
	count++;
	counter = string(count) + "/20";
	
	audio_play_sound(Menu_Sound_Forward, 10, false);
	
	alarm[1] = seconds(1.5);
}

if (in_menu)
	Initialize();