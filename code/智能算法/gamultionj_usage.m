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
%gamultiobj�����Ĳ�������
%���Ÿ���ϵ��paretoFraction = 0.3
%��Ⱥ��Сpopulationsize = 100
%����������generations = 200
%ֹͣ����stallGenLimit = 200
%��Ӧ�Ⱥ���ƫ��TolFun��Ϊ1e-10
%����gaplotpareto����Paretoǰ��
options = gaoptimset('paretoFraction',0.3,'populationsize',200,'generations',300,'stallGenLimit',200,'TolFun',1e-10,'PlotFcns',@gaplotpareto);
[x,fval] = gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,options)