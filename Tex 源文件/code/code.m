%% question 1
guojia1=zeros(133,16);
zhibiao1=zeros(133,16);zhibiao2=zeros(133,16);
zhibiao3=zeros(133,16);zhibiao4=zeros(133,16);
 
    for i=1:133
        for q=1:21
            zhibiao1(i,1)=zhibiao1(i,1)+A1999(i,q)*QUAN(q,1);
            zhibiao2(i,1)=zhibiao2(i,1)+A1999(i,q)*QUAN(q,2);
            zhibiao3(i,1)=zhibiao3(i,1)+A1999(i,q)*QUAN(q,3);
            zhibiao4(i,1)=zhibiao4(i,1)+A1999(i,q)*QUAN(q,4);
        end
    end
    for q=1:133
        guojia1(q,1)=zhibiao1(q,1)*quanz(1)+zhibiao2(q,1)*quanz(2)
		+zhibiao3(q,1)*quanz(3)+zhibiao4(q,1)*quanz(4);
    end

%% Solve the optimal parameters
F=-10000;DD=-0.6581;
U1=-0.93307021;
U2=-0.4846541;
U3=0.65475121;
U4=-1.8822903;
for i=1:10000000
    A = rand(1,4);
    B1 = A/sum(A(:));
    A = rand(1,2);
    B2 = A/sum(A(:));
    A = rand(1,2);
    B3 = A/sum(A(:));
    A = rand(1,2);
    B4 = A/sum(A(:));
    A = rand(1,2);
    B5 = A/sum(A(:));
    f=B1(1)*( B2(1)*U1 + B2(2)*DD ) + B1(2)*(B3(1)*U2 + B3(2)*DD ) 
	+B1(3)*( B4(1)*U3 +B4(1)*DD) +B1(4)*( B5(1)*U4 + B5(1)*DD);
    if f>F
        F=f;
        B=[B1,B2,B3,B4,B5];
    end
End 

%% BP Network
 
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);
 
net=newff(inputn,outputn,4);
net.trainParam.epochs=100000;
net.trainParam.lr=0.1;
net.trainParam.goal=0.00000001;
net=train(net,inputn,outputn);
 
input_test=mapminmax('apply',input_test,inputps);
an=sim(net,input_test);
BPoutput=mapminmax('reverse',an,outputps);

%% forecast
guojia2=zeros(20,16);
zhibiao1=zeros(20,16);zhibiao2=zeros(20,16);
zhibiao3=zeros(20,16);zhibiao4=zeros(20,16);
 
    for i=1:20
        for q=1:21
            zhibiao1(i,1)=zhibiao1(i,1)+A1999(i,q)*QUAN(q,1);
            zhibiao2(i,1)=zhibiao2(i,1)+A1999(i,q)*QUAN(q,2);
            zhibiao3(i,1)=zhibiao3(i,1)+A1999(i,q)*QUAN(q,3);
            zhibiao4(i,1)=zhibiao4(i,1)+A1999(i,q)*QUAN(q,4);
        end
    end
 for q=1:20
        guojia2(q,1)=zhibiao1(q,1)*quanz(1)+zhibiao2(q,1)
		*quanz(2)+zhibiao3(q,1)*quanz(3)+zhibiao4(q,1)*quanz(4);
 end


%% Sensitivity analysis
X=A1999;
Y1=zeros(20,21);Y2=zeros(20,21);Y3=zeros(20,21);
    for i=1:20
        for q=1:21
            if X(i,q)>0
                Y1(i,q)=(1+Q(i)*BB(i,1))*X(i,q);
                Y2(i,q)=(1+Q(i)*BB(i,2))*X(i,q);
                Y3(i,q)=(1+Q(i)*BB(i,3))*X(i,q);
            else
                Y1(i,q)=(1-Q(i)*BB(i,1))*X(i,q);
                Y2(i,q)=(1-Q(i)*BB(i,2))*X(i,q);
                Y3(i,q)=(1-Q(i)*BB(i,3))*X(i,q);
            end
        end
    end


