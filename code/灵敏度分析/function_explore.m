x=[1 1; 1 -1; -1 -1; -1 1]';
X=-2:0.01:2;  Y=X; N=length(X);  [X,Y]=meshgrid(X,Y);
Z1=0;Z2=0;Z3=0;Z4=0;
for i=1:N
    for j=1:N
        Z1(i,j)=norm([X(i,j);Y(i,j)]-x(:,1))^2;        Z2(i,j)=norm([X(i,j);Y(i,j)]-x(:,2))^2;
        Z3(i,j)=norm([X(i,j);Y(i,j)]-x(:,3))^2;        Z4(i,j)=norm([X(i,j);Y(i,j)]-x(:,4))^2;
    end
end
theta=[1 -1 1 -1]; M=[-5 -2 0 2 5]*0.1;
gamma=1/2;
Z=theta(1)*exp(-gamma*Z1)+theta(2)*exp(-gamma*Z2)+theta(3)*exp(-gamma*Z3)+theta(4)*exp(-gamma*Z4);
subplot(2,3,1); hold on;plot(x(1,:),x(2,:),'ro');contour(X,Y,Z,M);title('\gamma=0.5');
gamma=1;
Z=theta(1)*exp(-gamma*Z1)+theta(2)*exp(-gamma*Z2)+theta(3)*exp(-gamma*Z3)+theta(4)*exp(-gamma*Z4);
subplot(2,3,2);  hold on;plot(x(1,:),x(2,:),'ro');contour(X,Y,Z,M);title('\gamma=1');
gamma=10;
Z=theta(1)*exp(-gamma*Z1)+theta(2)*exp(-gamma*Z2)+theta(3)*exp(-gamma*Z3)+theta(4)*exp(-gamma*Z4);
subplot(2,3,3); hold on; plot(x(1,:),x(2,:),'ro');contour(X,Y,Z,M);title('\gamma=10');
gamma=1;
theta(1)=0.1; 
Z=theta(1)*exp(-gamma*Z1)+theta(2)*exp(-gamma*Z2)+theta(3)*exp(-gamma*Z3)+theta(4)*exp(-gamma*Z4);
subplot(2,3,4); hold on; plot(x(1,:),x(2,:),'ro');contour(X,Y,Z,M);title('\theta_1=0.1');
theta(1)=0.5; 
Z=theta(1)*exp(-gamma*Z1)+theta(2)*exp(-gamma*Z2)+theta(3)*exp(-gamma*Z3)+theta(4)*exp(-gamma*Z4);
subplot(2,3,5);  hold on;plot(x(1,:),x(2,:),'ro');contour(X,Y,Z,M);title('\theta_1=0.5');
theta(1)=5; 
Z=theta(1)*exp(-gamma*Z1)+theta(2)*exp(-gamma*Z2)+theta(3)*exp(-gamma*Z3)+theta(4)*exp(-gamma*Z4);
subplot(2,3,6);  hold on;plot(x(1,:),x(2,:),'ro');contour(X,Y,Z,M);title('\theta_1=5');

