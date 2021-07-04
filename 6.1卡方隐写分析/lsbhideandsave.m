function [newimg, count] = lsbhideandsave(oldimg, msg, key)
    frr = fopen(msg, 'r');
    [msg, count] = fread(frr, 'ubit1');
    fclose(frr);
    newimg = oldimg;
    [m, n] = size(oldimg);
    rng(key);
    randomSeq = randperm(m * n);
    msgPtr = 1;
    imwrite(newimg, 'output\' + string(msgPtr-1) + '.png');
    for num = randomSeq
        i = idivide(num, int32(n), 'ceil');
        j = mod(num, n);
        if j == 0
            j = j + n;
        end
        if msg(msgPtr) == 1
            newimg(i, j) = bitor(newimg(i, j), 1);
        else
            newimg(i, j) = bitand(newimg(i, j), 254);
        end
        if mod(msgPtr, 5000) == 0
            imwrite(newimg, 'output\' + string(msgPtr) + '.png');
        end
        msgPtr = msgPtr + 1;
        if msgPtr > count
            break
        end
    end
    imwrite(newimg, 'output\' + string(msgPtr-1) + '.png');
end

