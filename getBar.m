function output = getBar(input,card)
%% get the card bar what we need
start = 0;
stop = 0;
[mc,nc] = size(input);
for i=1:mc
    for j=1:nc
        if input(i,j)
            start = i;
            break
        end
    end
    if start
        break
    end
end
for i=mc:-1:1
    for j=1:nc
        if input(i,j)
            stop = i;
            break
        end
    end
    if stop
        break
    end
end
if start
    output = card(start:stop,:,:);
end