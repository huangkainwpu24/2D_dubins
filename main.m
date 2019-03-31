clc
clear all
%%
%输入参数
start.curvature = 1 / 10;
finish.curvature = 1 / 10;

start.x = -38.8358;
start.y = -10.16;
start.direction_speed = pi / 2;
finish.x = -49.4946;
finish.y = 17.0344;
finish.direction_speed  = 0.4457;
%%
%得到最短路径
[start_all,finish_all,min_dubins_length,index,dubins_length] = dubins_trajectory(start,finish);
dubins_types(start_all,finish_all,index);
