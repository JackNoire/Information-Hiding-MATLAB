clear;
cover = imread('lena_gray.png');
k = 30; % ǿ��ϵ��
key = 148;  % α���������Կ
% ��ȡ�����С M * N
[M, N] = size(cover);
% ������С���任�õ�ccH��ccV
[cA,cH,cV,cD] = dwt2(cover,'haar');
[ccA, ccH, ccV, ccD] = dwt2(cA,'haar');
% ��ȡ��ҪǶ�����Ϣ
msg = imread('logo.png');
[n, ~] = size(msg(:));
% ����α�����������
rng(key);
PNccH = round(rand(n, M/4));
PNccV = round(rand(n, M/4));
% ��ccH��ccVǶ������
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