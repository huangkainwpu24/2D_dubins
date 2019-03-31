function plot_dubins_trajectory(start,finish,index)

dubins_class = ["LSL","RLR","LSR","RSL"];
start_arc_direction = [0,1,0,1];
finish_arc_direction = [0,1,1,0];
plot(start.x,start.y,'*b');
hold on;
plot(finish.x,finish.y,'g*');
axis([min(start.x,finish.x) - 3 * 1 / min(start.curvature,finish.curvature),max(start.x,finish.x) + 3 * 1 / min(start.curvature,finish.curvature),min(start.y,finish.y) - 3 * 1 / min(start.curvature,finish.curvature),max(start.y,finish.y) + 3 * 1 / min(start.curvature,finish.curvature)]);
drawArrow([start.x,start.y],[start.x + cos(start.direction_speed) * 2,start.y + sin(start.direction_speed) * 2],'b','b',3,2);
hold on;
drawArrow([finish.x,finish.y],[finish.x + cos(finish.direction_speed) * 2,finish.y + sin(finish.direction_speed) * 2],'g','g',3,2);
title(dubins_class(index));


rectangle('Position',[start.primary_centre_x(index) - 1 / start.curvature,start.primary_centre_y(index) - 1 / start.curvature,2 / start.curvature,2 / start.curvature],'Curvature',[1,1])
rectangle('Position',[finish.primary_centre_x(index) - 1 / finish.curvature,finish.primary_centre_y(index) - 1 / finish.curvature,2 / finish.curvature,2 / finish.curvature],'Curvature',[1,1])
hold on;

plot(start.exit_point_x(index),start.exit_point_y(index),'bo');
hold on;
plot(finish.enter_point_x(index),finish.enter_point_y(index),'go');
hold on;

%plot trajectory
[start_x,start_y] = drawTrajectory([start.x,start.y],[start.primary_centre_x(index),start.primary_centre_y(index)],1 / start.curvature,start.rotate_angle(index),start_arc_direction(index));
plot(start_x,start_y,'r','LineWidth',2);
hold on;
[finish_x,finish_y] = drawTrajectory([finish.enter_point_x(index),finish.enter_point_y(index)],[finish.primary_centre_x(index),finish.primary_centre_y(index)],1 / finish.curvature,finish.rotate_angle(index),finish_arc_direction(index));
plot(finish_x,finish_y,'r','LineWidth',2);
hold on;
line([start.exit_point_x(index),finish.enter_point_x(index)],[start.exit_point_y(index),finish.enter_point_y(index)],'Color','r','LineWidth',2);
hold on;