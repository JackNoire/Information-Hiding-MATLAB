function watermark = extract_watermark(newimg, originimg)
    % 作二级小波变换，取低频系数
    [C, S] = wavedec2(originimg, 2, "db1");
    oldCA = appcoef2(C, S, "db1");
    
    [C, S] = wavedec2(newimg, 2, "db1");
    newCA = appcoef2(C, S, "db1");
    
    watermark = newCA - oldCA;
end

