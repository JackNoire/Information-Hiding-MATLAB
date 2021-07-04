function [newimage,count, msgPtr, tryNum] = binaryhide(cover, msg, goalfile, key, R0, R1, lambda)
%   binaryhide 将数据存进二值图
%   cover要求是二值图矩阵，msg和goalfile要求是文件名
    frr = fopen(msg, 'r');
    [msg, count] = fread(frr, 'ubit1');
    fclose(frr);
    newimage = cover;
    [m, n] = size(cover);
    m = floor(m/10);
    n = floor(n/10);
    rng(key);
    randomSeq = randperm(m * n);
    msgPtr = 1;
    tryNum = 0;
    for num = randomSeq
        i = idivide(num, int32(n), 'ceil');
        j = mod(num, n);
        if j == 0
            j = j + n;
        end
        fprintf("\nTry block %d %d %d %d\n", i*10-9, i*10, j*10-9, j*10);
        tryNum = tryNum + 1;
        [transBlock, success] = blockhide(cover(int32(i*10-9):int32(i*10), ...
                                                int32(j*10-9):int32(j*10)), ...
                                          msg(msgPtr), R0, R1, lambda);
        newimage(i*10-9:i*10, j*10-9:j*10) = transBlock;
        if success
            fprintf("Insert Number: %d\n", msgPtr);
            msgPtr = msgPtr + 1;
            if msgPtr == count + 1
                imwrite(newimage, goalfile);
                return;
            end
        else
            fprintf("failed!\n");
        end
    end
end

