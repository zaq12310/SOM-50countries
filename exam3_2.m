close all;clear;clc
%导入数据
load('data2.mat', 'raw')
%%
%****数据预处理
%将国民生产总值转化成人均国民生产总值（即GNP/POP=GNP_per）
V = zeros(50,6);
V(:,1) = raw(:,1)./raw(:,7);
for j = 2:6
V(:,j) = raw(:,j);
end

%%
%***数据归一化：
%V 1(i,4) = (V (i,4) - min c {V c })/(max c {V c } - min c {V c }) 
for j = 1:6
mi = min(V(:,j));
ma = max(V(:,j));
V(:,j) = (V(:,j)-mi)/(ma - mi);
end

%通过原始数据增倍的方法变相增加权重
V(:,1) = 2*V(:,1);%GNP_per权重设为2
V(:,5) = 3*V(:,5);%DEBTS权重设为3

%%
%****建立SOM神经网络
msize = [17 17];%设定网格规模为17×17
lattice = 'hexa';%设定网格为六角形网格hexa
neigh = 'gaussian';%邻域函数neigh设为gaussian
radius_coarse = [7 1]; % 邻域半径, 粗训练中邻域半径 [起始 中点]
trainlen_coarse = 100; % 循环100次
radius_fine = [1 1]; % 邻域半径, 细训练中邻域半径 [起始 终点]
trainlen_fine = 50; % 循环50次

%训练以标准化的形式进行
smI = som_lininit(V, 'msize', msize, 'lattice', lattice, 'shape', ...
'sheet');%SOM网络初始化
%其中V是输入数据矩阵，msize是som竞争层网格分布17×17，lattice为网格模式（六角形等
smC = som_batchtrain(smI, V, 'radius', radius_coarse, 'trainlen', ...
trainlen_coarse, 'neigh', neigh);%粗训练算法
sm = som_batchtrain(smC, V, 'radius', radius_fine, 'trainlen', ...
trainlen_fine, 'neigh', neigh);%细训练算法

%保存训练后神经网络sm到map.mat中
save('map', 'sm');

%%
%****画图，使用六边形网格图17×17

%labels1是国家简称的前两位
%labels2是国家简称的第三位
%比如USA US在labels1中第1，2位，A在labels2中第1位  以此类推
labels1 = ['USEUCHJPDEFRGBBRRUITINCAAUESKOMEIDTUNLSACHARSWNGPONOB' ...
'EOAVEAUTHARCOIRZADNMYSGISCHHKEGPHFIGRPACSIRPOIRCS'];
%...由于数据过长换行链接
labels2 = 'ARNNUARASADNSPRXNRDUEGEALRLNNTAELNFKSPRLGYLNCKKQRLK';

som_cplane('hexa',msize, 'none')%画出网格图（六边形 无数据
%由于返回形式为struct sm的形式，不是数学矩阵变量
M = sm.codebook;%将训练后的sm转化成数学矩阵变量M

%winner search 
norms2 = sum(M.*M,2);%Mg各行中的各个元素的平方相加求和
for u = 1:50
    %得出赢家
    V1 = V(u,:)';
    Y = norms2 - 2*M*V1;
    [C,c] = min(Y);
    
    %赢家坐标
    ch = mod(c-1,17) + 1;
    cv = floor((c-1)/17) + 1;
    if mod(cv,2)==1
        shift1 = -0.4;
    else
        shift1 =0.001;
    end
    
    %标出赢家text(x,y,txt,'FontSize',8);字体大小为8
    text(ch+shift1,cv,[labels1(2*u-1) labels1(2*u) labels2(u)],'FontSize',8);

end
%图片命名并保存
filename = 'financemap_new';
print('-dpng', [filename '.png']);
