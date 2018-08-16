clear all;
clc;
num=xlsread('D:\数学建模\数模资料分享\暑期培训\2017第十届华中地区数学建模邀请赛_个人赛\data1.xlsx','Sheet1','A1:S135');
x1=num(1:42,1:18)';
y1=num(1:42,19)';
x2=num(43:84,1:18)';
y2=num(43:84,19)';
y2=y2-3;
figure;
plot(x1(1,:),x1(2,:),'bx',x2(1,:),x2(2,:),'k.');
hold on;
X1 = [x1,x2];
Y1 = [y1,y2];  
X2=num(85:110,1:18);
X=X1';
Y=Y1';
C=Inf;
ker='linear';
[nsv ,alpha,bias] = svc(X,Y,ker,C);
nsv
alpha
bias
svcplot(X,Y,ker,alpha,bias);

predictedY = svcoutput(X,Y,X2,ker,alpha,bias)   

figure(3)
svcplot(X2,predictedY,ker,alpha,bias);
err = svcerror(X,Y,X2,predictedY,ker,alpha,bias)