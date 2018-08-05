function dydt = logit(t,y,beta)          % Model equations
dydt = beta(1)*(1-y/beta(2))*y;   % r=beta(1),x_m=beta(2)
dydt=dydt';



 