function tongbueq1
global w a b r c L1 L2
w=1.0; a=0.165; b=0.2; r=10; c=1;
N=200; K=10; p=0.0101; %N为网络节点总数,K为邻域节点个数,p为随机化加边概率
A=zeros(N);    %邻接矩阵初始化
for i=1:N      %该层循环构造最近邻K耦合网络的邻接矩阵
   for j=i+1:i+K/2
       jj=(j<=N)*j+(j>N)*mod(j,N); %如果j超过了N，要取除以N的余数
       A(i,jj)=1; A(jj,i)=1;
   end
end
deg1=sum(A); L1=A-diag(deg1);
B=rand(N); B=tril(B); %产生随机数，并截取下三角部分
C=zeros(N); C(B>=1-p)=1; C=C+C'; %C对应新产生边的完整邻接矩阵
A2=double(A|C); %做逻辑或运算，产生加边以后的邻接矩阵
deg2=sum(A2); L2=A2-diag(deg2);
[t1,X1]=ode45(@(t,x)equa1(t,x,L1),[0,500],unifrnd(-1,1,600,1));
plot(t1,X1(:,[1:3:15])) %画出前5个节点x分量的取值
xlabel('\it t'), ylabel('\it x','rotation',0)
[t2,X2]=ode45(@(t,x)equa1(t,x,L2),[0,5],unifrnd(-1,1,600,1));
figure(2), plot(t2,X2(:,[1:3:end])) %画出200个节点的x分量的取值
xlabel('\it t'), ylabel('\it x','rotation',0)
function dX=equa1(t,X,L);
global w a b r c L2
X=reshape(X,[3,200]); %把向量X变成3×200的矩阵
for i=1:200
    DX(1,i)=-w*X(2,i)-X(3,i)+c*sum(L(i,:).*X(1,:));
    DX(2,i)=w*X(1,i)+a*X(2,i)+c*sum(L(i,:).*X(2,:));
    DX(3,i)=b+X(3,i)*(X(1,i)-r)+c*sum(L(i,:).*X(3,:));
end
dX=DX(:); %把3×200的矩阵变成列向量
