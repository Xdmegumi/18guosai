clc, clear
tao=0.1;N=5;
for p=1:N
dx=@(t,x,y)[-1*x(1)-y(1,1)
    -2*x(2)-5*y(2,1)
    -3*x(3)-y(3,1)];
    chuzhi=(0.5-rand(3,1))*10;
his=@(t)chuzhi;
sol=dde23(dx,0.1,his,[0,10])
tt{p}=sol.x;
X1{p}=sol.y(1,:);
X2{p}=sol.y(2,:);
X3{p}=sol.y(3,:);
end
t1=tt{1};t2=tt{2};t3=tt{3};t4=tt{4};t5=tt{5};
x11=X1{1};x21=X1{2};x31=X1{3};x41=X1{4};x51=X1{5};
x12=X2{1};x22=X2{2};x32=X2{3};x42=X2{4};x52=X2{5};
x13=X3{1};x23=X3{2};x33=X3{3};x43=X3{4};x53=X3{5};
figure
hold on
plot(t1,x11,'*',t2,x21,'.',t3,x31,'o',t4,x41,'^',t5,x51,'p')
legend('\it x_{11}','\it x_{21}','\it x_{31}','\it x_{41}','\it x_{51}')
xlabel('\it t(s)'),ylabel('\it x_1(t)','rotation',0)
figure
hold on
plot(t1,x12,'*',t2,x22,'.',t3,x32,'o',t4,x42,'^',t5,x52,'p')
legend('\it x_{12}','\it x_{22}','\it x_{32}','\it x_{42}','\it x_{52}')
xlabel('\it t(s)'),ylabel('\it x_2(t)','rotation',0)
figure
hold on
plot(t1,x13,'*',t2,x23,'.',t3,x33,'o',t4,x43,'^',t5,x53,'p')
legend('\it x_{13}','\it x_{23}','\it x_{33}','\it x_{43}','\it x_{53}')
xlabel('\it t(s)'),ylabel('\it x_3(t)','rotation',0)
