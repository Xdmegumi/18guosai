clc
clear
data = randi([1,100],1,100);%����
xbar = mean(data);%����ƽ��ֵ
s = std(data);%��������
pd = makedist('normal','mu',xbar,'sigma',s);%������̬�ֲ�����
qqplot(data,pd);
%���ն������QQͼ
% data = sort(data);%��������
% n = length(data);%��������
% pi = ([1:n] - 1 / 2) / n;
% yi = norminv(pi,xbar,s);
% plot(yi,data,'.');

%fig2plotly(gcf,'offline',true)