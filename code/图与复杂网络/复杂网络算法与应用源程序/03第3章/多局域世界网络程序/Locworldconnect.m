function B=Locworldconnect(A);
C=tril(A); C=sparse(C);%生成Matlab工具箱需要的邻接矩阵下三角元素稀疏矩阵
[num,label]=graphconncomp(C,'directed',0);%求连通分支数和每个节点的分支编号
if num==1
    B==A; return %一个连通分支时，返回
end
for i=1:num
    n{i}=find(label==i);  %求第i个连通分支中的节点编号
end
B=A; deg=sum(A);  %计算各节点的度
for i=1:num
    p1=(deg(n{i})+1)/sum(deg(n{i})+1);   %提取第i个分支各节点的度
    pp1=cumsum(p1); %求累积概率
    ii=(i+1)*(i+1<=num)+mod(i+1,num)*(i+1>num); %i+1分支编号的转换
    p2=(deg(n{ii})+1)/sum(deg(n{ii})+1); %提取第i+1分支节点的度
    pp2=cumsum(p2);  %求累积概率
    ind1=find(pp1>=rand);  %产生一个随机数，找pp1中大于等于该随机数的地址
    ind2=find(pp2>=rand);  %产生一个随机数，找pp2中大于等于该随机数的地址
    B(n{i}(ind1(1)),n{ii}(ind2(1)))=1; %两个局域世界之间连边  
    B(n{ii}(ind2(1)),n{i}(ind1(1)))=1; 
end
