clc, clear, format rat
n=6; a=zeros(n);
a(1,[2 3 5])=1; a(2,[3 4])=1; %输入邻接矩阵的上三角元素
a(3,6)=1; a(4,6)=1;
a=a+a'; %输入完整的邻接矩阵
d=sum(a)  %计算邻接矩阵的列和,即各节点的度
degrange=minmax(d); %求度取值的最小值和最大值
ud=[degrange(1): degrange(2)] %显示度的取值
pinshu=hist(d,ud); %求度取值的频数
df=[ud; pinshu/n] %求度的频率分布表
ave_degree=mean(d)  %计算平均度
M=sum(d)/2;  %计算总边数，边的总数等于所有点度的和的一半
[i,j]=find(triu(a)); %找a矩阵上三角元素中的非零元素所在的行标和列标，即每条边的两个端点
ki=d(i); kj=d(j); %提取所有边的起点度和终点度
kij=[ki' kj'];  kij=sort(kij,2); %逐行从小到大排列
bpin=[]; %联合度分布的初始化
for i=1:length(ud)
    for j=i:degrange(2)
        b(i,j)=0; kk=[];
        for k=1:size(kij,1)
            b(i,j)=b(i,j)+length(findstr(kij(k,:),[i,j]));
            if length(findstr(kij(k,:),[i,j]))
                kk=[kk,k]; %记录找到的数据
            end
        end
        kij(kk,:)=[]; %删除已找到的数据
        bpin=[bpin, [i;j;b(i,j)/M]];
    end
end
bpin%显示联合度分布，第1,2行为度值，第3行为计算的频率
knni=d*a./d  %计算最近邻平均度值
for i=1:length(ud)
    ind=(d==ud(i)); 
    knn(i)=sum(knni(ind))/pinshu(i);
end
knn=[ud;knn] %显示最近邻平均度值的平均值，第一行是度的取值，第二行是计算得到的平均值
r=mycorrelations(a)  %计算Pearson相关系数
core=mycoreness(a)  %计算核数
