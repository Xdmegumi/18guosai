function mysierpinski(N)
if nargin==0; N=20000; end;
A=0; B=100; C=complex(50,sqrt(3)*50); %用复数表示的三角形三个点A，B，C的坐标
P=10+20i;  %任取三角形内的一点
TP=[]; %所有生成点的初始化 
gailv=randperm(N); %产生1到N的随机全排列
for k=gailv
       if k<N/3+1; 
           P=(P+A)/2; %生成新点为点P和A的中点 
       elseif k<2*N/3+1 
           P=(P+B)/2; %生成新点为点P和B的中点
       else 
           P=(P+C)/2; %生成新点为点P和C的中点
       end 
       TP=[TP,P];  %TP中加入新点
end 
plot(TP,'.','markersize',5)  %画所有生成的新点
