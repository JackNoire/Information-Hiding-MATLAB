function new = F_1(old)
%   ��������F(-1)������2n��2n-1
    if mod(old, 2)
        new = old + 1;
    else
        new = old - 1;
    end
end

