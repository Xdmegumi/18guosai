function dp=mydegree(a);
%返回值dp是度的频数分布表，它的第一行是度的取值，第二行是对应度的频数
%输入参数a为邻接矩阵
N=length(a);  %计算节点的个数
deg=sum(a);  %求各节点的度
degrange=minmax(deg); %求度的取值范围
pinshu=hist(deg,[degrange(1): degrange(2)]);%求度取值的频数
ind=find(pinshu==0); %找频数为0的地址
dp=[[degrange(1):degrange(2)]; pinshu];  %构造频数分布表
dp(:,ind)=[]; %删除频数为0的列
df=dp(2,:)/N; %求度的频率分布
figure, bar(dp(1,:),df,'r')  %画度的频率分布柱状图
title('网络图的度分布');
xlabel('$k$','Interpreter','Latex'), ylabel('$P$','Interpreter','Latex')
