clear;
key = 148;
n = 512;
positive_num = 75; % Ƕ���ˮӡ��1�ĸ�����������ȷ����ֵ
% ��ȡ������Ϣ��ͼ��
steg = imread('lena_steg.bmp');
% ��ȡ�����С M * N
[M, N] = size(steg);
% ������С���任�õ�ccH��ccV
[cA,cH,cV,cD] = dwt2(steg,'haar');
[ccA, ccH, ccV, ccD] = dwt2(cA,'haar');
% ����α�����������
rng(key);
PNccH = round(rand(n, M/4));
PNccV = round(rand(n, M/4));
% ͨ������������ж�Ƕ�����1����0
avg_corr = zeros(n, 1);
msg = zeros(16, 32);
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