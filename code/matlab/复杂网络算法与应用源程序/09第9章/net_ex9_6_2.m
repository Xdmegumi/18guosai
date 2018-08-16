function net_ex9_6_2
clc, global A B, load AB %定义全局变量，并加载数据
fxy=@(xy)sum(xy); %定义虚拟的目标函数
Aeq=[ones(1,3),zeros(1,3);zeros(1,3),ones(1,3)],beq=ones(2,1) %等号约束
[xy,f]=fmincon(fxy,rand(6,1),[],[],Aeq,beq,zeros(6,1),ones(6,1),@erci);
x=xy(1:3), y=xy(4:6) %分别显示甲队和乙队的混合策略
v1=x'*A*y, v2=x'*B*y %求各队的平均得分
function [c,ceq]=erci(xy); %d定义非线性约束函数
global A B
for i=1:3
    c(i)=A(i,:)*xy(4:6)-xy(1:3)'*A*xy(4:6); %定义非线性不等式约束
    c(3+i)= B(:,i)'*xy(1:3)-xy(1:3)'*B*xy(4:6);
end
ceq=[]; %定义非线性等式约束
