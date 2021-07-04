function msg = extract(filename, key, row, col, positive_num)
n = row*col;
% 读取隐藏信息的图像
steg = imread(filename);
steg = imresize(steg, [512, 512]);
% 获取载体大小 M * N
[M, N] = size(steg);
% 作二级小波变换得到ccH和ccV
[cA,cH,cV,cD] = dwt2(steg,'haar');
[ccA, ccH, ccV, ccD] = dwt2(cA,'haar');
% 生成伪随机噪声序列
rng(key);
PNccH = round(rand(n, M/4));
PNccV = round(rand(n, M/4));
% 通过计算相关性判断嵌入的是1还是0
avg_corr = zeros(n, 1);
msg = zeros(row, col);
for r = 1:n
    p = mod(r-1, N/4) + 1;
    corr_H = correlation(ccH(:, p), PNccH(r, :)');
    corr_V = correlation(ccV(:, p), PNccV(r, :)');
    avg_corr(r) = (corr_H + corr_V) / 2;
end
avg_corr_sorted = sort(avg_corr, 'descend');
threshold = avg_corr_sorted(positive_num);
for r = 1:n
    if avg_corr(r) >= threshold
        msg(r) = 1;
    end
end
end

