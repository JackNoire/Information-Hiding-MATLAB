x = [];
trueY = [];
evaY = [];
for i = 0:5000:260000
    img = imread('output\' + string(i) + '.png');
    x = [x i];
    trueY = [trueY i/262144];
    evaY = [evaY, embedding_rate(img)];
    fprintf('���ȣ�%f%%\t\t\n', i/260000*100);
end
img = imread('output\262144.png');
x = [x 262144];
trueY = [trueY 1];
evaY = [evaY, embedding_rate(img)];
plot(x, trueY, x, real(evaY));
xlabel('Ƕ�����ص�����');
legend('��ʵǶ����', '����Ƕ����');