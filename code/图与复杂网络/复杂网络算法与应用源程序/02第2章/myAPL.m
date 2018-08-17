function [D,L,dist]=myAPL(a); 
%计算网络直径D，平均路径长度L，和所有节点对之间的最短距离dist；输入参数a为网络的邻接矩阵
a=tril(a);  %截取邻接矩阵的下三角部分，满足Matlab工具箱的要求
a=sparse(a); %转换成稀疏矩阵,Matlab工具箱的要求
dist=graphallshortestpaths(a,'directed',false);
D=max(max(dist));  %计算网络直径
Ldist=tril(dist);  %提取最短距离矩阵的下三角部分
he=sum(nonzeros(Ldist));  %求所有边的和
n=length(a);  %求节点个数
L=he/nchoosek(n,2);  %求平均路径长度，这里使用Matlab求组合数命令
