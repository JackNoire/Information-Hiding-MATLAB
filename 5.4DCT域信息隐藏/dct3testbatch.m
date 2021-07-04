img = imread('1.jpg');
for quality = 30:10:90
    testtextdct3(img, 'msg.txt', 0.3, quality);
end