function msg = extractdct2(img, goalfile, key, count)
%   从dct三点法图像中提取信息
    ycbcrimg = im2double(rgb2ycbcr(img));
    ylayer = ycbcrimg(:,:,1);
    [row, col] = size(ylayer);
    row = floor(row/8);
    col = floor(col/8);
    rng(key);
    randomSeq = randperm(row*col);
    T = dctmtx(8);
    frr = fopen(goalfile, 'w');
    msg = [];
    for num = randomSeq
        i = ceil(num/col);
        j = mod(num, col);
        if j == 0
            j = j + col;
        end
        blk = T*ylayer(i*8-7:i*8, j*8-7:j*8)*T';
        if blk(5,2) > blk(4,3)
            fwrite(frr, 1, 'ubit1');
            msg = [msg; true];
            count = count - 1;
            if count == 0
                break;
            end
        elseif blk(5,2) < blk(4,3)
            fwrite(frr, 0, 'ubit1');
            msg = [msg; false];
            count = count - 1;
            if count == 0
                break;
            end
        end
    end
    fclose(frr);
end
