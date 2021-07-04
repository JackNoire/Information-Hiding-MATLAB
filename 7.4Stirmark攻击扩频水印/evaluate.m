function score = evaluate(extract_logo, true_logo)
    extract_logo = uint8(round(extract_logo));
    wrongbit = sum(bitxor(extract_logo(:), true_logo(:)));
    [row, col] = size(true_logo);
    score = wrongbit / (row * col);
end

