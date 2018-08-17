clc, clear
a=zeros(6);
a(1,[2 4])=[8 7]; a(2,[3 4])=[9 5]
a(3,[4 6])=[2 5]; a(4,5)=9; a(5,[3 6])=[6 10];
a=sparse(a);  %转化成稀疏矩阵
[c,d]=graphmaxflow(a,1,6)  %求最大流
view(biograph(d,[],'ShowArrows','on','ShowWeights','on'))  %画出最大流
