clc, clear, hold on
N=20; K=4; p=0.2; %N为网络节点总数，K为邻域节点个数，p为重连概率
t=0:2*pi/N:2*pi-2*pi/N;  %生成最近邻耦合网络各节点坐标的参数方程的角度
x=100*sin(t); y=100*cos(t);
plot(x,y,'ro','MarkerEdgeColor','g','MarkerFaceColor','r','markersize',6);
A=zeros(N);    %邻接矩阵初始化
for i=1:N      %该层循环构造最近邻K耦合网络的邻接矩阵
   for j=i+1:i+K/2
       jj=(j<=N)*j+(j>N)*mod(j,N); %如果j超过了N，要取除以N的余数
       A(i,jj)=1; A(jj,i)=1;
   end
end
for i= 1:N    %该层循环进行随机重连
   for j=i+1:i+K/2
       jj=(j<=N)*j+(j>N)*mod(j,N); 
       ChangeV=randi([1,N]); %产生随机整数，为可能重连的另外一个节点
       if rand<=p & A(i,ChangeV)==0 & i~=ChangeV  %重连的条件
          A(i,jj) = 0; A(jj,i) = 0; %删除原边
          A(i,ChangeV)=1; A(ChangeV,i)=1;  %重连新边
       end
   end
end
for i=1:N-1 
    for j=i+1:N
        if A(i,j)~=0
            plot([x(i),x(j)],[y(i),y(j)],'linewidth',1.2); 
        end
    end
end
%Matlab_to_Pajek(A)  %把邻接矩阵A转换为Pajek格式的数据，这里函数Matlab_to_Pajek是我们自己编写的函数，见下面的例3.2。
