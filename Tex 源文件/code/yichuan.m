
function y=min_dis(x)
     A=[1,2];
    %direction=[-2,-2,-1,-1,1,1,2,2;1,-1,-2,2,2,-2,1,-1];
    qipan=zeros(8);
    qipan(A(1),A(2))=1;
    for i=1:63
        stepnow=dire(x(i));
        x_new=A(1)+stepnow(1);
        y_new=A(2)+stepnow(2);
        if (1<=x_new&&x_new<=8&&1<=y_new&&y_new<=8)
            if (qipan(x_new,y_new)==0)
                qipan(x_new,y_new)=1;
            end
            if (qipan(x_new,y_new)==1)
                y=i+64;
            end    
        else y=200;
        end
    end 
    if (qipan==ones(8))
        disance=(A(1)-x_new)^2+(A(2)-y_new)^2;
        y=abs(distance-5);
    end
