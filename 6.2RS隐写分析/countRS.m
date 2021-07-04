function [Rm, Sm, R_m, S_m] = countRS(img)
%   ����Ҷ�ͼ��������ж��ٸ�Rm��Sm�ȵ�
%   R_m��S_m��ʾR(-M)��S(-M)
    mask = [0 1; 1 0];      %   M��Ϊ(0,1,1,0)
    [row, col] = size(img);
    S_m = 0; R_m = 0; Sm = 0; Rm = 0;
    row = floor(row / 2);   %ͼ�����2*2�����Գ���2���õ�ͼ����ж�����
    col = floor(col / 2);
    for i = 1:row
        for j = 1:col       %����ͼ��飬i��j��ͼ�������У���Ҫi*2-1��j*2-1���ܵõ�ͼ������Ͻ�����
            flag = isRSU(img(i*2-1:i*2, j*2-1:j*2), mask);  %���ú����ж���һ����R����S
            if flag == 1        %˵����R
                Rm = Rm + 1;
            elseif flag == -1   %˵����S
                Sm = Sm + 1;
            end
            
            flag = isRSU(img(i*2-1:i*2, j*2-1:j*2), -mask); %��Mȡ��(0,-1,-1,0)������ͬ�����ж�
            if flag == 1
                R_m = R_m + 1;
            elseif flag == -1
                S_m = S_m + 1;
            end
        end
    end
end

