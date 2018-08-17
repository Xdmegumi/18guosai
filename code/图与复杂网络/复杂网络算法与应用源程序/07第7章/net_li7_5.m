clc, clear, n=10; a=zeros(n); 
a(1,[2 3 5:7])=1; a(2,[3 5:7])=1; a(3,[4:6])=1;
a(4,[5 6])=1; a(5,[6 9 10])=1; a(6,[7:9])=1;
a(7,[8 9])=1; a(8,9)=1; a(9,10)=1; A0=a+a'; %构造完整邻接矩阵
a=a'; a=sparse(a); %变成Matlab工具箱需要的数据类型
name=cellstr(int2str([1:n]')); %构造网络顶点标号字符串的细胞数组
h=view(biograph(a,name,'ShowArrows','off','ShowWeights','off'))
h.EdgeType='segmented'; %边的连接为线段
h.LayoutType='equilibrium'; %网络布局类型为平衡结构
set(h.Edges,'LineWidth',1.5);
set(h.Nodes,'Fontsize',15);
set(h.Nodes,'shape','circle','Size',[10,15]); %修改顶点形状
dolayout(h) %刷新图形
for k=1:n
    A=k; B=find(A0(k,:)); %找k的邻居节点
    while length(B)
        A=[A B(1)]; B(1)=[]; ind=[];
        for i=1:length(B)
          if sum(A0(B(i),A))<length(A) 
            ind=[ind,i]; %记录下B中不与A中所有节点相连的节点
          end
        end
        B(ind)=[]; %删除B中不与A中所有节点相连的节点
    end
    AA{k}=sort(A); %找到从每一个点出发的最大派系
end
celldisp(AA) %显示从每个节点开始的派系
k=1;BB{1}=AA{1}; %下面去掉AA中的重复派系，计算结果放入BB
for i=2:length(AA)
    for j=1:length(BB)
        if sum(ismember(AA{i},BB{j}))==length(AA{i})
            break %如果AA{i}是BB中某个子集，不加入BB
        end
        if j==length(BB) %AA{i}不是BB中的某个子集
            k=k+1; BB{k}=AA{i}; %AA{i}加入BB
        end
    end
end
celldisp(BB) %显示没有重复的派系
for i=1:length(BB) 
    for j=1:length(BB)
        c(i,j)=sum(ismember(BB{i},BB{j})); %计算重叠矩阵
    end
end
c %显示重叠矩阵
d=zeros(size(c)); %4派系邻接矩阵初始化
for i=1:size(d,1)
    for j=1:size(d,2)
        d(i,j)=double((i~=j)&(c(i,j)>=3))+double((i==j)&(c(i,j)>=4));
    end
end
d
st=union(union(BB{1},BB{2}),BB{3}) %提取最大社团的节点集
E=A0(st,st); %提取最大社团结构的邻接矩阵
E=tril(E); E=sparse(E);
st=cellstr(int2str(st'));
h2=view(biograph(E,st,'ShowArrows','off','ShowWeights','off'))
h2.EdgeType='segmented'; %边的连接为线段
h2.LayoutType='equilibrium'; %网络布局类型为平衡结构
dolayout(h2) %刷新图形  
