function f1 = Func(beta,t,y,y0)        % Define objective function
tspan =t;
[tt yy] = ode45(@logit,tspan,y0,[],beta);
%yc= spline(tt,yy,t);
f1=y-yy;