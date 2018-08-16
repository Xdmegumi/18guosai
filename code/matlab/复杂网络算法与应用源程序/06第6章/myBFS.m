function T=myBFS(A,s,t);
% 广度优先搜索BFS，A为网络邻接矩阵，s为源节点，t为目标节点,T为搜索步数，
T=0; TV=s; U=s; %TV为当前节点，U为已访问节点集合
if s==t
    T=0, return
end
while ~ismember(t,TV)
    T=T+1;
    n=length(TV);  %当前节点的个数
    TV2=[]; %新的当前点初始化
    for i=1:n
        nodes=find(A(TV(i),:)==1);  %查找当前节点的邻居节点
        V=setdiff(nodes,U); TV2=[TV2,V]; U=[U,V];
    end
    TV=TV2; %新的当前节点
end
