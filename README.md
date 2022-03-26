# SOM-50countries
50个国家相关性研究，采用SOM神经网络
第三次作业第2题
参考文献：MATLAB_implementations_and_applications_of_the_self_organizing_map
2）The SOM of the present financial status of 50 countries or unions

原始数据：下图为国家在该神经网络使用的简称
![image](https://user-images.githubusercontent.com/92127845/160221934-a5a83ec2-cc32-470d-a1b8-0b20857fc61d.png)

已知的国家所拥有的数据
1.gross national product in millions of dollars.国民生产总值（GNP）
2. rate of interest (ROI),利润率
3. inflation (INFL),通货膨胀 
4.unemployment (UNEMP), 失业
5.Debts in relation to GNP (DEBTS),负债与国民生产总值的关系
6. liquid deposits in relation to GNP (DEPOS),资金流与国民生产总值的关系
7.population (POP),人口




数据预处理方式（国民生产总值转化成人均生产总值）
GNP->GNP_per,即GNP/POP=GNP_per
预处理后V中第1，2，3，4，5，6列分别为GNP_per ROI INFL UNEMP DEBTS DEPOS

数据归一化采用的公式为：
V 1(i,4) = (V (i,4) - min c {V c })/(max c {V c } - min c {V c }) 

权重设置：GNP_per和DEBTS权重分别设为2和3，其他均设为1

该神经网络性质
竞争层为17×17的六角形网格
邻域函数（neigh）设为gaussian 
粗训练中邻域半径为[7 1] 循环100次
细训练中邻域半径为[1 1] 循环50次

运行import_2.m进行raw_data,xlsx数据的导入
原始数据集保存为data.mat

运行exam3_2.m 保存的神经网络结构为map.mat 
保存下面图片为financemap_new.png
![image](https://user-images.githubusercontent.com/92127845/160221949-3bafe463-2960-4963-890a-6ad75412db52.png)

