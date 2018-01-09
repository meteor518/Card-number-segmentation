function Point = getOrderPoint(input) 
%% hough变换
% BW = edge(input,'sobel');
BW = input;
% [m,n] = size(input);
% figure,imshow(BW)
[H,T,R] = hough(BW);        %hough变换
% figure,imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');  %显示hough矩阵图
% xlabel('\theta'), ylabel('\rho'); 
% axis on, axis normal, hold on; 

%% 在hough变换矩阵中寻找前四个大于最大值0.3的峰值
P  = houghpeaks(H,4,'threshold',ceil(0.3*max(H(:)))); 
% x = T(P(:,2)); y = R(P(:,1));   %由行列索引转换为实际坐标
% plot(x,y,'s','color','white');  %在hough矩阵图中标出峰值位置

%% 找到并绘制直线
lines = houghlines(BW,T,R,P,'FillGap',500,'MinLength',7);    %合并距离小于60的线段，丢弃长度小于7的线段
% figure, imshow(I), hold on 
% for k=1:length(lines)
%     xy = [lines(k).point1; lines(k).point2]; 
%     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% end

theta1 = lines(1).theta;    % 第一条线的theta值
theta_dist = zeros(1,3);    % 用于存与第一条theta的差值
% 求个现与第一条线theta差值
for k=2:length(lines)
    theta_dist(k-1) = abs(abs(theta1)- abs(lines(k).theta));
end
% 差值最小的即为与其平行的线，线的序号存入line1
[v,d] = sort(theta_dist);
line1 = d(1)+1;

p_index = 0;
point = zeros(4,2); % 用于存四个交点坐标

% 求另外两条与第一条线交点
xy = [lines(1).point1; lines(1).point2]; 
for k = 2:length(lines)  
    %% 依次标出各条直线
    if k~=line1
        xy1 = [lines(k).point1; lines(k).point2];
        
        p_index = p_index+1;
        point(p_index,:) = crossPoint(xy,xy1);
    end
end
% 求另外两条与第一条平行的线的交点
xy = [lines(line1).point1; lines(line1).point2]; 
for k = 2:length(lines)  
    %% 依次标出各条直线
    if k~=line1
        xy1 = [lines(k).point1; lines(k).point2];
        % 起始端点 
%       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow'); 
%       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red'); 
        p_index = p_index+1;
        point(p_index,:) = crossPoint(xy,xy1);
    end
end

%% 判断交点，以顺时针方向
% 按列数差搜索，找出前两个最小的列数差，则该两列即为左右边界
% 再根据行数判断点的顺序
dist_id = 0;
dist = zeros(6,1);  % dist:存所有点差值，4个点有6种
for i=1:3
    p1 = point(i,:);
    for j=i+1:4
        p2 = point(j,:);
        dist_id = dist_id+1;
        dist(dist_id) = abs(double(p1(1)-p2(1)));
    end
end
[value,id] = sort(dist);    % 差值排序

% swith_case函数，判断每个差是哪两个点相减
col1 = switch_case(id(1),point);    % 左右边界
col2 = switch_case(id(2),point);
% 根据行判断，令col的第一行为边界的上点，第二行为边界的下点
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
% 比较col1 和 col2 的最小点的列的位置，小的那条边界，第一行即为第1个点，第二行为第4个点
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
% Point(:,1) = Point(:,2);    %第一列放列号，表示x轴，第二列行号表示y轴
% Point(:,2) = temp;

%% 画出四个顶点
% plot(Point(1,1),Point(1,2),'+','LineWidth',2,'Color','blue'); 
% plot(Point(2,1),Point(2,2),'+','LineWidth',2,'Color','blue');
% plot(Point(3,1),Point(3,2),'+','LineWidth',2,'Color','blue');
% plot(Point(4,1),Point(4,2),'+','LineWidth',2,'Color','blue');