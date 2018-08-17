function tongbumain
his=@(t)[zeros(150,1);-10;2;-3;zeros(50,1)];
sol=dde23(@tongbu,1,his,[0,10]);
e=sol.y(1:150,:)-repmat(sol.y(151:153,:),50,1);
subplot(3,1,1),plot(sol.x',e([1:3:150],:)'),
xlabel('\it t(s)'), ylabel('\it e_i_1(t)','rotation',0)
subplot(3,1,2), plot(sol.x',e([2:3:150],:)')
xlabel('\it t(s)'), ylabel('\it e_i_2(t)','rotation',0)
subplot(3,1,3),plot(sol.x',e([3:3:150],:)'),
xlabel('\it t(s)'), ylabel('\it e_i_3(t)','rotation',0)
%**************************
%以下函数定义时滞微分方程组
function dxsd=tongbu(t,xsd,xsdt);
x=xsd(1:150); x=reshape(x,[3,50]);
s=xsd(151:153); d=xsd(154:203);
xt=xsdt(1:150); xt=reshape(xt,[3,50]);
st=xsdt(151:153); dt=xsdt(154:203);
df=@(t,s,st)[10*s(2)-s(1)
    -28*s(1)-s(1)*st(3,1)-s(2)
    s(1)*st(2,1)-1.3*st(3,1)];
c=0.1*ones(50); c(1:51:2500)=-4.9; %定义耦合矩阵
for i=1:50
dx(:,i)=df(t,x(:,i),xt(:,i))+x*c(i,:)'-d(i)*(x(:,i)-s);
end
dxsd(1:150)=dx(:);
dxsd(151:153)=df(t,s,st);
delta=0.1*[1:50];
for i=1:50
    dxsd(153+i)=delta(i)*(norm(x(:,i)-s))^2*exp(0.2*t);
end
dxsd=dxsd';
