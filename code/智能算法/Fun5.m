function y=Fun5(x) 
y1=x(1)^2;
y2=cos(x(1)/(sqrt(1)));
for i=2:1:30
   y1=y1+x(i)^2;
   y2=y2*cos(x(1)/(sqrt(1)));
end

y=y1/4000-y2+1;