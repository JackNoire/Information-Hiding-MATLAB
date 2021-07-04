function [newblk, success] = dcthide3(blk, aimBit, D, T)
%   实现8*8的块中的三点法
%   (u1,v1)=(5,2) (u2,v2)=(3,4) (u3,v3)=(4,3)
    dctblk = T*blk*T';
    b1 = dctblk(5,2);
    b2 = dctblk(3,4);
    b3 = dctblk(4,3);
    maxChange = 1.95 * D;
    changeNum = 0;
    if aimBit==1
        if b1 < b3 + D
            changeNum = changeNum + b3 + D - b1;
        end
        if b2 < b3 + D
            changeNum = changeNum + b3 + D - b2;
        end
        if changeNum > maxChange
            success = false;
            if b1 > b2
                if b1 < b3
                    dctblk(5,2) = b3;
                end
            else
                if b2 < b3
                    dctblk(3,4) = b3;
                end
            end
            newblk = T'*dctblk*T;
            return;
        end
        if b1 < b3 + D
            dctblk(5,2) = b3 + D;
        end
        if b2 < b3 + D
            dctblk(3,4) = b3 + D;
        end
        success = true;
        newblk = T'*dctblk*T;
        return;
    else
        if b1 > b3 - D
            changeNum = b1 - b3 + D;
        end
        if b2 > b3 - D
            changeNum = b2 - b3 + D;
        end
        if changeNum > maxChange
            success = false;
            if b1 > b2
                if b2 > b3
                    dctblk(3,4) = b3;
                end
            else
                if b1 > b3
                    dctblk(5,2) = b3;
                end
            end
            newblk = T'*dctblk*T;
            return;
        end
        if b1 > b3 - D
            dctblk(5,2) = b3 - D;
        end
        if b2 > b3 - D
            dctblk(3,4) = b3 - D;
        end
        success = true;
        newblk = T'*dctblk*T;
        return;
    end
end

