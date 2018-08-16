function [TC,c]=mycluster(a);
%输出参数TC是整个网络的聚类系数，c为各个节点的聚类系数，输入参数是邻接矩阵
n=length(a);
for i=1:n
    m=find(a(i,:));  %找第i行非零元的地址
    ta=a(m,m); %提取节点vi的所有邻居节点所构成的邻接矩阵
    Lta=tril(ta); %提取邻居节点所构成邻接矩阵的下三角元素
    if  length(m)==0 | length(m)==1
        c(i)=0;  %孤立节点或只有1个邻居的节点的聚类系数定义为0
    else
        c(i)=sum(sum(Lta))/nchoosek(length(m),2); %求节点vi的聚类系数
    end
end
TC=mean(c);  %求整个网络的聚类系数
