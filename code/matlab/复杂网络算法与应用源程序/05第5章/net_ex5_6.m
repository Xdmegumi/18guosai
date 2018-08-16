clc, clear;
yinit=[1,1,1]; orthmatrix=eye(3);
a=0.165; b=0.20; c =10.0;
y=zeros(12,1); %初始化输入
y(1:3)=yinit;
y(4:12)=orthmatrix;
tstart=0; % 时间初始值
steps=0.01; % 每次演化的步数
n=10000; % 演化的次数
lp=zeros(1,3);
Lyapunov1=zeros(n,1); %初始化Lyapunov指数
Lyapunov2=zeros(n,1);
Lyapunov3=zeros(n,1);
for i=1:n
    tspan = [tstart, tstart+steps];   
    [T,Y] = ode45('au_Rossler', tspan, y);
    % 取积分得到的最后一个时刻的值
    y=Y(size(Y,1),:);
    % 重新定义起始时刻
    tstart = tstart+steps;
    V=[y(4) y(7) y(10);
       y(5) y(8) y(11);
       y(6) y(9) y(12)];
    A(:,1)=V(:,1); %施密特正交化
    A(:,2)=V(:,2)-dot(A(:,1),V(:,2))/dot(A(:,1),A(:,1))*A(:,1);
    A(:,3)=V(:,3)-dot(A(:,1),V(:,3))/dot(A(:,1),A(:,1))*A(:,1)-...
        dot(A(:,2),V(:,3))/dot(A(:,2),A(:,2))*A(:,2); %续行
    y0=A;
    for j=1:3
        md(j) = norm(y0(:,j)); y0(:,j)=y0(:,j)/md(j);
    end
    lp=lp+log(md);
    Lyapunov1(i)=lp(1)/(tstart); %三个Lyapunov指数
    Lyapunov2(i)=lp(2)/(tstart);
    Lyapunov3(i)=lp(3)/(tstart);
    y(4:12) = y0';
end
i=[1:n]';
plot(i,Lyapunov1,i,Lyapunov2,i,Lyapunov3) %作Lyapunov指数谱图
[Lyapunov1, Lyapunov2, Lyapunov3] %显示计算结果
