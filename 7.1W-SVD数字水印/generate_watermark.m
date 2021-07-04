function watermark = generate_watermark(key, U, V, dovern, alpha)
    % ����ˮӡ
    % ����������������滻U��V�ĺ�d��
    rng(key);
    [Q1, R1] = qr(rand(size(U)));
    [Q2, R2] = qr(rand(size(V)));
    d = round(dovern * max(size(U)));
    U2 = U;
    V2 = V;
    U2(:, max(size(U))-d+1:max(size(U))) = Q1(:, max(size(U))-d+1:max(size(U)));
    V2(:, max(size(V))-d+1:max(size(V))) = Q2(:, max(size(V))-d+1:max(size(V)));
    % ��������ԽǾ���
    sigma2 = alpha*diag(flipud(sort(rand(max(size(U)),1))));
    % ����ˮӡ
    watermark = U2 * sigma2 * V2';
end

