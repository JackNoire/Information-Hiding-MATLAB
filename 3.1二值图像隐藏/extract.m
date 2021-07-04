function msg = extract(img_data, goalfile, key, R0, R1, lambda, count)
%extract 提取信息
    [m, n] = size(img_data);
    m = floor(m/10);
    n = floor(n/10);
    rng(key);
    randomSeq = randperm(m*n);
    frr = fopen(goalfile, 'w');
    msg = [];
    for num = randomSeq
        i = idivide(num, int32(n), 'ceil');
        j = mod(num, n);
        if j == 0
            j = j + n;
        end
        block = img_data(int32(i*10-9):int32(i*10), int32(j*10-9):int32(j*10));
        positiveNum = 0;
        for x = 1:10
            for y = 1:10
                if block(x, y) == 1
                    positiveNum = positiveNum + 1;
                end
            end
        end
        if positiveNum > 50 && positiveNum <= R1 + 2 * lambda
            fwrite(frr, 1, 'ubit1');
            msg = [msg; logical(1)];
            fprintf("Extract 1 from block %d %d %d %d\n", i*10-9, i*10, j*10-9, j*10);
            count = count - 1;
            if count == 0
                break
            end
        elseif positiveNum < 50 && positiveNum >= R0 - 2 * lambda
            fwrite(frr, 0, 'ubit1');
            msg = [msg; logical(0)];
            fprintf("Extract 0 from block %d %d %d %d\n", i*10-9, i*10, j*10-9, j*10);
            count = count - 1;
            if count == 0
                break
            end
        end
    end
    fclose(frr);
end

