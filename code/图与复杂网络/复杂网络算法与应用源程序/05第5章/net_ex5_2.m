clc, clear
a=0:0.01:1.6; n=500; S=[];
for j=1:length(a)
    x=0.2; y=0.3; %x,y的初值
    for i=1:n
        x2=1-a(j)*x^2+y; y=0.3*x; x=x2; %首先进行序列迭代
    end
    if x(end)>-100 & x(end)<100 %若不发散，再计算指数
        x=0.2; y=0.3;
        JJ=eye(2);
        for i=1:n
            x2=1-a(j)*x^2+y; y=0.3*x; x=x2;
            J=[-2*a(j)*x, 1; 0.3, 0];
            JJ=JJ*J;
        end
        L=eigs(JJ,1); %求模最大的特征值
        S=[S,[a(j);log(abs(L))/n]]; %把a值及指数值保存
    end
end
plot(S(1,:),S(2,:),'.-') %画出a对应的最大Lyapunov指数
hold on, plot([a(1),a(end)],[0,0],'k')
xlabel('\it a'), ylabel('最大Lyapunov指数')
