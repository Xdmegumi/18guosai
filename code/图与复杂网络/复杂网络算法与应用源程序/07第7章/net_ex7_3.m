clc, clear
a=zeros(13); a(1,[2 3])=1; a(2,[3 4])=1;
a(3,4)=1; a(4,5)=1; a(5,[6 10])=1;
a(6,[7 8])=1; a(7,[8 9])=1; a(8,9)=1;
a(10,[11 12])=1; a(11,[12 13])=1; a(12,13)=1;
b=a'; b=sparse(b);
d=graphallshortestpaths(b,'Directed',0); %求所有顶点对之间的最短距离
dd=sum(d); %求距离和
Cc=12./dd %计算归一化的接近度指标
a=a+a'; %计算邻接矩阵
[vec,val]=eigs(a,1);
Ce=vec/sum(vec) %把特征向量归一化
xlswrite('biao.xls',Cc); xlswrite('biao.xls',Ce',1,'A3')
subplot(121), bar(Cc), subplot(122), bar(Ce)
