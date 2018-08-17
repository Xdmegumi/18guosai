function A=WS_net(N,K,p);
A=zeros(N);    %邻接矩阵初始化
for i=1:N      %该层循环构造最近邻K耦合网络的邻接矩阵
   for j=i+1:i+K
       jj=(j<=N)*j+(j>N)*mod(j,N); %如果j超过了N，要取除以N的余数
       A(i,jj)=1; A(jj,i)=1;
   end
end
for i= 1:N    %该层循环进行随机重连
   for j=i+1:i+K
       jj=(j<=N)*j+(j>N)*mod(j,N); 
       ChangeV=randi([1,N]); %产生随机整数，为可能重连的另外一个节点
       if rand<=p & A(i,ChangeV)==0 & i~=ChangeV  %重连的条件
          A(i,jj) = 0; A(jj,i) = 0; %删除原边
          A(i,ChangeV)=1; A(ChangeV,i)=1;  %重连新边
       end
   end
end
