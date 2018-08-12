clc
clear
data = dlmread('data_of_BP_RBF.m');%��������
%data x1 x2 x3 x4 y
data = data';%ע������������ݸ�ʽ
%data 
% x1
% x2
% x3
% x4
% y
P = data([1:4],[1:end - 1]);%ѵ�����Ա�����ȡ��1��4�С���1��19��
[PN,PS1] = mapminmax(P);%��񻯵�[-1,1]
T = data(5,[1:end - 1]);;%ѵ�����������ȡ��5�С���1��19��
[TN,PS2] = mapminmax(T);%��񻯵�[-1,1]
net_rbf = newrb(PN,TN);%ѵ��RBF������
x = data([1:4],end);%Ԥ����Ա�����ȡ��1��4�С���20��
xn = mapminmax('apply',x,PS1);%��񻯵�[-1,1]��ʹ��PS1����
y1n = sim(net_rbf,xn);%Ԥ��
y1 = mapminmax('reverse',y1n,PS2)%��ԭ���ݣ�ʹ��PS2����
delta_rbf = abs(data(5,20) - y1) / data(5,20)%��������

net_bp = feedforwardnet(4);%��ʼ��BP�����磬���������ԪȡΪ4�����������ó���
net_bp = train(net_bp,PN,TN);%ѵ��BP������
y2n = net_bp(xn);%Ԥ��
y2 = mapminmax('reverse',y2n,PS2)%��ԭ���ݣ�ʹ��PS2����
delta_bp = abs(data(5,20) - y2) / data(5,20)%��������