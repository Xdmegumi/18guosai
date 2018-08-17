function mysierpinski_n(x,y,L,n,N);
if nargin==0
x=10; y=20; %(x,y)为初始点，取为正n边形内的任意一点
L=100; n=3; N=20000; %L为正n边形的中心到顶点的距离，N为画的总点数
end
t=pi/2:2*pi/n:2*pi+pi/2;   %正n边形顶点复数表示的幅角
Pxy=L*complex(cos(t),sin(t)); %正n边形n个顶点坐标，这里是n+1个点，首尾顶点相同
P=complex(x,y);  %构造三角形内的一点
TP=[]; %所有生成点的初始化 
gailv=randperm(N); %产生1到N的随机全排列
biaohao=zeros(size(gailv)); %N个随机整数对应的1到n的标号的初始值
for k=1:n-1
    ind=(gailv>=(k-1)*N/n & gailv<k*N/n);
    biaohao(ind)=k;
end
ind=(gailv>=(n-1)*N/n); biaohao(ind)=n;
for k=biaohao
    P=0.5*(P+Pxy(k)); TP=[TP,P];
end
hold on, plot(TP,'.','markersize',5)  %画所有生成的新点
