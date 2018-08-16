clc, clear,  
hold on
for a=0:0.001:4
    x1=0.2;
    for i=1:100
        x2=a*x1*(1-x1);
        x1=x2;
        if i>70, plot(a,x1), end
    end
end
xlabel('\alpha'), ylabel('\it x','rotation',0)
