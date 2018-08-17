function y=Fun2(x) 
y1=abs(x(1));
y2=abs(x(1));
for i=2:1:29
   y1=y1+abs(x(i));
   y2=y2*abs(x(i)); 
end

y=y1+y2;