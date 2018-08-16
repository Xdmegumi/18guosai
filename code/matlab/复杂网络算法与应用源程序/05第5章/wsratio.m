function wsratio %这里也可以不定义函数，把该行注释
N=1000; K=4; pp=[0.08:0.05:1]; %N为网络节点总数，K为邻域节点个数，pp为重连概率
for k=1:length(pp)
    p=pp(k);A=zeros(N);    %邻接矩阵初始化
    for i=1:N      %该层循环构造最近邻K耦合网络的邻接矩阵
       for j=i+1:i+K/2
           jj=(j<=N)*j+(j>N)*mod(j,N); %如果j超过了N，要取除以N的余数
           A(i,jj)=1; A(jj,i)=1;
       end
    end
    for i=1:N    %该层循环进行随机重连
       for j=i+1:i+K/2
           jj=(j<=N)*j+(j>N)*mod(j,N); 
           ChangeV=randi([1,N]); %产生随机整数，为可能重连的另外一个节点
           if rand<=p & A(i,ChangeV)==0 & i~=ChangeV  %重连的条件
              A(i,jj) = 0; A(jj,i) = 0; %删除原边
              A(i,ChangeV)=1; A(ChangeV,i)=1;  %重连新边
           end
       end
    end
    deg=sum(A); L=A-diag(deg); %构造矩阵
    val=eigs(L,2,'la'); %求前两个最大特征值
    lmin=val(2); %提出第二大特征值
    lmax=eigs(L,1,'sa'); %求最小特征值
    ratio(k)=abs(lmax/lmin);
end
[pp; ratio]  %显示重连概率与特征值之比绝对值之间的关系
plot(pp,ratio,'S-')
xlabel('\it p'), ylabel('\it \lambda_{max}/\lambda_{min}')
