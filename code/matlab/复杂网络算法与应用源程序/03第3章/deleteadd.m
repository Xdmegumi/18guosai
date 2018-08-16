function b=deleteadd(a,m,alpha); 
%输入参数a表示原网络邻接矩阵，输入参数m表示重连操作次数；
%alpha为式（3.71）中调节因子，输出参数b为m次重新操作后新网络邻接矩阵
b=a; n=length(a); %n为已知网络的节点数
for i=1:m
    deg=sum(b); %计算当前网络各节点的度
    LP=(deg+alpha)/sum(deg+alpha); %计算各节点的连接概率
    pp=cumsum(LP);  %计算累积概率
    rnum=randperm(n); %产生1,2,…,n的全排列
    flag=1; %固定端点编号的地址，默认是第1个，下面修正
    while flag<n & deg(rnum(flag))==0 %当前节点为孤立点，取下一个节点
        flag=flag+1;
    end
    if flag==n & deg(rnum(flag))==0
        continue %当前节点为孤立点，循环进入下一个取值
    end
    ind1=find(b(:,rnum(flag))); %找固定端点i的邻居节点
    rnum2=randperm(length(ind1)); %产生全排列
    cnode=ind1(rnum2(1)); %cnode为可能删除边的另外一个端点
    ind2=find(pp>=rand); %产生一个随机数，找pp中元素大于该随机数的地址,
    %第一个地址作为加边的另外一个端点j'
    if rnum(flag)~=ind2(1) & b(rnum(flag),ind2(1))==0
        b(rnum(flag),cnode)=0; b(cnode,rnum(flag))=0;  %删除原边
        b(rnum(flag),ind2(1))=1; b(ind2(1),rnum(flag))=1; %添加新边
    end
end
