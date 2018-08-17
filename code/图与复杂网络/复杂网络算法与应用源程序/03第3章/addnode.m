function b=addnode(a,m,alpha); 
%输入参数a表示原网络邻接矩阵，输入参数m表示可能的连边数
%alpha为式（3.71）中调节因子，输出参数b为新网络邻接矩阵
b=a; n=length(a); %n为已知网络的节点数
if m>n
    return %输入数据不匹配，返回
end
for i=1:m
    LP=(sum(b)+alpha)/sum(sum(b)+alpha); %计算各节点的配置概率
    pp=cumsum(LP);  %计算累积概率
    ind=find(pp>=rand); %产生一个随机数，找pp中元素大于该随机数的地址,
    %第一个地址作为加边的另外一个端点
    b(n+1,ind(1))=1; b(ind(1),n+1)=1;
end
