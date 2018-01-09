function edge_s = white_card(s)
% 功能：对s图像处理，比均值大的为目标区，否则为背景赋值0
% 目标区内部赋值为白色，即得到白色卡

[m,n] = size(s);    % 图像大小
mean_s = mean2(s);  % 取s图像均值
% 将背景赋值黑色
for i=1:m
    for j=1:n
        if s(i,j)>mean_s
            s(i,j) = 255;
        else
            s(i,j) = 0;
        end
    end
end
% 将卡内部全赋值白色
edge_s = s;
for j=1:n
    zb1 = 0;    % 每列边缘坐标上点
    zb2 = 0;    % 每列边缘坐标下点
    for i=1:m
        if s(i,j)~=0
            zb1 = i;
            break
        end
    end
    if zb1
        for i=m:-1:1
            if s(i,j)~=0
                zb2 = i;
                break
            end
        end
        edge_s(zb1:zb2,j) = 255;
    end
end