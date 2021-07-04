function flag = isRSU(blk, mask)
%   判断2*2的块是R、S还是U
%   blk：2*2的块，mask：就是ppt中的伪装M，取值范围-1,0,1
%   1:R, 0:U, -1:S
    flag = 0;
    newblk = blk;
    for i = 1:4     %对2*2的块进行根据M的F变换
        if mask(i) == 1
            newblk(i) = F1(blk(i));     %M中的这一项为1，则这一项进行F1变换
        elseif mask(i) == -1
            newblk(i) = F_1(blk(i));    %M中的这一项为-1，则这一项进行F(-1)变换
        end
    end
    fold = f(blk);      %f函数得到原来图像块的空间相关性
    fnew = f(newblk);   %f函数得到变换后图像块的空间相关性
    if fold > fnew
        flag = -1;      %变换后减小了图像间的差别程度，说明是S
    elseif fold < fnew
        flag = 1;       %变换后增大了图像间的差别程度，说明是R
    end
end

