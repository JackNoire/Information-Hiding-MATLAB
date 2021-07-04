function flag = isRSU(blk, mask)
%   �ж�2*2�Ŀ���R��S����U
%   blk��2*2�Ŀ飬mask������ppt�е�αװM��ȡֵ��Χ-1,0,1
%   1:R, 0:U, -1:S
    flag = 0;
    newblk = blk;
    for i = 1:4     %��2*2�Ŀ���и���M��F�任
        if mask(i) == 1
            newblk(i) = F1(blk(i));     %M�е���һ��Ϊ1������һ�����F1�任
        elseif mask(i) == -1
            newblk(i) = F_1(blk(i));    %M�е���һ��Ϊ-1������һ�����F(-1)�任
        end
    end
    fold = f(blk);      %f�����õ�ԭ��ͼ���Ŀռ������
    fnew = f(newblk);   %f�����õ��任��ͼ���Ŀռ������
    if fold > fnew
        flag = -1;      %�任���С��ͼ���Ĳ��̶ȣ�˵����S
    elseif fold < fnew
        flag = 1;       %�任��������ͼ���Ĳ��̶ȣ�˵����R
    end
end

