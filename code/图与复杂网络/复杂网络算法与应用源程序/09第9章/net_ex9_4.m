clc, clear
a=[1/3,1/2,-1/3;-2/5,1/5,-1/2;1/2,-3/5,1/3];
c1=[zeros(3,1);-1]; %构造（9.17）的目标向量
A=[-a',ones(3,1)]; %构造（9.17）的不等号约束矩阵
Aeq=[ones(1,3),0];%构造（9.17）的等号约束矩阵
Lb=[zeros(3,1);-inf]; Ub=[ones(3,1);inf];
[xu,f1]=linprog(c1,A,zeros(3,1),Aeq,1,Lb,Ub)
c2=[zeros(3,1); 1]; %构造（9.18）的目标向量
B=[a,-ones(3,1)]; %构造（9.18）的不等号约束矩阵
[yv,f2]=linprog(c2,B,zeros(3,1),Aeq,1,Lb,Ub)
