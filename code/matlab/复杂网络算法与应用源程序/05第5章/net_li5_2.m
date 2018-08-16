clc, clear
sigma=10; rho=28; beta=8/3;
g=@(t,f)[sigma*(f(2)-f(1)); rho*f(1)-f(2)-f(1)*f(3); f(1)*f(2)-beta*f(3)]; %定义微分方程组的右端项
chuzhi=rand(3,1); %初始值
[t,xyz]=ode45(g,[0,100],chuzhi); %求数值解
plot3(xyz(:,1),xyz(:,2),xyz(:,3)) %画图5.2
xlabel('\it x(t)'), ylabel('\it y(t)'), zlabel('\it z(t)','rotation',0)
box on %加盒子线，以突出立体感
so=ode45(g,[0,100],chuzhi+0.00001) %初值变化后，再求数值解
xyz2=deval(so,t); %计算对应的x,y,z的值
figure(2), plot(t,xyz(:,1)-xyz2(1,:)','.-') %求x的差，画图5.3。注意xyz逐列对应x,y,z的数值解，xyz2逐行对应x,y,z的数值解
xlabel('\it t'), ylabel('\it x_1(t)-x_2(t)','rotation',0)
