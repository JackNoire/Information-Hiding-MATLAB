function msg = extract(img, goalfile, key, count)
    jobj = jpeg_read(img);
    dcty = jobj.coef_arrays{jobj.comp_info(1).component_id};
    [row, col] = size(dcty);
    rng(key);
    randomSeq = randperm(row*col);
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

