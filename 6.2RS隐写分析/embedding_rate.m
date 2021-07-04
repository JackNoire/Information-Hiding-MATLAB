function p = embedding_rate(img)
    [Rm, Sm, R_m, S_m] = countRS(img);
    [Rm_, Sm_, R_m_, S_m_] = countRS(bitxor(img, 1));  % ��ͼ��LSBȡ����Ȼ������ͬ���ļ���
    d0 = Rm - Sm;                               % �õ�(1-p/2)��Rm,Sm,R(-m),S(-m)ֵ
    d1 = Rm_ - Sm_;
    d_0 = R_m - S_m;
    d_1 = R_m_ - S_m_;                          % ���ݹ�ʽ����d0, d1, d(-0), d(-1)
    a = 2 * (d1 + d0);
    b = d_0 - d_1 - d1 - 3*d0;
    c = d0 - d_0;                               % ���ݹ�ʽ������η��̵�ϵ��
    x1 = (-b + sqrt(b^2 - 4*a*c)) / (2*a);
    x2 = (-b - sqrt(b^2 - 4*a*c)) / (2*a);      % �����ʽ
    x = 0;
    if abs(x1) < abs(x2)    % ȡ����ֵ��С��x
        x = x1;
    else
        x = x2;
    end
    p = x/(x-1/2);          % ���ݹ�ʽ����Ƕ����
end

