function y = getPara(point1,point0)
% point1为图像的四个顶点
% point0为标准顶点
% y为得到的8个参数c1-c8
X1 = point1(:,1);
X0 = [point0,point0(:,1).*point0(:,2),ones(4,1)];
C14 = X0\X1;    % 系数c1-c4

Y1 = point1(:,2);
C58 = X0\Y1;    % 系数c5-c8
y = [C14;C58];
