function [newimg, count] = dctimghide3(oldimg, msg, key, D)
%   实现向彩色图像的Y层隐藏信息的dct三点法
    frr = fopen(msg, 'r');
    [msg, count] = fread(frr, 'ubit1');
    fclose(frr);
    ycbcrimg = im2double(rgb2ycbcr(oldimg));
    ylayer = ycbcrimg(:,:,1);
    [row, col] = size(ylayer);
    row = floor(row/8);
    col = floor(col/8);
    rng(key);
    randomSeq = randperm(row*col);
    msgPtr = 1;
    T = dctmtx(8);
    for num = randomSeq
        i = ceil(num/col);
        j = mod(num, col);
        if j == 0
            j = j + col;
        end
        [newblk, success] = dcthide3(ylayer(i*8-7:i*8, j*8-7:j*8), msg(msgPtr), D, T);
        ylayer(i*8-7:i*8, j*8-7:j*8) = newblk;
        if success
            msgPtr = msgPtr + 1;
            if msgPtr > count
                break;
            end
        end
    end
    if msgPtr <= count
        error('图片不够用！');
    end
    ycbcrimg(:,:,1) = ylayer;
    newimg = ycbcr2rgb(ycbcrimg);
end

