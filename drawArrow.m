%% ���ƴ���ͷ��ֱ��
function drawArrow(start_point, end_point,arrColor,lineColor,arrowSize,lineWidth)
% ��start_point��end_point��һ��ͷ,arrColor��ͷ��ɫ,arrSize����ͷ��С
%�жϲ�������
switch nargin
    case 2
        arrColor  = 'r';
        lineColor = 'b';
        arrowSize = 2;
        lineWidth = 1;
    case 3
        lineColor = 'b';
        arrowSize = 2;
        lineWidth = 1;
    case 4
        arrowSize = 2;
        lineWidth = 1;
    case 5
        lineWidth = 1;
end
K                = 0.05;                    % ��ͷ����ϵ��
theta            = pi / 8;                  % ��ͷ�Ƕ�
A1 = [cos(theta), -sin(theta);
    sin(theta), cos(theta)];                % ��ת����
theta = -theta;
A2 = [cos(theta), -sin(theta);
    sin(theta), cos(theta)];                % ��ת����
 
arrow           = start_point' - end_point';
%ʹ�ü�ͷ��ֱ�߳����޹�(�̶�ֵ)
arrow(arrow>=0) = arrowSize;
arrow(arrow<0)  = -arrowSize;
 
arrow_1         = A1 * arrow;
arrow_2         = A2 * arrow;
arrow_1         = K * arrow_1 + end_point'; % ��ͷ�ıߵ�x����
arrow_2         = K * arrow_2 + end_point'; % ��ͷ�ı��y����
 
hold on;
grid on;
axis equal;
plot([start_point(1), end_point(1)], [start_point(2), end_point(2)],lineColor,'lineWidth',lineWidth);
% ���Ǽ�ͷ(���)
triangle_x      = [arrow_1(1),end_point(1),arrow_2(1),arrow_1(1)];
triangle_y      = [arrow_1(2),end_point(2),arrow_2(2),arrow_1(2)];
fill(triangle_x,triangle_y,arrColor);
% �߶μ�ͷ(�����)
% plot([arrow_1(1), end_point(1)], [arrow_1(2), end_point(2)],color,'lineWidth',arrowSize);
% plot([arrow_2(1), end_point(1)], [arrow_2(2), end_point(2)], color,'lineWidth',arrowSize);
hold off;
end