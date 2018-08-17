clc, clear
alpha=0.01:0.01:4; n=400; %n为迭代次数
for i=1:length(alpha)
    x=0.5; y=0; 
    for j=1:n
       x=alpha(i)*x*(1-x); y=y+log(abs(1-2*x));
    end
    gamma(i)=log(alpha(i))+y/n; %计算Lyapunov指数
end
plot(alpha,gamma,'k'); hold on, plot([alpha(1),alpha(end)],[0,0],'k')
xlabel('\it\alpha','FontSize',14)
ylabel('\it\gamma','FontSize',14,'Rotation',0)
