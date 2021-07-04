load woman;
img = ind2gray(X, map);
[newimg, watermark] = w_svd(img, 148, 0.7, 0.7);
imwrite(newimg, "test.jpg");
subplot(1,3,1);imshow(watermark*255);title("ˮӡ��̬ͼ");
subplot(1,3,2);imshow(img);title("ԭͼ");
subplot(1,3,3);imshow(newimg);title("Ƕ��ˮӡͼ");
