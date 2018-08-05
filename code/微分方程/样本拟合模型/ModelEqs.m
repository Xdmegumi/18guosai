function dydt = ModelEqs(t,y,beta)          % Model equations
dydt(1) = y(1)*(1-beta(1)*y(2));
dydt(2) = y(2)*(-beta(2)+beta(3)*y(1));
dydt=dydt';



 