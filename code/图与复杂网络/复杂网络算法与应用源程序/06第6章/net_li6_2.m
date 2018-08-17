clc, clear
a=zeros(11); 
a(1,2)=1; a(2,[3,10])=1; a(3,[4:6])=1;
a(6,7)=1; a(7,[8:10])=1; a(10,11)=1;
A=a+a';s=1; t=11;
[dd,path,d,road]=refine_DS(A,1,11)
