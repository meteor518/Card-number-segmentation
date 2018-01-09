clear
clc
%% 读取图像
path = 'F:\招行卡\';
num=109;
image_name = strcat(path,num2str(num),'.jpg');
I = imread(image_name);         %读取原图
[m,n] = size(I(:,:,1));         %图像大小
hsi = rgb2hsi(I);   %rgb转为hsv
s = hsi(:,:,2);     %取s分量

%% ******************倾斜矫正，并截取卡区*******************
% ****************************************************************
mean_s = mean2(s);
if mean_s>0.065
    %% white_card函数 
    % 得到白色卡，为便于边缘直线检测
    edge_s = white_card(s);
    input = edge(edge_s,'sobel');
else
    input = black_edge(I);
end
% 判断白色卡是否检测正确
% flag = isedge(edge_s);

% if flag
%     input = edge(edge_s,'sobel');
% else
%     input = black_edge(I);
% end

image_point = getOrderPoint(input);             % image_point: 图像四个角坐标
mc = 270;   % 卡的行数
nc = 428;   % 卡的列数
standard_point = [0,0;nc,0;nc,mc;0,mc]; % standard_point: 矫正后的标准四个角坐标

%% getPara函数
% 得到投影变换的系数矩阵
C = getPara(image_point,standard_point);    % C：8*1，投影变换的8个系数

%% tyTrans函数
% 根据投影系数对原图像进行投影矫正，并截取卡区
I_correct = tyTrans(I,C);   % 原图矫正后的图像
% figure;imshow(I_correct)

card = I_correct(1:mc,1:nc,:);    % 截取银行卡图像
figure;imshow(card);

card_gray = rgb2gray(card);