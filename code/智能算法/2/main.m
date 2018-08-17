clear 
clc 
fitnessfcn=@Fun;
 nvars=2; 
 lb=[0.1,0]; 
 ub=[1,5]; 
 A=[-9,-1;-9,1];b=[-6;-1]; 
 Aeq=[];beq=[]; 
 
options=gaoptimset('paretoFraction',0.4,'populationsize',200,'generations',300,'stallGenLimit',300,'TolFun',1e-10,'PlotFcns',@gaplotpareto); 

[x,fval]=gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,options)
