function d = dct_associate(w1, w2, n)
    [row, col] = size(w1);
    w1 = dct2(w1);
    w2 = dct2(w2);
    if row > n && col > n
        w1 = w1(1:n, 1:n);
        w2 = w2(1:n, 1:n);
        w1 = reshape(w1, [1, n*n]);
        w2 = reshape(w2, [1, n*n]);
    else
        w1 = reshape(w1, [1, row*col]);
        w2 = reshape(w2, [1, row*col]);
    end
    d = abs(dot(w1, w2)) / sqrt(dot(w1, w1)) / sqrt(dot(w2, w2));
end

