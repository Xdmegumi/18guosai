clc, clear
a=zeros(6); %邻接矩阵初始化
a(1,[2 3])=1; a(2,[3:5])=1; %输入邻接矩阵的上三角元素
a(3,5)=1; a(4,[5 6])=1;
a=a+a'; %构造完整的邻接矩阵
r=mycorrelations(a) %调用我们自己编写的函数
