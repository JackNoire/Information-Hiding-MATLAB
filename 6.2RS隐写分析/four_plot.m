x = [];
Rml=[];
Sml=[];
R_ml=[];
S_ml=[];
for i = 0:5000:260000
    img = imread('output\' + string(i) + '.png');
    x = [x i];
    [Rm, Sm, R_m, S_m] = countRS(img);
    Rml=[Rml Rm];
    Sml=[Sml Sm];
    R_ml=[R_ml R_m];
    S_ml=[S_ml S_m];
    fprintf('进度：%f%%\t\t\n', i/260000*100);
end
img = imread('output\262144.png');
x = [x 262144];
[Rm, Sm, R_m, S_m] = countRS(img);
Rml=[Rml Rm];
Sml=[Sml Sm];
R_ml=[R_ml R_m];
S_ml=[S_ml S_m];
plot(x,Rml,x,Sml,x,R_ml,x,S_ml);
hold on;
xlabel("嵌入像素点数量");
ylabel("数值");
text(x(end-15),Rml(end-15),'R_m');
text(x(end-15),Sml(end-15),'S_m');
text(x(end-15),R_ml(end-15),'R_{-m}');
text(x(end-15),S_ml(end-15),'S_{-m}');