function [transBlock, success] = blockhide(originalBlock, aimBit, R0, R1, lambda)
%blockhide 向目标块隐藏数据
%   transBlock转换后的目标块，success是否成功
%   originalBlock原数据块，aimBit目标比特
%   R0、R1为阈值，lambda为健壮参数
%   只允许10*10大小的块

%   统计1的像素点个数
    positiveNum = 0;
    for i = 1:10
        for j = 1:10
            if originalBlock(i, j) == 1
                positiveNum = positiveNum + 1;
            end
        end
    end
    fprintf("Positive Number: %d aimBit: %d ", positiveNum, aimBit);
%   根据目标信息比特位生成transBlock
    transBlock = originalBlock;
    randomSeq = randperm(64);
    switch aimBit
    case 1
        if positiveNum < R0 - 3*lambda || positiveNum > R1 + 3*lambda  % 无效块
            success = false;
            return;
        end
        if positiveNum >= R1 && positiveNum <= R1 + lambda  % 已调好的块
            success = true;
            return;
        end
        if positiveNum <= R0  % 难以调整块
            while true
                for num = randomSeq
                    i = idivide(num, int32(8), 'ceil') + 1;
                    j = mod(num, 8) + 1;
                    if j == 1
                        j = 9;
                    end
                    if transBlock(i, j) == 1 && is_edge(transBlock, i, j)
                        transBlock(i, j) = 0;
                        positiveNum = positiveNum - 1;
                        if positiveNum < R0 - 3*lambda
                            success = false;
                            return;
                        end
                    end
                end
            end
        elseif positiveNum < R1  % 可藏1块，1数量少
            while true
                for num = randomSeq
                    i = idivide(num, int32(8), 'ceil') + 1;
                    j = mod(num, 8) + 1;
                    if j == 1
                        j = 9;
                    end
                    if transBlock(i, j) == 0 && is_edge(transBlock, i, j)
                        transBlock(i, j) = 1;
                        positiveNum = positiveNum + 1;
                        if positiveNum >= R1
                            success = true;
                            return;
                        end
                    end
                end
            end
        elseif positiveNum > R1 + lambda % 可藏1块，1数量多
            while true
                for num = randomSeq
                    i = idivide(num, int32(8), 'ceil') + 1;
                    j = mod(num, 8) + 1;
                    if j == 1
                        j = 9;
                    end
                    if transBlock(i, j) == 1 && is_edge(transBlock, i, j)
                        transBlock(i, j) = 0;
                        positiveNum = positiveNum - 1;
                        if positiveNum <= R1 + lambda
                            success = true;
                            return;
                        end
                    end
                end
            end
        end
    case 0
        if positiveNum < R0 - 3*lambda || positiveNum > R1 + 3*lambda  % 无效块
            success = false;
            return;
        end
        if positiveNum >= R0 - lambda && positiveNum <= R0  % 已调好的块
            success = true;
            return;
        end
        if positiveNum >= R1  % 难以调整块
            while true
                for num = randomSeq
                    i = idivide(num, int32(8), 'ceil') + 1;
                    j = mod(num, 8) + 1;
                    if j == 1
                        j = 9;
                    end
                    if transBlock(i, j) == 0 && is_edge(transBlock, i, j)
                        transBlock(i, j) = 1;
                        positiveNum = positiveNum + 1;
                        if positiveNum > R1 + 3*lambda
                            success = false;
                            return;
                        end
                    end
                end
            end
        elseif positiveNum > R0  % 可藏0块，1数量多
            while true
                for num = randomSeq
                    i = idivide(num, int32(8), 'ceil') + 1;
                    j = mod(num, 8) + 1;
                    if j == 1
                        j = 9;
                    end
                    if transBlock(i, j) == 1 && is_edge(transBlock, i, j)
                        transBlock(i, j) = 0;
                        positiveNum = positiveNum - 1;
                        if positiveNum <= R0
                            success = true;
                            return;
                        end
                    end
                end
            end
        elseif positiveNum < R0 - lambda % 可藏0块，1数量少
            while true
                for num = randomSeq
                    i = idivide(num, int32(8), 'ceil') + 1;
                    j = mod(num, 8) + 1;
                    if j == 1
                        j = 9;
                    end
                    if transBlock(i, j) == 0 && is_edge(transBlock, i, j)
                        transBlock(i, j) = 1;
                        positiveNum = positiveNum + 1;
                        if positiveNum >= R0 - lambda
                            success = true;
                            return;
                        end
                    end
                end
            end
        end
    end
end

