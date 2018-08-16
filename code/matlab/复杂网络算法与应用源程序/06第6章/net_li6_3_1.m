clc, clear
N=1000; gamma=2.4; m=4;
a=scale_free_net(1000,2.4,4);
deg=sum(a);  %求各节点的度
degv=[min(deg):max(deg)]; %求度的取值
pinshu=hist(deg,degv); %求度取值的频数
ind=find(pinshu==0); %找频数为0的地址
degv(ind)=[]; pinshu(ind)=[]; %删除频数为0的列
loglog(degv,pinshu/N,'+-')
hold on, fx=@(x)0.1*x.^(-2.4);
x0=[1:degv(end)]; loglog(x0,fx(x0),'o-')
legend('度分布','幂函数')
