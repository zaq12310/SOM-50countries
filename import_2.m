
%����ԭʼ���ݼ�

raw=importdata('E:\����������ҵ\��������ҵ\SOM��50countries\raw_data.xlsx');  

% 1.gross national product in millions of dollars.����������ֵ��GNP��
% 2. rate of interest (ROI),������
% 3. inflation (INFL),ͨ������ 
% 4.unemployment (UNEMP), ʧҵ
% 5.Debts in relation to GNP (DEBTS),��ծ�����������ֵ�Ĺ�ϵ
% 6. liquid deposits in relation to GNP (DEPOS),�ʽ��������������ֵ�Ĺ�ϵ
% 7.population (POP),�˿�

%��1��2��3��4��5��6��7�зֱ�ΪGNP ROI INFL UNEMP DEBTS DEPOS POP
save data2.mat  raw;   
%GNP ROI INFL UNEMP DEBTS DEPOS POP��ԭʼ����