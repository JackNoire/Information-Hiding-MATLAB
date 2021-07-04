function [jobj, count] = jsteg_hide(img, msg, key)
    frr = fopen(msg, 'r');
    [msg, count] = fread(frr, 'ubit1');
    fclose(frr);
    jobj = jpeg_read(img);
    dcty = jobj.coef_arrays{jobj.comp_info(1).component_id};
    [row, col] = size(dcty);
    rng(key);
    randomSeq = randperm(row*col);
    msgPtr = 1;
    for num=randomSeq
        i = ceil(num/col);
        j = mod(num, col);
        if j == 0
            j = j + col;
        end
        if dcty(i, j) ~= 0 && dcty(i, j) ~= 1
            if msg(msgPtr) == 1
                dcty(i, j) = bitor(round(dcty(i, j)), int16(1));
            else
                dcty(i, j) = bitand(round(dcty(i, j)), int16(-2));
            end
            msgPtr = msgPtr + 1;
            if msgPtr > count
                break;
            end
        end
    end
    if msgPtr <= count
        error("可用像素点不够！");
    end
    jobj.coef_arrays{jobj.comp_info(1).component_id} = dcty;
end

