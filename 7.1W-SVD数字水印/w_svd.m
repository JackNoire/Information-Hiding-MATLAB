function [newimg, watermark] = w_svd(img, key, dovern, alpha)
    % 作二级小波变换，取低频系数
    [C, S] = wavedec2(img, 2, "db1");
    CA = appcoef2(C, S, "db1");
    CAsimilar = (1/(max(CA(:))-min(CA(:)))) * (CA-min(CA(:)));
    [U, sigma, V] = svd(CAsimilar);
    % 生成水印
    watermark = generate_watermark(key, U, V, dovern, alpha);
    % 将水印加入低频系数
    newCA = CA + watermark;
    % 将新的低频系数赋给C
    C(1, 1:S(1,1) * S(1,2)) = reshape(newCA, 1, S(1,1) * S(1,2));
    % 根据新的C还原成新的图像
    newimg = waverec2(C, S, "db1");
end

