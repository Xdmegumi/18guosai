clc, clear
a=[0.39 0.44 0.71 0.9 1.81 1.98 3.79 3.81 3.9 4.13 4.72 5.98 7.16 9.72 19.13];
cs=mle(a,'distribution','gamma'); %拟合Gamma分布
pd=makedist('gamma','a',cs(1),'b',cs(2))  %定义Gamma分布
[h,p,kstat,c]=kstest(a,pd,0.05)  %直接使用Matlab工具箱做检验,kstat返回的是统计量的值，c返回的是临界值
