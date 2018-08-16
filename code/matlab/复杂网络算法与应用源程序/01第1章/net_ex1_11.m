clc, clear
a=[5	4.5	4	3.75	3	2.5
0.5	1	1.5	2	2.5	3
0	1.5	2.2	2.5	3	3.5];
cha=a(1,:)-a(2,:);
cumcha=cumsum(cha)
w=zeros(6);
for i=1:5
    w(i,[i+1:end])=cumcha(1:end-i)-[a(3,[2:end-i]),0];
end
w
w=-w; w=sparse(w);
[d,path]=graphshortestpath(w,1,6,'Method','Bellman-Ford')
