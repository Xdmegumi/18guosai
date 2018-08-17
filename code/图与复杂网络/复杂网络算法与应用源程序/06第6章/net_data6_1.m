clc, clear
a=zeros(10); a(1,[2 4 7])=1; a(2,[3 5 7])=1; a(3,6)=1;
a(4,7)=1; a(5,[6:8])=1; a(6,10)=1; a(7,[8 9])=1; a(8,10)=1;
a(9,10)=1; a=a+a'; %输入完整的邻接矩阵
[b,c]=myNRRW(a,1,10)
[b2,c2]=myURW(a,1,10)
bb=myBFS(a,1,10)
[b4,c4]=mySARW(a,1,10)
view(biograph(tril(a),[],'ShowArrows','off'))
[T,V,d,path]=myDS(a,1,10)

