function [h,p,st]=poisstest(dp); %自定义度的poisson分布的非参数检验函数
bins = dp(1,:);  %提取度的取值
obsCounts=dp(2,:);  %提取度的频数
n=sum(obsCounts);  %计算节点个数，
lambdaHat=sum(bins.*obsCounts)/n;  %估计度的均值
expCounts = n*poisspdf(bins,lambdaHat); %计算期望的频数 
[h,p,st]=chi2gof(bins,'ctrs',bins,'frequency',obsCounts,'expected',expCounts,'nparams',1) %调用Matlab的非参数检验的chi2拟合检验法