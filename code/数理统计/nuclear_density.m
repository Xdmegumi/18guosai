clc
clear
data = normrnd(0,1,100,1);%mu,sigma,row,column
%绘制频率直方图，纵坐标为频率
[counts,centers] = hist(data,10);
bar(centers,counts / sum(counts) / (centers(2) - centers(1)));
%核密度估计
[f,xi] = ksdensity(data);
hold on;
plot(xi,f,'LineWidth',3);
%正态分布拟合
[mu,sigma] = normfit(data);
xj = -5:0.01:5;
yj = normpdf(xj,mu,sigma);
hold on;
plot(xj,yj);
%美化图片
%legend('原始数据','核密度估计','正态拟合');%乱码
legend('initial data','ksdensity','normfit');
%fig2plotly(gcf,'offline',true);