clc, clear, format rat, a=ones(6);
a(1:7:end)=3; %对角线元素赋值为3
a([4,9,17,24,26,31])=-1; %这里a的地址取一维
aa=[a,-ones(6,1);ones(1,6),0]; %构造7个未知数x1,...,x6,v的系数阵
b=[zeros(6,1);1]; %构造常数项列
xv=pinv(aa)*b %解线性方程组
x=xv(1:end-1) %显示齐王的混合策略
v=xv(end) %显示齐王赢得的期望值