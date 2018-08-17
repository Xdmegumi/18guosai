function y=Fun2(x) 
y(1)=x(1); 
g0=x(2);
for i=3:30
    g0=g0+x(i);
end
g=1+9*(g0/29);
y(2)=g*(1-(x(1)/g)^2);
