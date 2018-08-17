function y=Fun4(x) 
y0=x(1)*sin(sqrt(abs(x(1))));
for i=2:1:30
   y0=y0+(x(i)*sin(sqrt(abs(x(i)))));
end

y=-y0;