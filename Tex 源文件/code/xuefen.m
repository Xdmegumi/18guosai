clear,clc;
xuefen_1=[5,4,4,3,4,3,2,2,3];
%% function
f=-ones(1,9).*xuefen_1;
A=[-1,-1,-1,-1,-1,0,0,0,0;
    0,0,-1,0,-1,-1,0,-1,-1;
    0,0,0,-1,0,-1,-1,0,-1;
    0,0,0,0,0,1,-1,0,0;
    0,0,0,0,-1,0,0,1,0;
    0,0,0,1,0,0,-1,0,0;
    -1,-1,2,0,0,0,0,0,0;
    -1,-1,0,0,2,0,0,0,0;
    -1,-1,0,0,0,0,0,0,2;];
b=[-2,-3,-2,0,0,0,0,0,0]';
%% Equality constraints
Aeq=ones(1,9);
beq=6; % the minimum number of courses
intcon=1:9;
[x,fval]=intlinprog(f,intcon,A,b,Aeq,beq,zeros(9,1),ones(9,1))