clc, clear
t0=pi/2:2*pi/3:2*pi+pi/2;
x0=1+cos(t0); y0=1+sin(t0);
subplot(1,3,1)
plot(x0,y0,'ko-','MarkerEdgeColor','k','LineWidth',2,'MarkerFaceColor','r','markersize',6);
t1=pi/2:pi/3:2*pi+pi/2;
x1=1+cos(t1); y1=1+sin(t1);
subplot(1,3,2), hold on
plot(x0,y0,'ko-','MarkerEdgeColor','k','LineWidth',2,'MarkerFaceColor','r','markersize',6);
plot(x1,y1,'ko-','MarkerEdgeColor','k','LineWidth',2,'MarkerFaceColor','r','markersize',6);
t2=0:pi/3:2*pi;
x2=1+1.15*cos(t2); y2=1+1.15*sin(t2);
subplot(1,3,3), hold on
plot(x0,y0,'ko-','MarkerEdgeColor','k','LineWidth',2,'MarkerFaceColor','r','markersize',6);
plot(x1,y1,'ko-','MarkerEdgeColor','k','LineWidth',2,'MarkerFaceColor','r','markersize',6);
plot(x2,y2,'ko-','MarkerEdgeColor','k','LineWidth',2,'MarkerFaceColor','r','markersize',6);
