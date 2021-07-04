function testtextdct3(img, msg, D, quality)
    newimg = dctimghide3(img, msg, 302180148, D);
    imwrite(newimg, 'temp.jpg', 'jpg', 'quality', quality);
    testimg = imread('temp.jpg');
    extractdct3(testimg, 'test\D'+string(D)+'q'+string(quality)+'.txt', 302180148, D, 1536);
end

