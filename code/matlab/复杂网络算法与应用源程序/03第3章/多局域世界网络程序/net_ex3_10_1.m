clc, clear
m=5; m0=8; e0=15; p=0.3; q=0.2; r=0.25; s=0.05; u=0.2;
m1=3; m2=5; m3=4; m4=6; alpha=0.5;
p=[p,q,r,s,u]; n=m; %局域世界个数的初始化
pp=cumsum(p); %求累积概率分布
for i=1:m
    A{i}=generategraph(m0,e0); 
end
num(1:m)=m0; %各局域世界的节点数
Tno=[]; Tuv=[]; %步骤（5）全部返回值的初始化
for i=1:2000
    ind=find(pp>=rand);  %产生一个随机数，找pp中大于该随机数的地址
    switch ind(1)
        case 1
            n=n+1; A{n}=generategraph(m0,e0);   %调用自定义函数
            num(n)=length(A{n});
        case 2
            rn=randperm(n); k=rn(1); %选择一个局域世界
            A{k}=addnode(A{k},m1,alpha); num(k)=length(A{k});
        case 3
            rn=randperm(n); k=rn(1); %选择一个局域世界
            A{k}=addedge(A{k},m2,alpha);
        case 4
            rn=randperm(n); k=rn(1); %选择一个局域世界
            A{k}=deleteedge(A{k},m3,alpha);
        otherwise
            [no,uv]=addlongedge(A,m4,alpha);
            Tno=[Tno,no];  %长程边的局域世界编号，每列对应一条边
            Tuv=[Tuv,uv];  %长程边在对应的局域世界的节点编号
    end
end
B=blkdiag(A{:}); %拼分块对角矩阵，构成一个大的邻接矩阵
num=[0,num];  %为计算方便，添加一个0 
cnum=cumsum(num); %计算邻域节点的累加值
for i=1:length(Tno)
    u=cnum(Tno(1,i))+Tuv(1,i); %长程边的一个端点在整个大网络中的节点编号
    v=cnum(Tno(2,i))+Tuv(2,i); %长程边的另一个端点在整个大网络中的节点编号
    B(u,v)=1; B(v,u)=1;
end
dp=mydegree(B);  %求度的频数分布表
d=dp(1,:)';  %提取度的取值,且转换成列向量
gd=(dp(2,:)/length(B))';  %求度的频率分布，且转换成列向量
subplot(1,2,1), plot(d,gd,'-o')
xlabel('度'),ylabel('度的频率'),title('线性坐标')
subplot(1,2,2), loglog(d,gd,'-*')
xlabel('度'),ylabel('度的频率'), title('对数坐标')
Matlab_to_Pajek(B); %把邻接矩阵转化成Pajek数据
