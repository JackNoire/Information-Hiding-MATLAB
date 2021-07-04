img = imread('1.jpg');
frr = fopen('msg.txt', 'r');
[originmsg, count] = fread(frr, 'ubit1');
fclose(frr);
ratiolistlist = [];
for alpha = 0.02:0.02:0.16
    ratiolist = [];
    for quality = 10:10:100
        faultratio = testtextdct2(img, originmsg, 'msg.txt', alpha, quality);
        ratiolist = [ratiolist faultratio];
    end
    ratiolistlist = [ratiolistlist; ratiolist];
end