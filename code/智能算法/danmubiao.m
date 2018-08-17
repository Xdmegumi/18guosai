clear 
clc 
fitnessfcn=@Fun2;        %调用适应度函数
nvars=30;                %变量个数
lb=zeros(1,30);       %变量区间
ub=ones(1,30); 
N=30;                    %运行次数
A=[];b=[];               %约束条件
IntCon=1;
Aeq=[];beq=[]; 
% [x,fval,exitflag] = ga(@rastriginsfcn,2,[],[],[],[],...
%     lb,ub,[],IntCon,opts)
% 绘图设置
options=gaoptimset('populationsize',1000,'generations',300,'stallGenLimit',200,'TolFun',1e-10,'MutationFcn', {@mutationadaptfeasible, 0.9},'CrossoverFraction',0.9,'PlotFcns',{@gaplotbestindiv,@gaplotbestf});
[x,fval]=ga(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,[],[1:30],options);   %初始化一张图，方便循环比较
saveas(gcf,'output','png');                                   %存储第一张图
INDEX(1)=fval;                                                %通过最优适应度函数值数组定位全局（指的30次中）最优解
Anwser(1).x=x;                                                %通过结构体保留每一次的最优解
%  for i=2:N
%  [x,fval]=ga(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,[],options);
%  %对必信息进行保留
%  INDEX(i)=fval;          
%  Anwser(i).x=x;    
%  %选择最佳图片保存
%  if(fval==min(INDEX))
%      delete output;
%      saveas(gcf,'output','png');
%  end   
%  end 

[minvalue,indexmin]=min(INDEX);   %确定最优解位置
[maxvalue,indexmax]=max(INDEX);   %确定最差解位置

%求解所需数据，绘制表格
r=mean(INDEX);
t=var(INDEX);
table=[minvalue,maxvalue,r,t];
bestanwser=Anwser(indexmin).x;
bestvalue=INDEX(indexmin);
disp(table);
disp(bestvalue);