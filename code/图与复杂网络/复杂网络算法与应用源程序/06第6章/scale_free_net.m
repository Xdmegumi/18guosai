function A=scale_free_net(N,gamma,m)
%Goh等人提出的幂律指数可调的无标度网络，A返回为邻接矩阵
%网络规模N,无标度指数gamma(gamma>2),m为网络的平均度的一半
alpha=1/(gamma-1);
p=[1:N].^(-alpha); %赋权值
p=p/sum(p);   %归一化
cp=cumsum(p); %求累积和
A=zeros(N,N);t=0;
while t<m*N        %按权重概率加边
    r1=rand; r2=rand; %生成一对随机数
    u=find(cp>=r1,1);v=find(cp>=r2,1); %求生成边的顶点编号
    if u~=v && A(u,v)==0
        A(u,v)=1; A(v,u)=1; t=t+1;
    end
end
