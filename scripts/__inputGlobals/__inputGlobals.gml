#macro gp_axisL_up 0
#macro gp_axisL_down 1
#macro gp_axisL_left 2
#macro gp_axisL_right 3

#macro gp_axisR_up 4
#macro gp_axisR_down 5
#macro gp_axisR_left 6
#macro gp_axisR_right 7

globalvar __llt, __lrt, __lut, __ldt, __rlt, __rrt, __rdt, __rut, 
__lltp, __lrtp, __lutp, __ldtp, __rltp, __rrtp, __rdtp, __rutp;
__llt=false; __lltp=false; __lrt=false; __lrtp=false;
__ldt=false; __ldtp=false; __lut=false; __lutp=false;
__rlt=false; __rltp=false; __rrt=false; __rrtp=false;
__rdt=false; __rdtp=false; __rut=false; __rutp=false;

globalvar mouse_xprevious, mouse_yprevious;
mouse_xprevious = device_mouse_x(0);
mouse_yprevious = device_mouse_y(0);