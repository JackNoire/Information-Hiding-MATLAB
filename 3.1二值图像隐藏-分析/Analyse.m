img = imread('2.jpg');
img = im2bw(img);
x = 40:49;
yrect = [];
for lambda = 2:7
    y = [];
    for R0 = x
        [newimage, count, msgPtr, tryNum] = binaryhide(img, 'shortmsg.txt', 'test.png', 19283746, R0, 100-R0, lambda);
        y = [y tryNum];
    end
    yrect = [yrect; y];
end