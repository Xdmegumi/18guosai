function [dd,path,d,road]=refine_DS(A,s,t);
%改进的最大度搜索，A为网络邻接矩阵，s为源节点，t为目标节点,dd为改进前的路径长度, path为改进前的路径，d为改进后路径长度，road为改进后的最短路径，
[T,V,d,road]=myDS(A, s, t); dd=d; path=road;
if length(road)>=3  %未改进前每条路径至少要经过3个节点
    t=0; cv=road(end-t);%从路径最后节点开始分析是不是前面节点的邻居节点
while cv~=s
     if sum(A(cv,road(1:end-t-2))) %cv和road中的某个节点相邻
         bh=find(A(cv,road(1:end-t-2))==1,1); %求cv邻接节点的地址
         bv=find(road==cv); %求cv的地址
         road(bh+1:bv-1)=[]; %删除长路径的中间节点
     end
     t=t+1; cv=road(end-t);
end
     d=length(road)-1;
end
