function nweigval2
p1=0.05; N=100:2:1000; p2=0.1;
for i=1:length(N)
    lam1(i)=secondeig(N(i),2,p1);
end
subplot(121), plot(N,lam1), xlabel('\it N')
ylabel('\it \lambda_2','rotation',0)
for i=1:length(N)
    lam2(i)=secondeig(N(i),2,p2);
end
subplot(122), plot(N,lam2), xlabel('\it N')
ylabel('\it \lambda_2','rotation',0)
function lamda=secondeig(N,K,p)
A=zeros(N);    %邻接矩阵初始化
for i=1:N      %该层循环构造最近邻K耦合网络的邻接矩阵
   for j=i+1:i+K/2
       jj=(j<=N)*j+(j>N)*mod(j,N); %如果j超过了N，要取除以N的余数
       A(i,jj)=1; A(jj,i)=1;
   end
end
B=rand(N); B=tril(B); %产生随机数，并截取下三角部分
C=zeros(N); C(B>=1-p)=1; C=C+C'; %B对应新产生边的完整邻接矩阵
A=double(A|C); %做逻辑或运算，产生加边以后的邻接矩阵
deg=sum(A); L=A-diag(deg); %构造矩阵
val=eigs(L,2,'la'); %求前两个最大特征值
lamda=val(2); %提出第二大特征值
