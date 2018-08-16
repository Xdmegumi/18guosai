function b=addedge(a,m,alpha); 
%输入参数a表示原网络邻接矩阵，输入参数m表示加边次数；
%alpha为式（3.71）中的调节因子，输出参数b为加边操作后新网络邻接矩阵
b=a; n=length(a); %n为已知网络的节点数
for i=1:m
    deg=sum(b); %计算当前网络各节点的度
    LP=(deg+alpha)/sum(deg+alpha); %计算各节点的连接概率
    pp=cumsum(LP);  %计算累积概率
    rnum=randperm(n);  %产生1,2,…,n的全排列
    flag=1; %加边的一个端点编号的地址，默认是第1个，下面修正
    while flag<=n & deg(rnum(flag))==n-1 %该节点关联边数达到最大值，无法加边
        flag=flag+1;
    end
    if flag==n+1, continue, end
    ind=find(pp>=rand); %产生一个随机数，找pp中元素大于该随机数的地址,
    %第一个地址作为加边的另外一个端点
    if rnum(flag)~=ind(1) & b(rnum(flag),ind(1))==0 %两个端点不同且原位置无边
        b(rnum(flag),ind(1))=1; b(ind(1),rnum(flag))=1;
    end   
end
