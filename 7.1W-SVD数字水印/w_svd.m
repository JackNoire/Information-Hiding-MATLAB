function [newimg, watermark] = w_svd(img, key, dovern, alpha)
    % ������С���任��ȡ��Ƶϵ��
    [C, S] = wavedec2(img, 2, "db1");
    CA = appcoef2(C, S, "db1");
    CAsimilar = (1/(max(CA(:))-min(CA(:)))) * (CA-min(CA(:)));
    [U, sigma, V] = svd(CAsimilar);
    % ����ˮӡ
    watermark = generate_watermark(key, U, V, dovern, alpha);
    % ��ˮӡ�����Ƶϵ��
    newCA = CA + watermark;
    % ���µĵ�Ƶϵ������C
    C(1, 1:S(1,1) * S(1,2)) = reshape(newCA, 1, S(1,1) * S(1,2));
    % �����µ�C��ԭ���µ�ͼ��
    newimg = waverec2(C, S, "db1");
end

