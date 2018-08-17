clc, clear, m=3; kb=6;
rho1=@(t) 2*exp(-1./(m*t))*(m*t*(1-exp(-1./(m*t)))-...
    exp(-1./(m*t)))./(m*t*(1-exp(-1./(m*t))).^2); %Ê½£¨4.55£©
fplot(rho1,[0,1,0,1],'.'), title('')
hold on, tc=1/kb;
rho2=@(t)(t<tc)*0+(t>=tc)*(t-tc)./t; %Ê½£¨4.16£©
fplot(rho2,[0,1,0,0.9])
legend('BAÍøÂç','¾ùÔÈÍøÂç',2)
xlabel('$\lambda$','Interpreter','Latex')
ylabel('$\rho$','Interpreter','Latex')
