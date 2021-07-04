function extract_plot_stirmark(name, numlist)
    load woman;
    originimg = ind2gray(X, map);
    
    [C, S] = wavedec2(originimg, 2, "db1");
    CA = appcoef2(C, S, "db1");
    CAsimilar = (1/(max(CA(:))-min(CA(:)))) * (CA-min(CA(:)));
    [U, ~, V] = svd(CAsimilar);
    
    strlegend=[];
    hold on;
    maxNum = 0;
    minNum = 1;
    for num = numlist
        filename = "test\test_" + name + "_" + string(num) + ".bmp";
        strlegend = [strlegend name+"\_"+string(num)];
        newimg = imresize(im2double(imread(filename)), [256, 256]);
        watermark = extract_watermark(newimg, originimg);
        associate_list = [];
        for i = 100:200
            guess = generate_watermark(i, U, V, 0.7, 0.7);
            appendNum = associate(guess, watermark);
            if appendNum > maxNum
                maxNum = appendNum;
            end
            if appendNum < minNum
                minNum = appendNum;
            end
            associate_list = [associate_list appendNum];
        end
        plot(100:200, associate_list, "linewidth", 1.2);
    end
    plot([148,148],[minNum-mod(minNum, 0.05),maxNum+0.1-mod(maxNum, 0.05)], ...
        '--',"Color", [0.6 0.6 0.6]);
    legend(strlegend);
    xlabel("种子值");
    ylabel("相关性");
end

