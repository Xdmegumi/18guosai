function y=Fun5(x) 
y(1)=1-exp(-4*x(1))*sin(6*pi*x(1)^6);
g0=x(2);
for i=3:10
    g0=g0+x(i);
end
g=1+9*(g0/9)^0.25;
y(2)=g*(1-(x(1)/g)^2);
