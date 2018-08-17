clc
clear
fitnessfcn = @Fun;
nvars = 2;
lb = [-5,-5];
ub = [5,5];
A = [];
b = [];
Aeq = [];
beq = [];
%gamultiobj函数的参数设置
%最优个体系数paretoFraction = 0.3
%种群大小populationsize = 100
%最大进化代数generations = 200
%停止代数stallGenLimit = 200
%适应度函数偏差TolFun设为1e-10
%函数gaplotpareto绘制Pareto前沿
options = gaoptimset('paretoFraction',0.3,'populationsize',200,'generations',300,'stallGenLimit',200,'TolFun',1e-10,'PlotFcns',@gaplotpareto);
[x,fval] = gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,options)