clc, clear
N=200; K=10; p=0.0101; %N为节点总数,K为邻域节点个数,p为随机化加边概率
lambda=[];
for k=1:500
A=zeros(N);    %邻接矩阵初始化
for i=1:N      %该层循环构造最近邻K耦合网络的邻接矩阵
   for j=i+1:i+K/2
       jj=(j<=N)*j+(j>N)*mod(j,N); %如果j超过了N，要取除以N的余数
       A(i,jj)=1; A(jj,i)=1;
   end
end
B=rand(N); B=tril(B); %产生随机数，并截取下三角部分
C=zeros(N); C(B>=1-p)=1; C=C+C'; %C对应新产生边的完整邻接矩阵
A2=double(A|C); %做逻辑或运算，产生加边以后的邻接矩阵
deg2=sum(A2); L2=A2-diag(deg2);
val=eigs(L2,2,'la'); lambda=[lambda,val(2)];
end
fw=minmax(lambda) %求第二大特征值的范围
