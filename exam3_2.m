close all;clear;clc
%��������
load('data2.mat', 'raw')
%%
%****����Ԥ����
%������������ֵת�����˾�����������ֵ����GNP/POP=GNP_per��
V = zeros(50,6);
V(:,1) = raw(:,1)./raw(:,7);
for j = 2:6
V(:,j) = raw(:,j);
end

%%
%***���ݹ�һ����
%V 1(i,4) = (V (i,4) - min c {V c })/(max c {V c } - min c {V c }) 
for j = 1:6
mi = min(V(:,j));
ma = max(V(:,j));
V(:,j) = (V(:,j)-mi)/(ma - mi);
end

%ͨ��ԭʼ���������ķ�����������Ȩ��
V(:,1) = 2*V(:,1);%GNP_perȨ����Ϊ2
V(:,5) = 3*V(:,5);%DEBTSȨ����Ϊ3

%%
%****����SOM������
msize = [17 17];%�趨�����ģΪ17��17
lattice = 'hexa';%�趨����Ϊ����������hexa
neigh = 'gaussian';%������neigh��Ϊgaussian
radius_coarse = [7 1]; % ����뾶, ��ѵ��������뾶 [��ʼ �е�]
trainlen_coarse = 100; % ѭ��100��
radius_fine = [1 1]; % ����뾶, ϸѵ��������뾶 [��ʼ �յ�]
trainlen_fine = 50; % ѭ��50��

%ѵ���Ա�׼������ʽ����
smI = som_lininit(V, 'msize', msize, 'lattice', lattice, 'shape', ...
'sheet');%SOM�����ʼ��
%����V���������ݾ���msize��som����������ֲ�17��17��latticeΪ����ģʽ�������ε�
smC = som_batchtrain(smI, V, 'radius', radius_coarse, 'trainlen', ...
trainlen_coarse, 'neigh', neigh);%��ѵ���㷨
sm = som_batchtrain(smC, V, 'radius', radius_fine, 'trainlen', ...
trainlen_fine, 'neigh', neigh);%ϸѵ���㷨

%����ѵ����������sm��map.mat��
save('map', 'sm');

%%
%****��ͼ��ʹ������������ͼ17��17

%labels1�ǹ��Ҽ�Ƶ�ǰ��λ
%labels2�ǹ��Ҽ�Ƶĵ���λ
%����USA US��labels1�е�1��2λ��A��labels2�е�1λ  �Դ�����
labels1 = ['USEUCHJPDEFRGBBRRUITINCAAUESKOMEIDTUNLSACHARSWNGPONOB' ...
'EOAVEAUTHARCOIRZADNMYSGISCHHKEGPHFIGRPACSIRPOIRCS'];
%...�������ݹ�����������
labels2 = 'ARNNUARASADNSPRXNRDUEGEALRLNNTAELNFKSPRLGYLNCKKQRLK';

som_cplane('hexa',msize, 'none')%��������ͼ�������� ������
%���ڷ�����ʽΪstruct sm����ʽ��������ѧ�������
M = sm.codebook;%��ѵ�����smת������ѧ�������M

%winner search 
norms2 = sum(M.*M,2);%Mg�����еĸ���Ԫ�ص�ƽ��������
for u = 1:50
    %�ó�Ӯ��
    V1 = V(u,:)';
    Y = norms2 - 2*M*V1;
    [C,c] = min(Y);
    
    %Ӯ������
    ch = mod(c-1,17) + 1;
    cv = floor((c-1)/17) + 1;
    if mod(cv,2)==1
        shift1 = -0.4;
    else
        shift1 =0.001;
    end
    
    %���Ӯ��text(x,y,txt,'FontSize',8);�����СΪ8
    text(ch+shift1,cv,[labels1(2*u-1) labels1(2*u) labels2(u)],'FontSize',8);

end
%ͼƬ����������
filename = 'financemap_new';
print('-dpng', [filename '.png']);
