function [Rm, Sm, R_m, S_m] = countRS(img)
%   传入灰度图像矩阵，数有多少个Rm，Sm等等
%   R_m和S_m表示R(-M)和S(-M)
    mask = [0 1; 1 0];      %   M定为(0,1,1,0)
    [row, col] = size(img);
    S_m = 0; R_m = 0; Sm = 0; Rm = 0;
    row = floor(row / 2);   %图像块是2*2，所以除以2，得到图像块有多少行
    col = floor(col / 2);
    for i = 1:row
        for j = 1:col       %遍历图像块，i和j是图像块的行列，需要i*2-1和j*2-1才能得到图像块左上角坐标
            flag = isRSU(img(i*2-1:i*2, j*2-1:j*2), mask);  %调用函数判断这一块是R还是S
            if flag == 1        %说明是R
                Rm = Rm + 1;
            elseif flag == -1   %说明是S
                Sm = Sm + 1;
            end
            
            flag = isRSU(img(i*2-1:i*2, j*2-1:j*2), -mask); %把M取反(0,-1,-1,0)，再作同样的判断
            if flag == 1
                R_m = R_m + 1;
            elseif flag == -1
                S_m = S_m + 1;
            end
        end
    end
end

