function Point = getOrderPoint(input) 
%% hough�任
% BW = edge(input,'sobel');
BW = input;
% [m,n] = size(input);
% figure,imshow(BW)
[H,T,R] = hough(BW);        %hough�任
% figure,imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');  %��ʾhough����ͼ
% xlabel('\theta'), ylabel('\rho'); 
% axis on, axis normal, hold on; 

%% ��hough�任������Ѱ��ǰ�ĸ��������ֵ0.3�ķ�ֵ
P  = houghpeaks(H,4,'threshold',ceil(0.3*max(H(:)))); 
% x = T(P(:,2)); y = R(P(:,1));   %����������ת��Ϊʵ������
% plot(x,y,'s','color','white');  %��hough����ͼ�б����ֵλ��

%% �ҵ�������ֱ��
lines = houghlines(BW,T,R,P,'FillGap',500,'MinLength',7);    %�ϲ�����С��60���߶Σ���������С��7���߶�
% figure, imshow(I), hold on 
% for k=1:length(lines)
%     xy = [lines(k).point1; lines(k).point2]; 
%     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% end

theta1 = lines(1).theta;    % ��һ���ߵ�thetaֵ
theta_dist = zeros(1,3);    % ���ڴ����һ��theta�Ĳ�ֵ
% ��������һ����theta��ֵ
for k=2:length(lines)
    theta_dist(k-1) = abs(abs(theta1)- abs(lines(k).theta));
end
% ��ֵ��С�ļ�Ϊ����ƽ�е��ߣ��ߵ���Ŵ���line1
[v,d] = sort(theta_dist);
line1 = d(1)+1;

p_index = 0;
point = zeros(4,2); % ���ڴ��ĸ���������

% �������������һ���߽���
xy = [lines(1).point1; lines(1).point2]; 
for k = 2:length(lines)  
    %% ���α������ֱ��
    if k~=line1
        xy1 = [lines(k).point1; lines(k).point2];
        
        p_index = p_index+1;
        point(p_index,:) = crossPoint(xy,xy1);
    end
end
% �������������һ��ƽ�е��ߵĽ���
xy = [lines(line1).point1; lines(line1).point2]; 
for k = 2:length(lines)  
    %% ���α������ֱ��
    if k~=line1
        xy1 = [lines(k).point1; lines(k).point2];
        % ��ʼ�˵� 
%       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow'); 
%       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red'); 
        p_index = p_index+1;
        point(p_index,:) = crossPoint(xy,xy1);
    end
end

%% �жϽ��㣬��˳ʱ�뷽��
% ���������������ҳ�ǰ������С�������������м�Ϊ���ұ߽�
% �ٸ��������жϵ��˳��
dist_id = 0;
dist = zeros(6,1);  % dist:�����е��ֵ��4������6��
for i=1:3
    p1 = point(i,:);
    for j=i+1:4
        p2 = point(j,:);
        dist_id = dist_id+1;
        dist(dist_id) = abs(double(p1(1)-p2(1)));
    end
end
[value,id] = sort(dist);    % ��ֵ����

% swith_case�������ж�ÿ�����������������
col1 = switch_case(id(1),point);    % ���ұ߽�
col2 = switch_case(id(2),point);
% �������жϣ���col�ĵ�һ��Ϊ�߽���ϵ㣬�ڶ���Ϊ�߽���µ�
% col1
if col1(1,2)<col1(2,2)
else
    temp = col1(1,:);
    col1(1,:) = col1(2,:);
    col1(2,:) = temp;
end
% col2
if col2(1,2)<col2(2,2)
else
    temp = col2(1,:);
    col2(1,:) = col2(2,:);
    col2(2,:) = temp;
end
% �Ƚ�col1 �� col2 ����С����е�λ�ã�С�������߽磬��һ�м�Ϊ��1���㣬�ڶ���Ϊ��4����
if col1(1,1)<col2(1,1)
    Point(1,:) = col1(1,:);
    Point(2:3,:) = col2;
    Point(4,:) = col1(2,:);
else
    Point(1,:) = col2(1,:);
    Point(2:3,:) = col1;
    Point(4,:) = col2(2,:);
end
% temp = Point(:,1);
% Point(:,1) = Point(:,2);    %��һ�з��кţ���ʾx�ᣬ�ڶ����кű�ʾy��
% Point(:,2) = temp;

%% �����ĸ�����
% plot(Point(1,1),Point(1,2),'+','LineWidth',2,'Color','blue'); 
% plot(Point(2,1),Point(2,2),'+','LineWidth',2,'Color','blue');
% plot(Point(3,1),Point(3,2),'+','LineWidth',2,'Color','blue');
% plot(Point(4,1),Point(4,2),'+','LineWidth',2,'Color','blue');