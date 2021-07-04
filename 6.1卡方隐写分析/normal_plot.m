img = imread('0.png');
digitNum = zeros(256, 1);
[row, col] = size(img);
for i = 1:row
    for j = 1:col
        digitNum(img(i, j)-1) = digitNum(img(i, j)-1) + 1;
    end
end
graph = [];
count = 0;
for i = 0:127
    h2i = digitNum(2*i+1);
    h2iplus = digitNum(2*i+2);
    h2istar = (h2i+h2iplus) / 2;
    if h2istar ~= 0
        graph = [graph (h2i-h2iplus)/sqrt(2*h2istar)];
        count = count + 1;
    end
end

img = imread('262144.png');
digitNum = zeros(256, 1);
[row, col] = size(img);
for i = 1:row
    for j = 1:col
        digitNum(img(i, j)-1) = digitNum(img(i, j)-1) + 1;
    end
end
graph2 = [];
count = 0;
for i = 0:127
    h2i = digitNum(2*i+1);
    h2iplus = digitNum(2*i+2);
    h2istar = (h2i+h2iplus) / 2;
    if h2istar ~= 0
        graph2 = [graph2 (h2i-h2iplus)/sqrt(2*h2istar)];
        count = count + 1;
    end
end

histogram(graph2,-3:0.2:3);
hold on;
histogram(graph,-3:0.2:3);
x = -3:0.2:3;
plot(x, (normcdf(x+0.1)-normcdf(x-0.1))*count, 'm', 'LineWidth', 3);
