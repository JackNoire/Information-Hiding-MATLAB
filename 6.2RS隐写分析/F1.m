function new = F1(old)
%   ��������F1������2n��2n+1
    if mod(old, 2)
        new = old - 1;
    else
        new = old + 1;
    end
end

