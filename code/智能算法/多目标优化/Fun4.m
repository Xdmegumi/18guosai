function y=Fun4(x) 
y(1)=x(1); 
g0=x(2)^2-10*cos(4*pi*x(2));
for i=3:10
    g0=g0+x(i)^2-10*cos(4*pi*x(i));
end
g=1+9*10+g0;
y(2)=g*(1-sqrt(x(1)/g));
