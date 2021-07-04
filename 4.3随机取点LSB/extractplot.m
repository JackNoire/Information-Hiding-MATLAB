function imgplot = extractplot(img, key, count)
    [m, n] = size(img);
    rng(key);
    randomSeq = randperm(m * n);
    imgplot = cat(3, img, img, img);
    for num = randomSeq
        i = idivide(num, int32(n), 'ceil');
        j = mod(num, n);
        if j == 0
            j = j + n;
        end
        msgbit = bitand(img(i, j), 1);
        if msgbit == 1
            imgplot(i, j, :) = [255, 0, 0];
        else
            imgplot(i, j, :) = [0, 255, 0];
        end
        count = count - 1;
        if count == 0
            break
        end
    end
end

