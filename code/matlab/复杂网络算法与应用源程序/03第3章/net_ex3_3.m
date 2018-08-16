clc, clear, hold on
N=100; K=4; p=0.15; %N为网络节点总数,K为邻域节点个数,p为随机化加边概率
t=0:2*pi/N:2*pi-2*pi/N;  %生成最近邻耦合网络各节点坐标的参数方程的角度
x=100*sin(t); y=100*cos(t);
plot(x,y,'ko','MarkerEdgeColor','k','MarkerFaceColor','r','markersize',6);
A=zeros(N);    %邻接矩阵初始化
for i=1:N      %该层循环构造最近邻K耦合网络的邻接矩阵
   for j=i+1:i+K/2
       jj=(j<=N)*j+(j>N)*mod(j,N); %如果j超过了N，取除以N的余数
       A(i,jj)=1; A(jj,i)=1;
   end
end
B=rand(N); B=tril(B); %产生随机数，并截取下三角部分
C=zeros(N); C(B>=1-p)=1; C=C+C'; %C对应新产生边的完整邻接矩阵
A=A|C; %做逻辑或运算，产生加边以后的邻接矩阵
for i=1:N-1 
    for j=i+1:N
        if A(i,j)~=0
            plot([x(i),x(j)],[y(i),y(j)],'linewidth',1.2); 
        end
    end
end
Matlab_to_Pajek(A)  %生成Pajek数据，文件名为Pajek_data1.net
