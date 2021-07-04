function extract(img, goalfile, key, count)
    [m, n] = size(img);
    rng(key);
    randomSeq = randperm(m * n);
    frr = fopen(goalfile, 'w');
    for num = randomSeq
        i = idivide(num, int32(n), 'ceil');
        j = mod(num, n);
        if j == 0
            j = j + n;
        end
        fwrite(frr, bitand(img(i, j), 1), 'ubit1');
        count = count - 1;
        if count == 0
            break
        end
    end
end

