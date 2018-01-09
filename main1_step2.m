bw = OTSU(card_gray);
% figure;imshow(bw);
% hold on
bw = edge(bw,'sobel');  % edge detect
% figure;imshow(bw);
se = strel('square',3);
bw = imdilate(bw,se);
% figure;imshow(bw);hold on

%% select digital number areas
bw = bwareaopen(bw,15);
[LT,LTnum] = bwlabel(bw);
S = regionprops(LT);
% for i=1:LTnum
%     rectangle('position',S(i).BoundingBox,'edgecolor','r');
%     
%     plot(S(i).BoundingBox(1),S(i).BoundingBox(2),'x','LineWidth',2,'Color','yellow');
% end 
%% get card number bar
bw1 = 0;
for i=1:LTnum
%     if S(i).BoundingBox(4)>=0.07*mc && S(i).BoundingBox(4)<0.12*mc  
        if S(i).BoundingBox(2)>=0.48*mc && (S(i).BoundingBox(2)+S(i).BoundingBox(4))<=0.65*mc
            bw11 = ismember(LT, i);
            bw1 = bw1+bw11;
        end
%     end
end
% figure;imshow(bw1);
card_digitalNum = getBar(bw1,card);
%figure;imshow(card_digitalNum);