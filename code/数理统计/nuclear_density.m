clc
clear
data = normrnd(0,1,100,1);%mu,sigma,row,column
%����Ƶ��ֱ��ͼ��������ΪƵ��
[counts,centers] = hist(data,10);
bar(centers,counts / sum(counts) / (centers(2) - centers(1)));
%���ܶȹ���
[f,xi] = ksdensity(data);
hold on;
plot(xi,f,'LineWidth',3);
%��̬�ֲ����
[mu,sigma] = normfit(data);
xj = -5:0.01:5;
yj = normpdf(xj,mu,sigma);
hold on;
plot(xj,yj);
%����ͼƬ
%legend('ԭʼ����','���ܶȹ���','��̬���');%����
legend('initial data','ksdensity','normfit');
%fig2plotly(gcf,'offline',true);