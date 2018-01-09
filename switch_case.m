function y = switch_case(x,point)
switch x
    case 1
        y = [point(1,:);point(2,:)];
    case 2
        y = [point(1,:);point(3,:)];
    case 3
        y = [point(1,:);point(4,:)];
    case 4
        y = [point(2,:);point(3,:)];
    case 5
        y = [point(2,:);point(4,:)];
    case 6
        y = [point(3,:);point(4,:)];
end
