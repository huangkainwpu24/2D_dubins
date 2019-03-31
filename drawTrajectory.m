function [x,y] = drawTrajectory(p_s,p_center,radius,rotate_angle,direction_rotate)
%p_s:start point coordinate
%p_center:the corrdinate of center
%radius:radius of the circle
%rotate_angle:the angle need to rotate
%direction_rotate:the  direction of rotate,1 if clockwise and 0 if reverse clockwise
dx = p_s(1) - p_center(1);
dy = p_s(2) - p_center(2);
theta = mod(atan2( dy, dx ), 2*pi);
if direction_rotate == 1
    t = theta:-pi / 300:(theta - rotate_angle);
else
    t = theta:pi / 300:(theta + rotate_angle);
end
x = p_center(1) + radius * cos(t);
y = p_center(2) + radius * sin(t);
