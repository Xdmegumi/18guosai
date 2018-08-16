clc, clear
bins=0:3; %定义区间的中心
obsCounts=[112 20 11 7]; %各区间的观测频数
n=sum(obsCounts); %计算样本容量
pHat = sum(bins.*obsCounts)/n/3; %计算p的极大似然估计值
pd= makedist('bino','n',3,'p',pHat)  %定义二项分布
[h,p,st]=chi2gof(bins,'cdf',pd,'ctrs',bins,'frequency',obsCounts,'nparams',1)
