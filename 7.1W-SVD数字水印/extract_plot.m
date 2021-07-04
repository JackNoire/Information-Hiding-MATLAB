load woman;
originimg = ind2gray(X, map);
newimg = im2double(imread("test.jpg"));
watermark = extract_watermark(newimg, originimg);

[C, S] = wavedec2(originimg, 2, "db1");
CA = appcoef2(C, S, "db1");
CAsimilar = (1/(max(CA(:))-min(CA(:)))) * (CA-min(CA(:)));
[U, sigma, V] = svd(CAsimilar);

associate_list = [];
dct_list = [];
for i = 0:200
    guess = generate_watermark(i, U, V, 0.7, 0.7);
    associate_list = [associate_list associate(guess, watermark)];
    dct_list = [dct_list dct_associate(guess, watermark, 32)];
end
subplot(2,1,1);plot(0:200, associate_list, "linewidth", 1);title("³£¹æ¼ì²â");
subplot(2,1,2);plot(0:200, dct_list, "linewidth", 1);title("DCT¼ì²â");