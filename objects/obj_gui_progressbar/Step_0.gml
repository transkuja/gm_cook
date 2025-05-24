if (delta_progress > 0)
{
    var _frame_diff = d(anim_speed);
    delta_progress -= _frame_diff;
    if (delta_progress < 0)
        progress += _frame_diff + delta_progress;
    else
        progress += _frame_diff;
    
    
    if (progress >= 1.0)
    {
        if (on_max_reached != noone)
            on_max_reached();
        
        progress -= 1;
    }
    
    if (delta_progress <= 0)
    {
        progress = target_progress;
        delta_progress = 0;
     }   
}
