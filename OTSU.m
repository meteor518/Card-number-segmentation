function out = OTSU(input)
thresh = graythresh(input);
out = im2bw(input,thresh);