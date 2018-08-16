clc, clear
dv=[2  5  4  10  7  9]'; n=length(dv);
idv=2*max(dv)-dv; %把dv变成逆序，通常的秩是按照从小到大排列的序号定义
rv=tiedrank(idv)  %调用Matlab求秩的命令
a=[ones(n,1),log(rv)]; 
cs=a\log(dv)  %用线性最小二乘法拟合线性回归的常数项和一次项系数
R=-cs(2)  %提取秩指数
