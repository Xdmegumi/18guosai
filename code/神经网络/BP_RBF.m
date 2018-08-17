clc
clear
data = dlmread('data_of_BP_RBF.m');%读入数据
%data x1 x2 x3 x4 y
data = data';%注意神经网络的数据格式
%data 
% x1
% x2
% x3
% x4
% y
P = data([1:4],[1:end - 1]);%训练的自变量，取第1到4行、第1到19列
[PN,PS1] = mapminmax(P);%规格化到[-1,1]
T = data(5,[1:end - 1]);;%训练的因变量，取第5行、第1到19列
[TN,PS2] = mapminmax(T);%规格化到[-1,1]
net_rbf = newrb(PN,TN);%训练RBF神经网络
x = data([1:4],end);%预测的自变量，取第1到4行、第20列
xn = mapminmax('apply',x,PS1);%规格化到[-1,1]，使用PS1方法
y1n = sim(net_rbf,xn);%预测
y1 = mapminmax('reverse',y1n,PS2)%还原数据，使用PS2方法
delta_rbf = abs(data(5,20) - y1) / data(5,20)%求相对误差

net_bp = feedforwardnet(4);%初始化BP神经网络，隐含层的神经元取为4个（多次试验得出）
net_bp = train(net_bp,PN,TN);%训练BP神经网络
y2n = net_bp(xn);%预测
y2 = mapminmax('reverse',y2n,PS2)%还原数据，使用PS2方法
delta_bp = abs(data(5,20) - y2) / data(5,20)%求相对误差