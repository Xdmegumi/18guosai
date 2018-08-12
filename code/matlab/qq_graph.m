clc
clear
data = randi([1,100],1,100);%数据
xbar = mean(data);%样本平均值
s = std(data);%样本方差
pd = makedist('normal','mu',xbar,'sigma',s);%创建正态分布对象
qqplot(data,pd);
%按照定义绘制QQ图
% data = sort(data);%升序排序
% n = length(data);%样本容量
% pi = ([1:n] - 1 / 2) / n;
% yi = norminv(pi,xbar,s);
% plot(yi,data,'.');

%fig2plotly(gcf,'offline',true)