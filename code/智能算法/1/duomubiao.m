clear
clc
fitnessfcn=@Fun4;
nvars=30;
%第四问边界条件
%  lb=[0,-5,-5,-5,-5,-5,-5,-5,-5,-5];
%  ub=[1,5,5,5,5,5,5,5,5,5];
lb=zeros(1,10);
ub=ones(1,10);
A=[];b=[];
Aeq=[];beq=[];
IntCon=1;
% [x,fval,exitflag] = ga(@rastriginsfcn,2,[],[],[],[],...
%     lb,ub,[],IntCon,opts)
options=gaoptimset('paretoFraction',0.3,'populationsize',200,'generations',300,'stallGenLimit',200,'TolFun',1e-10,'PlotFcns',@gaplotpareto);
[x,fval]=gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,[],options);
