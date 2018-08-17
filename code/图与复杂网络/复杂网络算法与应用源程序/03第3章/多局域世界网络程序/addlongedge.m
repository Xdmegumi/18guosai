function [no,uv]=addlongedge(A,m,alpha);
%A为所有局域世界邻接矩阵的细胞数组，A{1}为第一个邻接矩阵，m为加边条数
%no为矩阵，每个列对应两个局域世界间存在连边,连边编号存放在矩阵uv的对应列中
n=length(A);  %局域世界的个数
no=[]; %存在连边的局域世界编号的初始化
uv=[]; %连边的两个节点的编号的初始化
for i=1:m
    rn=randperm(n);%产生全排列，rn(1)为连边局域世界的起点编号，rn(2)为终点
    no=[no,rn(1:2)']; %每个列为连边局域世界的编号
    a=A{rn(1)}; b=A{rn(2)}; %两个局域世界的邻接矩阵
    p1=(sum(a)+alpha)/sum(sum(a)+alpha); %计算连接概率
    pp1=cumsum(p1);  %计算累积概率
    p2=(sum(b)+alpha)/sum(sum(b)+alpha); %计算连接概率
    pp2=cumsum(p2);  %计算累积概率
    ind1=find(pp1>=rand); %产生一个随机数，找pp1中元素大于该随机数的地址,
    ind2=find(pp2>=rand); %产生一个随机数，找pp2中元素大于该随机数的地址,
    uv=[uv,[ind1(1);ind2(1)]]; %每个列为连接节点的编号（分别在不同局域世界）
end
