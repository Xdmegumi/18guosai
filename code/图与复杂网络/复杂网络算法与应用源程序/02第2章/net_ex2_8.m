clc, clear, format rat
n=6; a=zeros(n);
a(1,[2 3 5])=[3 5 2]; %输入邻接矩阵的上三角元素
a(2,[3 4])=[1 6]; a(3,6)=3; a(4,6)=4;
a=a+a'; %输入完整的邻接矩阵
Si=sum(a) %计算点权
b=(a>0.5); %计算对应的无权邻接矩阵
ki=sum(b); %计算各节点的度
Ui=Si./ki %计算各节点的单位权
SSi=repmat(Si,size(a,1),1); %把Si变成与a同维数的矩阵
Yi=sum((a./SSi).^2) %计算各节点的权重差异性
kr=minmax(ki); %求度的取值的最小值和最大值
uk=[kr(1):kr(2)]; %枚举度的取值
pinshu=hist(ki, uk) %求度取值的频数
df=[uk; pinshu/n] %求度的频率分布表
for i=1:length(pinshu)
    Svv(i)=sum(Si(ki==uk(i)))/pinshu(i); %计算基于节点的权-度相关性
end
SSvv=[uk; Svv] %显示基于节点的权-度相关性
for i=1:n
    m=find(a(i,:));%找第i行非零元的地址
    ta=a(m,m); %提取节点vi的所有邻居节点所构成的邻接矩阵
    maxw=max(a(i,:)); %求节点vi关联边的权值中的最大值
    if  length(m)==0 | length(m)==1
        c(i)=0; %孤立节点或只有1个邻居的节点的聚类系数定义为0
    else
        s1=0; s2=0;
        for j=1:length(m)-1
            for k=j+1:length(m);
                s1=s1+a(i,m(j))*a(i,m(k))*a(m(j),m(k));
                s2=s2+a(i,m(j))*a(m(k),i);
            end
        end
        c(i)=s1/s2/maxw; %求节点vi的赋权聚类系数
    end
end
c
