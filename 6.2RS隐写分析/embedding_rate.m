function p = embedding_rate(img)
    [Rm, Sm, R_m, S_m] = countRS(img);
    [Rm_, Sm_, R_m_, S_m_] = countRS(bitxor(img, 1));  % 对图像LSB取反，然后再做同样的计数
    d0 = Rm - Sm;                               % 得到(1-p/2)的Rm,Sm,R(-m),S(-m)值
    d1 = Rm_ - Sm_;
    d_0 = R_m - S_m;
    d_1 = R_m_ - S_m_;                          % 根据公式计算d0, d1, d(-0), d(-1)
    a = 2 * (d1 + d0);
    b = d_0 - d_1 - d1 - 3*d0;
    c = d0 - d_0;                               % 根据公式计算二次方程的系数
    x1 = (-b + sqrt(b^2 - 4*a*c)) / (2*a);
    x2 = (-b - sqrt(b^2 - 4*a*c)) / (2*a);      % 求根公式
    x = 0;
    if abs(x1) < abs(x2)    % 取绝对值较小的x
        x = x1;
    else
        x = x2;
    end
    p = x/(x-1/2);          % 根据公式计算嵌入率
end

