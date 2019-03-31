function total_discrete_trajectory = dubins_types(start,finish,index)
%%
all_dubins_types = ["LSL","RSR","LSR","RSL"];
dubins_type = all_dubins_types(index);
if dubins_type == "LSL"
    %---------------------------------------------------------------------LSL-----------------------------------------------------------------------------
    clear total_discrete_trajectory;
    plot(start.x,start.y,'*b');
    hold on;
    plot(finish.x,finish.y,'g*');
    axis([min(start.x,finish.x) - 3 * 1 / min(start.curvature,finish.curvature),max(start.x,finish.x) + 3 * 1 / min(start.curvature,finish.curvature),min(start.y,finish.y) - 3 * 1 / min(start.curvature,finish.curvature),max(start.y,finish.y) + 3 * 1 / min(start.curvature,finish.curvature)]);
    drawArrow([start.x,start.y],[start.x + cos(start.direction_speed) * 2,start.y + sin(start.direction_speed) * 2],'b','b',3,2);
    hold on;
    drawArrow([finish.x,finish.y],[finish.x + cos(finish.direction_speed) * 2,finish.y + sin(finish.direction_speed) * 2],'g','g',3,2);
    title(['LSL ',num2str(1 / start.curvature)]);
    %%
    %get primary circles
    start.primary_centre_x = start.x - 1 / start.curvature * cos(start.direction_speed - pi / 2);
    start.primary_centre_y = start.y - 1 / start.curvature * sin(start.direction_speed - pi / 2);
    rectangle('Position',[start.primary_centre_x - 1 / start.curvature,start.primary_centre_y - 1 / start.curvature,2 / start.curvature,2 / start.curvature],'Curvature',[1,1])
    finish.primary_centre_x = finish.x - 1 / finish.curvature * cos(finish.direction_speed - pi / 2);
    finish.primary_centre_y = finish.y - 1 / finish.curvature * sin(finish.direction_speed - pi / 2);
    rectangle('Position',[finish.primary_centre_x - 1 / finish.curvature,finish.primary_centre_y - 1 / finish.curvature,2 / finish.curvature,2 / finish.curvature],'Curvature',[1,1])
    hold on;
    %%
    %get exit point and enter point
    alpha = asin((1 / finish.curvature - 1 / start.curvature) / sqrt((start.primary_centre_x - finish.primary_centre_x)^2 + (start.primary_centre_y - finish.primary_centre_y)^2));
    centerline_slope = atan2((finish.primary_centre_y - start.primary_centre_y) , (finish.primary_centre_x - start.primary_centre_x));
    start.turn_angle = -alpha + centerline_slope + 3 * pi / 2;
    finish.turn_angle = -alpha + centerline_slope + 3 * pi / 2;
    start.exit_point_x = start.primary_centre_x + 1 / start.curvature * cos(start.turn_angle);
    start.exit_point_y = start.primary_centre_y + 1 / start.curvature * sin(start.turn_angle);
    finish.enter_point_x = finish.primary_centre_x + 1 / finish.curvature * cos(finish.turn_angle);
    finish.enter_point_y = finish.primary_centre_y + 1 / finish.curvature * sin(finish.turn_angle);
    plot(start.exit_point_x,start.exit_point_y,'ro');
    hold on;
    plot(finish.enter_point_x,finish.enter_point_y,'go');
    hold on;
    start.rotate_angle = mod(-start.direction_speed + pi / 2 + start.turn_angle,2 * pi);
    finish.rotate_angle = mod(finish.direction_speed - pi / 2 - finish.turn_angle,2 * pi);
    %%
    %plot trajectory
    [start_x,start_y] = drawTrajectory([start.x,start.y],[start.primary_centre_x,start.primary_centre_y],1 / start.curvature,start.rotate_angle,0);
    %plot(start_x,start_y,'r','LineWidth',2);
    %hold on;
    [finish_x,finish_y] = drawTrajectory([finish.enter_point_x,finish.enter_point_y],[finish.primary_centre_x,finish.primary_centre_y],1 / finish.curvature,finish.rotate_angle,0);
    %plot(finish_x,finish_y,'r','LineWidth',2);
    %hold on;
    %line([start.exit_point_x,finish.enter_point_x],[start.exit_point_y,finish.enter_point_y],'Color','r','LineWidth',2);
    %hold on;
    %%
    %get discrete trajectory
    delta_line =pi / 100;
    theta_line = atan2((finish.enter_point_y - start.exit_point_y),(finish.enter_point_x - start.exit_point_x));
    line_discrete_x = start.exit_point_x:delta_line * cos(theta_line):finish.enter_point_x;
    line_discrete_y = start.exit_point_y:delta_line * sin(theta_line):finish.enter_point_y;
    total_discrete_trajectory(1,:) = [start_x,line_discrete_x,finish_x]; 
    total_discrete_trajectory(2,:) = [start_y,line_discrete_y,finish_y];
    plot(total_discrete_trajectory(1,:),total_discrete_trajectory(2,:),'r','LineWidth',2);
    hold on;
    %%
    %get the length of trajectory
    dubins_length.LSL = start.rotate_angle *  1 / start.curvature + sqrt((finish.enter_point_x - start.exit_point_x)^2 + (finish.enter_point_y - start.exit_point_y)^2) + finish.rotate_angle * 1 / finish.curvature;
    %text(25,40,num2str(dubins_length.LSL),'FontSize',15,'FontWeight','Bold','Color','r');
elseif dubins_type == "RSR"
    %%
    %----------------------------------------------------------------------RSR----------------------------------------------------------------------------
    clear total_discrete_trajectory;
    plot(start.x,start.y,'*b');
    hold on;
    plot(finish.x,finish.y,'g*');
    axis([min(start.x,finish.x) - 3 * 1 / min(start.curvature,finish.curvature),max(start.x,finish.x) + 3 * 1 / min(start.curvature,finish.curvature),min(start.y,finish.y) - 3 * 1 / min(start.curvature,finish.curvature),max(start.y,finish.y) + 3 * 1 / min(start.curvature,finish.curvature)]);
    drawArrow([start.x,start.y],[start.x + cos(start.direction_speed) * 2,start.y + sin(start.direction_speed) * 2],'b','b',3,2);
    hold on;
    drawArrow([finish.x,finish.y],[finish.x + cos(finish.direction_speed) * 2,finish.y + sin(finish.direction_speed) * 2],'g','g',3,2);
    title(['RSR ',num2str(1 / start.curvature)]);
    %%
    %get primary circles
    start.primary_centre_x = start.x - 1 / start.curvature * cos(start.direction_speed + pi / 2);
    start.primary_centre_y = start.y - 1 / start.curvature * sin(start.direction_speed + pi / 2);
    rectangle('Position',[start.primary_centre_x - 1 / start.curvature,start.primary_centre_y - 1 / start.curvature,2 / start.curvature,2 / start.curvature],'Curvature',[1,1])
    finish.primary_centre_x = finish.x - 1 / finish.curvature * cos(finish.direction_speed + pi / 2);
    finish.primary_centre_y = finish.y - 1 / finish.curvature * sin(finish.direction_speed + pi / 2);
    rectangle('Position',[finish.primary_centre_x - 1 / finish.curvature,finish.primary_centre_y - 1 / finish.curvature,2 / finish.curvature,2 / finish.curvature],'Curvature',[1,1])
    hold on;
    %%
    %get exit point and enter point
    alpha = asin((1 / finish.curvature - 1 / start.curvature) / sqrt((start.primary_centre_x - finish.primary_centre_x)^2 + (start.primary_centre_y - finish.primary_centre_y)^2));
    centerline_slope = atan2((finish.primary_centre_y - start.primary_centre_y) , (finish.primary_centre_x - start.primary_centre_x));
    %start.turn_angle = -alpha + centerline_slope + 3 * pi / 2;
    %finish.turn_angle = -alpha + centerline_slope + 3 * pi / 2;
    start.turn_angle = alpha + centerline_slope + pi /2;
    finish.turn_angle = alpha + centerline_slope + pi /2;
    start.exit_point_x = start.primary_centre_x + 1 / start.curvature * cos(start.turn_angle);
    start.exit_point_y = start.primary_centre_y + 1 / start.curvature * sin(start.turn_angle);
    finish.enter_point_x = finish.primary_centre_x + 1 / finish.curvature * cos(finish.turn_angle);
    finish.enter_point_y = finish.primary_centre_y + 1 / finish.curvature * sin(finish.turn_angle);
    plot(start.exit_point_x,start.exit_point_y,'ro');
    hold on;
    plot(finish.enter_point_x,finish.enter_point_y,'go');
    hold on;
    start.rotate_angle = mod(start.direction_speed + pi / 2 - start.turn_angle,2 * pi);
    finish.rotate_angle = mod(-finish.direction_speed - pi / 2 + finish.turn_angle,2 * pi);
    %%
    %plot trajectory
    [start_x,start_y] = drawTrajectory([start.x,start.y],[start.primary_centre_x,start.primary_centre_y],1 / start.curvature,start.rotate_angle,1);
    plot(start_x,start_y,'r','LineWidth',2);
    %hold on;
    [finish_x,finish_y] = drawTrajectory([finish.enter_point_x,finish.enter_point_y],[finish.primary_centre_x,finish.primary_centre_y],1 / finish.curvature,finish.rotate_angle,1);
    %plot(finish_x,finish_y,'r','LineWidth',2);
    %hold on;
    %line([start.exit_point_x,finish.enter_point_x],[start.exit_point_y,finish.enter_point_y],'Color','r','LineWidth',2);
    %hold on;
    %%
    %get discrete trajectory
    delta_line =pi / 100;
    theta_line = atan2((finish.enter_point_y - start.exit_point_y),(finish.enter_point_x - start.exit_point_x));
    line_discrete_x = start.exit_point_x:delta_line * cos(theta_line):finish.enter_point_x;
    line_discrete_y = start.exit_point_y:delta_line * sin(theta_line):finish.enter_point_y;
    total_discrete_trajectory(1,:) = [start_x,line_discrete_x,finish_x]; 
    total_discrete_trajectory(2,:) = [start_y,line_discrete_y,finish_y];
    plot(total_discrete_trajectory(1,:),total_discrete_trajectory(2,:),'r','LineWidth',2);
    hold on;
    %%
    %get the length of trajectory
    dubins_length.RSR = start.rotate_angle *  1 / start.curvature + sqrt((finish.enter_point_x - start.exit_point_x)^2 + (finish.enter_point_y - start.exit_point_y)^2) + finish.rotate_angle * 1 / finish.curvature;
    %text(25,40,num2str(dubins_length.RSR),'FontSize',15,'FontWeight','Bold','Color','r');
elseif dubins_type == "LSR"
    %%
    %----------------------------------------------------------------------LSR----------------------------------------------------------------------------
    clear total_discrete_trajectory;
    plot(start.x,start.y,'*b');
    hold on;
    plot(finish.x,finish.y,'g*');
    axis([min(start.x,finish.x) - 3 * 1 / min(start.curvature,finish.curvature),max(start.x,finish.x) + 3 * 1 / min(start.curvature,finish.curvature),min(start.y,finish.y) - 3 * 1 / min(start.curvature,finish.curvature),max(start.y,finish.y) + 3 * 1 / min(start.curvature,finish.curvature)]);
    drawArrow([start.x,start.y],[start.x + cos(start.direction_speed) * 2,start.y + sin(start.direction_speed) * 2],'b','b',3,2);
    hold on;
    drawArrow([finish.x,finish.y],[finish.x + cos(finish.direction_speed) * 2,finish.y + sin(finish.direction_speed) * 2],'g','g',3,2);
    title(['LSR ',num2str(1 / start.curvature)]);
    %%
    %get primary circles
    start.primary_centre_x = start.x - 1 / start.curvature * cos(start.direction_speed - pi / 2);
    start.primary_centre_y = start.y - 1 / start.curvature * sin(start.direction_speed - pi / 2);
    rectangle('Position',[start.primary_centre_x - 1 / start.curvature,start.primary_centre_y - 1 / start.curvature,2 / start.curvature,2 / start.curvature],'Curvature',[1,1])
    finish.primary_centre_x = finish.x - 1 / finish.curvature * cos(finish.direction_speed + pi / 2);
    finish.primary_centre_y = finish.y - 1 / finish.curvature * sin(finish.direction_speed + pi / 2);
    rectangle('Position',[finish.primary_centre_x - 1 / finish.curvature,finish.primary_centre_y - 1 / finish.curvature,2 / finish.curvature,2 / finish.curvature],'Curvature',[1,1])
    hold on;
    %%
    %get exit point and enter point
    alpha = asin((1 / finish.curvature + 1 / start.curvature) / sqrt((start.primary_centre_x - finish.primary_centre_x)^2 + (start.primary_centre_y - finish.primary_centre_y)^2));
    centerline_slope = atan2((finish.primary_centre_y - start.primary_centre_y) , (finish.primary_centre_x - start.primary_centre_x));
    start.turn_angle = alpha + centerline_slope - pi / 2;
    %finish.turn_angle = -alpha + centerline_slope + 3 * pi / 2;
    %start.turn_angle = alpha + centerline_slope + pi /2;
    finish.turn_angle = alpha + centerline_slope + pi / 2;
    start.exit_point_x = start.primary_centre_x + 1 / start.curvature * cos(start.turn_angle);
    start.exit_point_y = start.primary_centre_y + 1 / start.curvature * sin(start.turn_angle);
    finish.enter_point_x = finish.primary_centre_x + 1 / finish.curvature * cos(finish.turn_angle);
    finish.enter_point_y = finish.primary_centre_y + 1 / finish.curvature * sin(finish.turn_angle);
    plot(start.exit_point_x,start.exit_point_y,'ro');
    hold on;
    plot(finish.enter_point_x,finish.enter_point_y,'go');
    hold on;
    start.rotate_angle = mod(-start.direction_speed + pi / 2 + start.turn_angle,2 * pi);
    finish.rotate_angle = mod(-finish.direction_speed - pi / 2 + finish.turn_angle,2 * pi);
    %%
    %plot trajectory
    [start_x,start_y] = drawTrajectory([start.x,start.y],[start.primary_centre_x,start.primary_centre_y],1 / start.curvature,start.rotate_angle,0);
    %plot(start_x,start_y,'r','LineWidth',2);
    %hold on;
    [finish_x,finish_y] = drawTrajectory([finish.enter_point_x,finish.enter_point_y],[finish.primary_centre_x,finish.primary_centre_y],1 / finish.curvature,finish.rotate_angle,1);
    %plot(finish_x,finish_y,'r','LineWidth',2);
    %hold on;
    %line([start.exit_point_x,finish.enter_point_x],[start.exit_point_y,finish.enter_point_y],'Color','r','LineWidth',2);
    %hold on;
    %%
    %get discrete trajectory
    delta_line =pi / 100;
    theta_line = atan2((finish.enter_point_y - start.exit_point_y),(finish.enter_point_x - start.exit_point_x));
    line_discrete_x = start.exit_point_x:delta_line * cos(theta_line):finish.enter_point_x;
    line_discrete_y = start.exit_point_y:delta_line * sin(theta_line):finish.enter_point_y;
    total_discrete_trajectory(1,:) = [start_x,line_discrete_x,finish_x]; 
    total_discrete_trajectory(2,:) = [start_y,line_discrete_y,finish_y];
    plot(total_discrete_trajectory(1,:),total_discrete_trajectory(2,:),'r','LineWidth',2);
    hold on;
    %%
    %get the length of trajectory
    dubins_length.LSR = start.rotate_angle *  1 / start.curvature + sqrt((finish.enter_point_x - start.exit_point_x)^2 + (finish.enter_point_y - start.exit_point_y)^2) + finish.rotate_angle * 1 / finish.curvature;
    %text(25,40,num2str(dubins_length.LSR),'FontSize',15,'FontWeight','Bold','Color','r');
else
    %%
    %----------------------------------------------------------------------RSL----------------------------------------------------------------------------
    clear total_discrete_trajectory;
    plot(start.x,start.y,'*b');
    hold on;
    plot(finish.x,finish.y,'g*');
    axis([min(start.x,finish.x) - 3 * 1 / min(start.curvature,finish.curvature),max(start.x,finish.x) + 3 * 1 / min(start.curvature,finish.curvature),min(start.y,finish.y) - 3 * 1 / min(start.curvature,finish.curvature),max(start.y,finish.y) + 3 * 1 / min(start.curvature,finish.curvature)]);
    drawArrow([start.x,start.y],[start.x + cos(start.direction_speed) * 2,start.y + sin(start.direction_speed) * 2],'b','b',3,2);
    hold on;
    drawArrow([finish.x,finish.y],[finish.x + cos(finish.direction_speed) * 2,finish.y + sin(finish.direction_speed) * 2],'g','g',3,2);
    title(['RSL ',num2str(1 / start.curvature)]);
    %%
    %get primary circles
    start.primary_centre_x = start.x - 1 / start.curvature * cos(start.direction_speed + pi / 2);
    start.primary_centre_y = start.y - 1 / start.curvature * sin(start.direction_speed + pi / 2);
    rectangle('Position',[start.primary_centre_x - 1 / start.curvature,start.primary_centre_y - 1 / start.curvature,2 / start.curvature,2 / start.curvature],'Curvature',[1,1])
    finish.primary_centre_x = finish.x - 1 / finish.curvature * cos(finish.direction_speed - pi / 2);
    finish.primary_centre_y = finish.y - 1 / finish.curvature * sin(finish.direction_speed - pi / 2);
    rectangle('Position',[finish.primary_centre_x - 1 / finish.curvature,finish.primary_centre_y - 1 / finish.curvature,2 / finish.curvature,2 / finish.curvature],'Curvature',[1,1])
    hold on;
    %%
    %get exit point and enter point
    alpha = asin((1 / finish.curvature + 1 / start.curvature) / sqrt((start.primary_centre_x - finish.primary_centre_x)^2 + (start.primary_centre_y - finish.primary_centre_y)^2));
    centerline_slope = atan2((finish.primary_centre_y - start.primary_centre_y) , (finish.primary_centre_x - start.primary_centre_x));
    finish.turn_angle = -alpha + centerline_slope + 3 * pi / 2;
    start.turn_angle = -alpha + centerline_slope + pi /2;
    start.exit_point_x = start.primary_centre_x + 1 / start.curvature * cos(start.turn_angle);
    start.exit_point_y = start.primary_centre_y + 1 / start.curvature * sin(start.turn_angle);
    finish.enter_point_x = finish.primary_centre_x + 1 / finish.curvature * cos(finish.turn_angle);
    finish.enter_point_y = finish.primary_centre_y + 1 / finish.curvature * sin(finish.turn_angle);
    plot(start.exit_point_x,start.exit_point_y,'ro');
    hold on;
    plot(finish.enter_point_x,finish.enter_point_y,'go');
    hold on;
    start.rotate_angle = mod(start.direction_speed + pi / 2 - start.turn_angle,2 * pi);
    finish.rotate_angle = mod(finish.direction_speed - pi / 2 - finish.turn_angle,2 * pi);
    %%
    %plot trajectory
    [start_x,start_y] = drawTrajectory([start.x,start.y],[start.primary_centre_x,start.primary_centre_y],1 / start.curvature,start.rotate_angle,1);
    %plot(start_x,start_y,'r','LineWidth',2);
    %hold on;
    [finish_x,finish_y] = drawTrajectory([finish.enter_point_x,finish.enter_point_y],[finish.primary_centre_x,finish.primary_centre_y],1 / finish.curvature,finish.rotate_angle,0);
    %plot(finish_x,finish_y,'r','LineWidth',2);
    %hold on;
    %line([start.exit_point_x,finish.enter_point_x],[start.exit_point_y,finish.enter_point_y],'Color','r','LineWidth',2);
    %hold on;
    %%
    %get discrete trajectory
    delta_line =pi / 100;
    theta_line = atan2((finish.enter_point_y - start.exit_point_y),(finish.enter_point_x - start.exit_point_x));
    line_discrete_x = start.exit_point_x:delta_line * cos(theta_line):finish.enter_point_x;
    line_discrete_y = start.exit_point_y:delta_line * sin(theta_line):finish.enter_point_y;
    total_discrete_trajectory(1,:) = [start_x,line_discrete_x,finish_x]; 
    total_discrete_trajectory(2,:) = [start_y,line_discrete_y,finish_y];
    plot(total_discrete_trajectory(1,:),total_discrete_trajectory(2,:),'r','LineWidth',2);
    hold on;
    %%
    %get the length of trajectory
    dubins_length.RSL = start.rotate_angle *  1 / start.curvature + sqrt((finish.enter_point_x - start.exit_point_x)^2 + (finish.enter_point_y - start.exit_point_y)^2) + finish.rotate_angle * 1 / finish.curvature;
    %text(25,40,num2str(dubins_length.RSL),'FontSize',15,'FontWeight','Bold','Color','r');
end