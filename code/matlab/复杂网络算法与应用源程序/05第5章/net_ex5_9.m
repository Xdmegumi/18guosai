clc, clear
dx=@(t,x,y)[10*x(2)-x(1)
    -28*x(1)-x(1)*y(3,1)-x(2)
    x(1)*y(2,1)-1.3*y(3,1)];
his=@(t)[-10;2;-3];
sol=dde23(dx,1,his,[0,10])
plot(sol.x,sol.y(1,:),'-*',sol.x,sol.y(2,:),'.-',sol.x,sol.y(3,:),'-o')
legend('\it s_1','\it s_2','\it s_3')
xlabel('\it t(s)'), ylabel('\it S(t)','rotation',0)
