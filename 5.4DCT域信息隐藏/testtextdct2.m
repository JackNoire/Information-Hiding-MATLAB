function faultratio = testtextdct2(img, originmsg, msg, alpha, quality)
    newimg = dctimghide2(img, msg, 302180148, alpha);
    imwrite(newimg, 'temp.jpg', 'jpg', 'quality', quality);
    testimg = imread('temp.jpg');
    extractmsg = extractdct2(testimg, 'temp.txt', 302180148, 1536);
    faultnum = sum(bitxor(originmsg, extractmsg));
    faultratio = faultnum / 1536;
end

