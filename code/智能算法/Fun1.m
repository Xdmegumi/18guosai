function y=Fun1(x) 
y0=x(1)^4;
for i=2:1:29
   y0=y0+i*x(i)^4;
end

y=y0+rand(1,1,'double');