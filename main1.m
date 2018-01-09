clear
clc
%% ��ȡͼ��
path = 'F:\���п�\';
num=109;
image_name = strcat(path,num2str(num),'.jpg');
I = imread(image_name);         %��ȡԭͼ
[m,n] = size(I(:,:,1));         %ͼ���С
hsi = rgb2hsi(I);   %rgbתΪhsv
s = hsi(:,:,2);     %ȡs����

%% ******************��б����������ȡ����*******************
% ****************************************************************
mean_s = mean2(s);
if mean_s>0.065
    %% white_card���� 
    % �õ���ɫ����Ϊ���ڱ�Եֱ�߼��
    edge_s = white_card(s);
    input = edge(edge_s,'sobel');
else
    input = black_edge(I);
end
% �жϰ�ɫ���Ƿ�����ȷ
% flag = isedge(edge_s);

% if flag
%     input = edge(edge_s,'sobel');
% else
%     input = black_edge(I);
% end

image_point = getOrderPoint(input);             % image_point: ͼ���ĸ�������
mc = 270;   % ��������
nc = 428;   % ��������
standard_point = [0,0;nc,0;nc,mc;0,mc]; % standard_point: ������ı�׼�ĸ�������

%% getPara����
% �õ�ͶӰ�任��ϵ������
C = getPara(image_point,standard_point);    % C��8*1��ͶӰ�任��8��ϵ��

%% tyTrans����
% ����ͶӰϵ����ԭͼ�����ͶӰ����������ȡ����
I_correct = tyTrans(I,C);   % ԭͼ�������ͼ��
% figure;imshow(I_correct)

card = I_correct(1:mc,1:nc,:);    % ��ȡ���п�ͼ��
figure;imshow(card);

card_gray = rgb2gray(card);