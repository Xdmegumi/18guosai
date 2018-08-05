clear all;
% 数据准备
load x.mat
t=linspace(0,15,77);
y=x(:,1:2);
y0=[25 2];
% Nonlinear least square estimate using lsqnonlin()
beta0=[0.2 0.2 0.01];
lb=[0 0 0 0 0 0];
ub=[inf inf inf inf inf inf];
[beta,resnorm,residual,exitflag,output,lambda,jacobian] = ...
    lsqnonlin(@Func,beta0,lb,ub,[],t,y,y0);         
ci = nlparci(beta,residual,jacobian);
beta
% result
fprintf('\n Estimated Parameters by Lsqnonlin():\n')
for i=1:length(beta)
    % 参数值与误差
    fprintf('\t beta %d = %.4f ± %.4f\n',i,beta(i),ci(i,2)-beta(i))
end
fprintf('  The sum of the residual squares is: %.1e\n\n',sum(sum(residual.^2)))
% plot of fit results
tspan = [0  2*max(t)];
[tt yc] = ode45(@ModelEqs,tspan,y0,[],beta);
tc=linspace(0,2*max(t),200);
yca2 = spline(tt',yc(:,2),tc);
yca1 = spline(tt',yc(:,1),tc);
y=y';
figure
subplot(2,1,1)
plot(t,y(1,:),'bo',tc,yca1,'r*');
hold on
xlabel('Time');
ylabel('y1 value');
hold off
subplot(2,1,2)
plot(t,y(2,:),'bo',tc,yca2,'r*');
hold on
xlabel('Time');
ylabel('y2 value');
hold off 
%fig2plotly();