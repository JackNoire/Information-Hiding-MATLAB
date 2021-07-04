diary('log.txt');
img = imread('2.jpg');
img = im2bw(img);
imwrite(img, '2_b.jpg');
[newimage, count, msgPtr, tryNum] = binaryhide(img, 'msg.txt', 'test.png', 19283746, 45, 55, 4);
img = logical(im2bw(imread('test.png')));
extractmsg = extract(img, 'extract.txt', 19283746, 45, 55, 4, 336);