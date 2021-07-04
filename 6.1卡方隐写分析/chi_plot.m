x = [];
y = [];
for num = 0:5000:260000
    x = [x num/262144];
    y = [y chi_square('output\' + string(num) + '.png', false)];
end
x = [x 1];
y = [y chi_square('output\262144.png', false)];
plot(x, y);
xlabel('嵌入率');
ylabel('被隐写可能性');