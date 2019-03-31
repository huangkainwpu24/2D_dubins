function [start,finish,min_dubins_length,index,dubins_length] = dubins_trajectory(start,finish)
%%
%L----(-1),R----(1),circle_center_x_param(1) and circle_certer_y_param(1)
%means LSL,=====LSL,RLR,LSR,RSL=====
circle_centre_start_param = [-1,1,-1,1];
circle_centre_finish_param = [-1,1,1,-1];
exit_point_angle_param_1 = [-1,1,1,-1];
enter_point_angle_param_1 = [-1,1,1,-1];
exit_point_angle_param_2 = [3*pi/2,pi/2,-pi/2,pi/2];
enter_point_angle_param_2  = [3*pi/2,pi/2,pi/2,3*pi/2];
start_rotate_angle = [-1,1,-1,1];
finish_rotate_angle = [-1,1,1,-1];
%tangent_type-----[-1 means external tangent,1 means internally tangent]
tangent_type = [-1,-1,1,1];
dubins_length = zeros(1,4);
%%
for i = 1:1:4
    %get primary circles
    start.primary_centre_x(i) = start.x - 1 / start.curvature * cos(start.direction_speed + circle_centre_start_param(i) * pi / 2);
    start.primary_centre_y(i) = start.y - 1 / start.curvature * sin(start.direction_speed + circle_centre_start_param(i) * pi / 2);
    finish.primary_centre_x(i) = finish.x - 1 / finish.curvature * cos(finish.direction_speed + circle_centre_finish_param(i) * pi / 2);
    finish.primary_centre_y(i) = finish.y - 1 / finish.curvature * sin(finish.direction_speed + circle_centre_finish_param(i) * pi / 2);
    %get exit point and enter point
    alpha = asin((1 / finish.curvature + tangent_type(i) * 1 / start.curvature) / sqrt((start.primary_centre_x(i) - finish.primary_centre_x(i))^2 + (start.primary_centre_y(i) - finish.primary_centre_y(i))^2));
    if isreal(alpha) == 0
        dubins_length(i) = 0;
        continue;
    end
    centerline_slope = atan2((finish.primary_centre_y(i) - start.primary_centre_y(i)) , (finish.primary_centre_x(i) - start.primary_centre_x(i)));
    start.turn_angle(i) =centerline_slope + exit_point_angle_param_1(i) * alpha + exit_point_angle_param_2(i);
    finish.turn_angle(i) =centerline_slope + enter_point_angle_param_1(i) * alpha + enter_point_angle_param_2(i);
    start.exit_point_x(i) = start.primary_centre_x(i) + 1 / start.curvature * cos(start.turn_angle(i));
    start.exit_point_y(i) = start.primary_centre_y(i) + 1 / start.curvature * sin(start.turn_angle(i));
    finish.enter_point_x(i) = finish.primary_centre_x(i) + 1 / finish.curvature * cos(finish.turn_angle(i));
    finish.enter_point_y(i) = finish.primary_centre_y(i) + 1 / finish.curvature * sin(finish.turn_angle(i));
    start.rotate_angle(i) = mod(pi / 2 + start_rotate_angle(i) * (start.direction_speed - start.turn_angle(i)), 2 * pi);
    finish.rotate_angle(i) = mod(-pi / 2 + finish_rotate_angle(i) * (-finish.direction_speed + finish.turn_angle(i)), 2 * pi);
    %get the length of trajectory
    dubins_length(i) = start.rotate_angle(i) *  1 / start.curvature + sqrt((finish.enter_point_x(i) - start.exit_point_x(i))^2 + (finish.enter_point_y(i) - start.exit_point_y(i))^2) + finish.rotate_angle(i) * 1 / finish.curvature;
end
[min_dubins_length,index] = min(dubins_length(dubins_length > 0));