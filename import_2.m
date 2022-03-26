
%导入原始数据集

raw=importdata('E:\计算智能作业\第三次作业\SOM—50countries\raw_data.xlsx');  

% 1.gross national product in millions of dollars.国民生产总值（GNP）
% 2. rate of interest (ROI),利润率
% 3. inflation (INFL),通货膨胀 
% 4.unemployment (UNEMP), 失业
% 5.Debts in relation to GNP (DEBTS),负债与国民生产总值的关系
% 6. liquid deposits in relation to GNP (DEPOS),资金流与国民生产总值的关系
% 7.population (POP),人口

%第1，2，3，4，5，6，7列分别为GNP ROI INFL UNEMP DEBTS DEPOS POP
save data2.mat  raw;   
%GNP ROI INFL UNEMP DEBTS DEPOS POP是原始数据