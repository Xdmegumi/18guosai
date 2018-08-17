function B=degreeaddedge(A);
%输入参数A是存在孤立点的网络的邻接矩阵
%B是按照度优先规则加边后构成的网络的邻接矩阵
B=A; 
while any(sum(B)<=1)
    deg=sum(B); %求各节点的度
    p=(deg+1)/sum(deg+1);  %求各节点的加边概率
    pp=cumsum(p);  %求累积概率
    k=find(deg<=1);
    for i=k
    ind=find(pp>=rand);jj=ind(1); %jj为用赌轮法选择的节点地址
      if jj~=i 
         B(i,jj)=1; B(jj,i)=1; 
      end
    end
end
