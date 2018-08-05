function PenicilliumEst
clear all;
t=[0,10,30,50,70,90,110,130,150,160];
y=[0,0.23211,0.45906,0.68601,0.92328,1.21213,1.32561,1.34624,1.39782,1.398];
y0=0;

% Nonlinear least square estimate using lsqnonlin()
beta0=[0.001 0.001];
lb=[0 0];ub=[inf inf];
[beta,resnorm,residual,exitflag,output,lambda,jacobian] = ...
    lsqnonlin(@Func,beta0,lb,ub,[],t,y,y0);         
ci = nlparci(beta,residual,jacobian);
beta
% result
fprintf('\n Estimated Parameters by Lsqnonlin():\n')
fprintf('\t k1 = %.4f ¡À %.4f\n',beta(1),ci(1,2)-beta(1))
fprintf('\t k2 = %.4f ¡À %.4f\n',beta(2),ci(2,2)-beta(2))
fprintf('  The sum of the residual squares is: %.1e\n\n',sum(residual.^2))

% plot of fit results
tspan = [0  max(t)];
[tt yc] = ode45(@ModelEqs,tspan,y0,[],beta);
tc=linspace(0,max(t),200);
yca = spline(tt,yc,tc);
plot(t,y,'ro',tc,yca,'r-');
hold on
xlabel('Time');
ylabel('Concentration');
hold off 
% =======================================
function f1 = Func(beta,t,y,y0)        % Define objective function
tspan =t;
[tt yy] = ode45(@ModelEqs,tspan,y0,[],beta);
yc= spline(tt,yy,t);
f1=y-yc;
% ==================================
function dydt = ModelEqs(t,y,beta)          % Model equations
dydt = (4.41/96485-(4.41*beta(1)+beta(2)*4.41/96485)*y)/(1+4.41*beta(1)*t);