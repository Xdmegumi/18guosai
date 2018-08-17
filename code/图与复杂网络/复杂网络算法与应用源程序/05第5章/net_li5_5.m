clc, clear, m0=3; m=3; N=2000;
A=ones(m0); A(1:m0+1:m0^2)=0; %对角线元素置0
for k=m0+1:N
    p=(sum(A)+1)/sum(sum(A)+1); %计算所有节点的连接概率
    pp=cumsum(p); %求累积分布
    A(k,k)=0;   %加入新的连边之前，邻接矩阵扩充维数
    ind=[]; %新节点所连节点的初始集合
    while length(ind)<m
        jj=find(pp>rand); jj=jj(1); %用赌轮法选择连边节点的编号
        ind=union(ind,jj); %使用union保证选择的节点不重复
    end
    A(k,ind)=1; A(ind,k)=1; %构造加边以后新的邻接矩阵
end
L=A-diag(sum(A));
val=eigs(L,2,'la'); lambda=val(2); lambda1=lambda;
dp=[0:0.01:0.05]; %删除节点的比例
for i=2:length(dp);
    B=A; nf=floor(N*dp(i));
    rint=randperm(N); %生成一个随机整数数列
    db=rint([1:nf]); %删除节点的编号
    B(db,:)=[]; B(:,db)=[];
    L=B-diag(sum(B)); 
    val=eigs(L,2,'la'); lambda1=[lambda1,val(2)];
end
lambda1, subplot(121), plot(dp,lambda1,'o-')
xlabel('删除概率\itp'), ylabel('第二大特征值\it\lambda_2')
deg=sum(A); [sd,ind2]=sort(deg,'descend'); %把度按照从大到小排列
lambda2=lambda; st=[];
for i=2:length(dp)
    B=A; B2=tril(A); B2=sparse(B2);
    s=graphconncomp(B2,'Directed',0); %计算连通分支的个数
    st=[st,s]; %记录对应的连通分支个数
    nf2=floor(N*dp(i)); %计算删除的节点数
    db=ind2(1:nf2); %删除的节点编号
    B(db,:)=[]; B(:,db)=[];
    L=B-diag(sum(B));
    val=eigs(L,2,'la'); lambda2=[lambda2,val(2)];
end
lambda2, subplot(122), plot(dp,lambda2,'*-')
xlabel('删除概率\itp'), ylabel('第二大特征值\it\lambda_2')
st %显示连通分支的个数
