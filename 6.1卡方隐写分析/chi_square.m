function p = chi_square(filename, isPlot)
%   对filename图像进行卡方分析
%   返回载体被隐写的可能性
    img = imread(filename);
    digitNum = zeros(256, 1);
    [row, col] = size(img);
    for i = 1:row
        for j = 1:col
            digitNum(img(i, j)-1) = digitNum(img(i, j)-1) + 1;
        end
    end
    k = 0;
    r = 0;
    for i = 0:127
        h2i = digitNum(2*i+1);
        h2iplus = digitNum(2*i+2);
        h2istar = (h2i+h2iplus) / 2;
        if h2istar ~= 0
            r = r + (h2i-h2istar)^2 / h2istar;
            k = k + 1;
        end
    end
    fun = @(t) exp(-t/2).*(t.^((k-1)/2-1));
    integralVal = integral(fun, 0, r);
    p = 1 - 1 / (2^((k-1)/2) * gamma((k-1)/2)) * integralVal;
    if isPlot
        bar(0:255, digitNum);
        fprintf("r = %f, p = %f\n", r, p);
    end
end

