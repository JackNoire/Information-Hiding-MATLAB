function d = associate(w1, w2)
    [row, col] = size(w1);
    w1 = reshape(w1, [1, row*col]);
    w2 = reshape(w2, [1, row*col]);
    d = abs(dot(w1, w2)) / sqrt(dot(w1, w1)) / sqrt(dot(w2, w2));
end

