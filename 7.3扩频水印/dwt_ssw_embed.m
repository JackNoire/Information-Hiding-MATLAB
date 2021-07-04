clear;
cover = imread('lena_gray.png');
k = 30; % 强度系数
key = 148;  % 伪随机噪声密钥
% 获取载体大小 M * N
[M, N] = size(cover);
% 作二级小波变换得到ccH和ccV
[cA,cH,cV,cD] = dwt2(cover,'haar');
[ccA, ccH, ccV, ccD] = dwt2(cA,'haar');
% 读取需要嵌入的消息
msg = imread('logo.png');
[n, ~] = size(msg(:));
% 生成伪随机噪声序列
rng(key);
PNccH = round(rand(n, M/4));
PNccV = round(rand(n, M/4));
% 向ccH和ccV嵌入数据
for r = 1:n
    p = mod(r-1, N/4) + 1;
    if msg(r) == 1
        ccH(:, p) = ccH(:, p) + k * PNccH(r, :)';
        ccV(:, p) = ccV(:, p) + k * PNccV(r, :)';
    end
end

steg_cA = idwt2(ccA, ccH, ccV, ccD, 'haar');
steg_img = idwt2(steg_cA, cH, cV, cD, 'haar');
imwrite(uint8(round(steg_img)), 'lena_steg.bmp');