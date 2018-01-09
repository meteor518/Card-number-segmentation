function Point = crossPoint(l1, l2)
% get cross point 
    a = double(l1(2,2) - l1(1,2));
    b = double(l1(2,1) - l1(1,1));
    c = double(l2(2,2) - l2(1,2));
    d = double(l2(2,1) - l2(1,1));
    if b==0
        x = l1(1,1);
        y = c/d*(x-l2(2,1))+l2(2,2);
    elseif d==0
        x = l2(1,1);
        y = a/b*(x-l1(2,1))+l1(2,2);
    else
        x = (l1(2,1) * a / b - l2(2,1) * c / d + l2(2,2) - l1(2,2)) / (a / b - c / d);
        y = a / b * (x - l1(2,1)) + l1(2,2);
    end
 Point = [x, y];