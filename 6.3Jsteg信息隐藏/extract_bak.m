function msg = extract(img, goalfile, key, count)
    yuvimg = rgb2ycbcr(img);
    ylayer = yuvimg(:,:,1);
    ylayer = double(ylayer);
    ylayer = ylayer - 128;
    [row, col] = size(ylayer);
    rng(key);
    randomSeq = randperm(row*col);
    T = dctmtx(8);
    % 亮度亮度量化表
    lighttable=...
        [16 11 10 16 24 40 51 61 ;
        12 12 14 19 26 58 60 55 ;
        14 13 16 24 40 57 69 56 ;
        14 17 22 29 51 87 80 62 ;
        18 22 37 56 68 109 103 77;
        24 35 55 64 81 104 113 92;
        49 64 78 87 103 121 120 101;
        72 92 95 98 112 100 103 99];
    dcty = blkproc(ylayer, [8 8], "(P1*x*P2)./P3", T, T', lighttable);
    dcty = int16(round(dcty));
    frr = fopen(goalfile, 'w');
    msg = [];
    msgPtr = 1;
    
    for num=randomSeq
        i = ceil(num/col);
        j = mod(num, col);
        if j == 0
            j = j + col;
        end
        if dcty(i, j) ~= 0 && dcty(i, j) ~= 1 ...
%        && dcty(i, j) ~= -1 && dcty(i, j) ~= -2
            if mod(dcty(i, j), 2)
                fwrite(frr, 1, 'ubit1');
                msg = [msg; true];
            else
                fwrite(frr, 0, 'ubit1');
                msg = [msg; false];
            end
            msgPtr = msgPtr + 1;
            if msgPtr > count
                break;
            end
        end
    end
    
end

