clc, clear
m=5; m0=8; e0=15; p=0.3; q=0.2; r=0.25; s=0.05; u=0.2;
m1=3; m2=5; m3=4; m4=6; alpha=1;
p=[p,q,r,s,u]; n=m; %n为局域世界的个数
pp=cumsum(p); %求累积概率分布
for i=1:m
    A{i}=generategraph(m0,e0); 
end
num(1:m)=m0; %各局域世界的节点数
Tno=[]; Tuv=[]; %步骤（5）全部返回值的初始化
for i=1:1000
    ind=find(pp>=rand);  %产生一个随机数，找pp中大于该随机数的地址
    switch ind(1)
        case 1
            n=n+1; A{n}=generategraph(m0,e0); %产生一个新局域世界
            num(n)=length(A{n});
        case 2
            rn=randperm(n); k=rn(1); %选择一个局域世界
            A{k}=addnode(A{k},m1,alpha); %加节点
num(k)=length(A{k});
        case 3
            rn=randperm(n); k=rn(1); %选择一个局域世界
            A{k}=addedge(A{k},m2,alpha); %加边
        case 4
            rn=randperm(n); k=rn(1); %选择一个局域世界
            A{k}=deleteedge(A{k},m3,alpha); %删除边
        otherwise
            [no,uv]=addlongedge(A,m4,alpha); %加长程边
            Tno=[Tno,no];  %长程边的局域世界编号，每列对应一条边
            Tuv=[Tuv,uv];  %长程边在对应的局域世界的节点编号
    end
end
B=blkdiag(A{:}); %拼分块对角矩阵，构成一个大的邻接矩阵
num=[0,num];  %为计算方便，添加一个0;否则第一个要特殊处理 
cnum=cumsum(num); %计算邻域节点的累加值
for i=1:length(Tno)
    u=cnum(Tno(1,i))+Tuv(1,i); %长程边的一个端点在整个大网络中的节点编号
    v=cnum(Tno(2,i))+Tuv(2,i); %长程边的另一个端点在整个大网络中的节点编号
    B(u,v)=1; B(v,u)=1;
end
dp1=mydegree(B);  %求度的频数分布表
Matlab_to_Pajek(B); %生成Pajek需要的数据
B=degreeaddedge(B); %对度为0或1的节点随机加边
dp2=mydegree(B);  %求度的频数分布表
Matlab_to_Pajek(B,2); %生成Pajek需要的数据
B=Locworldconnect(B); %对孤立的局域世界进行连接
dp3=mydegree(B);  %求度的频数分布表
Matlab_to_Pajek(B,3);
[h,p,st]=poisstest(dp3) 
[D,L]=myAPL(B) %D为网络直径，L为平均路径长度
[TC,c]=mycluster(B) %TC为整个网络的聚类系数，c为各个节点的聚类系数
r=mycorrelations(B)   %求度相关系数
core=mycoreness(B)    %求各节点的核数
figure,plot([1:length(B)],sum(B),'-*'),
xlabel('节点编号'), ylabel('节点度的值')
save checkdata2 dp1 dp2 dp3 core
