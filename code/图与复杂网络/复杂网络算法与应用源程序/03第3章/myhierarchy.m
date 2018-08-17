function myhierarchy(a,b,x,y,L,d,n)
%（a,b）为图形的中心,（x,y）为每一层的中心,调用时要求a=x,b=y
%L为三角形边长，d为模体之间的距离，d>L，n为递归深度
hold on
mc=a+b*i; %整个图形的中心
if n==1
    A=(x-L/2)+(y-L*tan(pi/6)/2)*i;  %计算三角形顶点的坐标
    B=(x+L/2)+(y-L*tan(pi/6)/2)*i;
    C=x+(y+L*tan(pi/6))*i;
    ZX=(A+B+C)/3; %计算等边三角形自身的中心
    plot([ZX,C,B,A,mc],'.')
    plot([C,B,A,C])  %画三角形的三条边
    plot([ZX,A,mc]), plot([ZX,B,mc]), plot([ZX,C,mc]) %画中心到各点的边
else
    xy=x+y*i;
    x01=x-d/2; y01=y-d*tan(pi/6)/2;  %计算三角形中心的坐标
    x02=x+d/2; y02=y-d*tan(pi/6)/2;
    x03=x;  y03=y+d*tan(pi/6);
    A0=x01+y01*i; B0=x02+y02*i; C0=x03+y03*i;
    plot([A0,B0,C0,A0])
    A1=(x01-L/2)+(y01-L*tan(pi/6)/2)*i;  %计算三角形顶点的坐标
    B1=(x01+L/2)+(y01-L*tan(pi/6)/2)*i;
    C1=x01+(y01+L*tan(pi/6))*i;
    plot([xy,A1]), plot([xy,B1]), plot([xy,C1])
    A2=(x02-L/2)+(y02-L*tan(pi/6)/2)*i;  %计算三角形顶点的坐标
    B2=(x02+L/2)+(y02-L*tan(pi/6)/2)*i;
    C2=x02+(y02+L*tan(pi/6))*i;
    plot([xy,A2]), plot([xy,B2]), plot([xy,C2])
    A3=(x03-L/2)+(y03-L*tan(pi/6)/2)*i;  %计算三角形顶点的坐标
    B3=(x03+L/2)+(y03-L*tan(pi/6)/2)*i;
    C3=x03+(y03+L*tan(pi/6))*i;
    plot([xy,A3]), plot([xy,B3]), plot([xy,C3])
    myhierarchy(a,b,x,y,L,d/n,n-1)  %递归调用
    myhierarchy(a,b,x01,y01,L,d/n,n-1)  
    myhierarchy(a,b,x02,y02,L,d/n,n-1)
    myhierarchy(a,b,x03,y03,L,d/n,n-1)
end
