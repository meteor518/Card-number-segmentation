function y = black_edge(I)
% 针对深色背景卡，检测边缘
I = double(I);
R = I(:,:,1);                   %得到RGB分量
G = I(:,:,2);
B = I(:,:,3);
[m,n] = size(R);

gray = 0.299.*R+0.587.*G+0.114.*B;    %gray为灰度图
% 
% g = fspecial('gaussian',[3 3],3);     %高斯滤波 
% gray = imfilter(input,g,'replicate');
% niter = 60;
% lambda = 0.1;
% kappa = 60;
% option = 1;
% gray = anisodiff_PM(gray,niter, kappa, lambda, option);
% figure;imshow(uint8(gray));
bw = edge(gray,'canny',0.17);
% figure;imshow(bw);
[LT,LTnum] = bwlabel(bw);
S = regionprops(LT,'all');

for i=1:LTnum
    y(i) = S(i).BoundingBox(3)*S(i).BoundingBox(4); 
end
[Max,max_index] = sort(y,'descend');
Max_index = max_index(1);
% bw1 = ismember(LT, find([S.Area]==S(Max_index).Area));
% % figure;imshow(bw1);hold on
% % [LT1,LTnum1] = bwlabel(bw1);
% % S1 = regionprops(LT1,'all');
% % for i=1:LTnum1
% %     rectangle('position',S1(i).BoundingBox,'edgecolor','r');
% %     
% %     plot(S1(i).BoundingBox(1),S1(i).BoundingBox(2),'x','LineWidth',2,'Color','yellow');
% % end 
% y = bw1;
r = 0;
for i=1:m
    for j=1:n
        if LT(i,j)==1
            r = r+1;
            rc(r,1) = i;
            rc(r,2) = j;
        end
    end
end
[value,index] = sort(rc(:,1));
r1 = value(1);
r2 = value(length(value));
[value1,index1] = sort(rc(:,2));
c1 = value(1);
c2 = value(length(value));
max_area = (r2-r1)*(c2-c1);

if Max_index > max_area*0.6            
    bw1 = ismember(LT, find([S.Area]==S(Max_index).Area));
    bw2 = 0;
else
    Max2_index = max_index(2);
    bw1 = ismember(LT, find([S.Area]==S(Max_index).Area));
    bw2 = ismember(LT, find([S.Area]==S(Max2_index).Area));
end
% figure;imshow(bw1);hold on
% [LT1,LTnum1] = bwlabel(bw1);
% S1 = regionprops(LT1,'all');
% for i=1:LTnum1
%     rectangle('position',S1(i).BoundingBox,'edgecolor','r');
%     
%     plot(S1(i).BoundingBox(1),S1(i).BoundingBox(2),'x','LineWidth',2,'Color','yellow');
% end 
y = bw1+bw2;