function [transBlock, success] = blockhide(originalBlock, aimBit, R0, R1, lambda)
%blockhide ��Ŀ�����������
%   transBlockת�����Ŀ��飬success�Ƿ�ɹ�
%   originalBlockԭ���ݿ飬aimBitĿ�����
%   R0��R1Ϊ��ֵ��lambdaΪ��׳����
%   ֻ����10*10��С�Ŀ�

%   ͳ��1�����ص����
    positiveNum = 0;
    for i = 1:10
        for j = 1:10
            if originalBlock(i, j) == 1
                positiveNum = positiveNum + 1;
            end
        end
    end
    fprintf("Positive Number: %d aimBit: %d ", positiveNum, aimBit);
%   ����Ŀ����Ϣ����λ����transBlock
    transBlock = originalBlock;
    randomSeq = randperm(64);
    switch aimBit
    case 1
        if positiveNum < R0 - 3*lambda || positiveNum > R1 + 3*lambda  % ��Ч��
            success = false;
            return;
        end
        if positiveNum >= R1 && positiveNum <= R1 + lambda  % �ѵ��õĿ�
            success = true;
            return;
        end
        if positiveNum <= R0  % ���Ե�����
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
        elseif positiveNum < R1  % �ɲ�1�飬1������
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
        elseif positiveNum > R1 + lambda % �ɲ�1�飬1������
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
        if positiveNum < R0 - 3*lambda || positiveNum > R1 + 3*lambda  % ��Ч��
            success = false;
            return;
        end
        if positiveNum >= R0 - lambda && positiveNum <= R0  % �ѵ��õĿ�
            success = true;
            return;
        end
        if positiveNum >= R1  % ���Ե�����
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
        elseif positiveNum > R0  % �ɲ�0�飬1������
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
        elseif positiveNum < R0 - lambda % �ɲ�0�飬1������
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

