function newblk = dcthide2(blk, aimBit, alpha, T)
%   实现8*8的块中的二点法
%   (u1,v1)=(5,2) (u2,v2)=(3,4) (u3,v3)=(4,3)
%   b1 = dctblk(5,2);
%   b2 = dctblk(4,3);
    dctblk = T*blk*T';
    avg = (dctblk(5,2) + dctblk(4,3)) / 2;
    dctblk = T*blk*T';
    if aimBit == 1
        if dctblk(5,2) - dctblk(4,3) < alpha
            dctblk(5,2) = avg + alpha/2;
            dctblk(4,3) = avg - alpha/2;
        end
    else
        if dctblk(4,3) - dctblk(5,2) < alpha
            dctblk(4,3) = avg + alpha/2;
            dctblk(5,2) = avg - alpha/2;
        end
    end
    newblk = T'*dctblk*T;
end