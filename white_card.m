function edge_s = white_card(s)
% ���ܣ���sͼ�����Ⱦ�ֵ���ΪĿ����������Ϊ������ֵ0
% Ŀ�����ڲ���ֵΪ��ɫ�����õ���ɫ��

[m,n] = size(s);    % ͼ���С
mean_s = mean2(s);  % ȡsͼ���ֵ
% ��������ֵ��ɫ
for i=1:m
    for j=1:n
        if s(i,j)>mean_s
            s(i,j) = 255;
        else
            s(i,j) = 0;
        end
    end
end
% �����ڲ�ȫ��ֵ��ɫ
edge_s = s;
for j=1:n
    zb1 = 0;    % ÿ�б�Ե�����ϵ�
    zb2 = 0;    % ÿ�б�Ե�����µ�
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