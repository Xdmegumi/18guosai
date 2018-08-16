clc, clear, n=9;
a=zeros(n); a(1,[2 3])=1; a(2,3)=1; a(3,[4 6])=1;
a(4,5)=1; a(5,[7 8 9])=1; a(6,7)=1; a(8,9)=1;
A=a+a'; %供下面备用
a=a'; a=sparse(a); 
d=graphallshortestpaths(a,'Directed',0); %求最短距离
rhi=(n-1)./sum(sum(d)) %计算初始网络凝聚度
for t=1:n
    b=zeros(n); [i,j]=find(a); %求所有边的编号
    ind=find(A(t,:)); %找顶点t的邻居节点
    for k=1:length(ind)
        i(i==ind(k))=t; j(j==ind(k))=t; %把t邻居节点的编号替换为t
    end
    for k=1:length(i)
        b(i(k),j(k))=1; %把与t邻居节点的链接变成与t的链接
    end
    b(t,t)=0; 
    b=b+b'; b(:,ind)=[]; b(ind,:)=[]; %把t的邻居节点删除
    b=tril(b); b=sparse(b);
    dd=graphallshortestpaths(b,'Directed',0);
    rh(t)=(length(b)-1)/sum(sum(dd));
end
IMC=1-rhi./rh %求所有顶点的凝聚度
bar(IMC)
