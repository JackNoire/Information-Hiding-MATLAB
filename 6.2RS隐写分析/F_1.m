function new = F_1(old)
%   ½»»»º¯ÊýF(-1)£¬»¥»»2nºÍ2n-1
    if mod(old, 2)
        new = old + 1;
    else
        new = old - 1;
    end
end

