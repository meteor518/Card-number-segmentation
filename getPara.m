function y = getPara(point1,point0)
% point1Ϊͼ����ĸ�����
% point0Ϊ��׼����
% yΪ�õ���8������c1-c8
X1 = point1(:,1);
X0 = [point0,point0(:,1).*point0(:,2),ones(4,1)];
C14 = X0\X1;    % ϵ��c1-c4

Y1 = point1(:,2);
C58 = X0\Y1;    % ϵ��c5-c8
y = [C14;C58];
