function val = f(blk)
%   传入2*2的矩阵(图像块)，计算图像块的空间相关性，即函数f
    val = abs(blk(1)-blk(2)) + abs(blk(2)-blk(3)) + abs(blk(3)-blk(4));
end

