function J = tyTrans(I,C)
% I为待投影变换图像
% C为投影矩阵系数
[m,n] = size(I(:,:,1));
for i=1:m
    for j=1:n
        j11 = C(1)*j+C(2)*i+C(3)*i*j+C(4);  % 投影变换后的坐标
        i11 = C(5)*j+C(6)*i+C(7)*i*j+C(8);
        j1 = round(j11);    % 四舍五入最近邻插值
        i1 = round(i11);
        
        if i1>0 && i1<m && j1>0 && j1<n
            I(i,j,1) = I(i1,j1,1);      % 投影后的坐标在原图中，则将（i1,j1）赋值给（i,j）
            I(i,j,2) = I(i1,j1,2);
            I(i,j,3) = I(i1,j1,3);
        else
            I(i,j,1) = 255;             % 投影后的坐标若超出原图，则将（i,j）赋值白色
            I(i,j,2) = 255;
            I(i,j,3) = 255;
        end
    end
end
J = I;
