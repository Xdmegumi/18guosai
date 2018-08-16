bt=zeros(1000,2);
bfd=zeros(400,1);
bpd=zeros(600,1);
bd=zeros(1000,1);
fuwu1=zeros(1000,1);
weixian=zeros(1000,1);
a4=10.64*4/7;a3=10.64*3/5;
a2=10.64*2/3;a1=10.64;
moceng=zeros(1000,1);
jianju=zeros(1000,1);
kexindu=zeros(1000,1);
i=1;j=1;bbb=[];
    h=0.22;
    mr=0.13;
    jr=0.04;
    for q=1:4
        ma=rand(1);
        moceng(q)=1-(1-exp(-ma/mr))/(1-exp(-1/mr));
        moceng(q)=(moceng(q)+1)*exprnd(a1);
        jianju(q)=0;
        bt(q)=paixu(q)+exprnd(a1)+moceng(q);
        a=rand*0.1+0.9;
        kexindu(q)=(1-exp(-a/0.13))/(1-exp(-1/0.13));
        weixian(q)=(1-exp(-a/0.13))/(1-exp(-1/0.13));
    end
    for q=5:1000
        ma=rand(1);
        ja=rand(1);
        moceng(q)=1-(1-exp(-ma/mr))/(1-exp(-1/mr));
        jianju(q)=1-(1-exp(-ja/jr))/(1-exp(-1/jr));
        
        a=rand(1);
        a=(1-exp(-a/0.13))/(1-exp(-1/0.13));
        kexindu(q)=a;
        if a>0.9||(paixu(q,2)==1)
            fuwu=exprnd(a1);
            weixian(q)=a;
        elseif a>0.7
            fuwu=exprnd(a2);
            weixian(q)=a*2;
        elseif a>0.4
            fuwu=exprnd(a3);
            weixian(q)=a*3;
        else
            fuwu=exprnd(a4);
            weixian(q)=a*4;
        end
        moceng(q)=(moceng(q)+1)*fuwu;
        if paixu(q,1)<bt(q-1)&&paixu(q,1)<bt(q-2)&&paixu(q,1)<bt(q-3)&&paixu(q,1)<bt(q-4)
            bt(q)= bt(q-4)+fuwu+moceng(q);
        else
            bt(q)=paixu(q,1)+fuwu+moceng(q);
        end    
        bd(q)=-paixu(q,1)+bt(q)-fuwu-moceng(q);
        jianju(q)=0.1*jianju(q)*bd(q);
        if(jianju(q)<0.001)
            jianju(q)=0;
        end
        bd(q)=bd(q)+jianju(q);
        bt(q)=bt(q)+jianju(q);
        if paixu(q,2)==0
            bpd(i)=-paixu(q,1)+bt(q)-fuwu-moceng(q)-jianju(q);
             if bpd(i)<1
                bpd(i)=0;
             end
            i=i+1;
        else
            bfd(j)=-paixu(q,1)+bt(q)-fuwu-moceng(q)-jianju(q);
 
              if bfd(j)<1
                  bfd(j)=0;
              end
              j=j+1;
        end
        fuwu1(q)=fuwu;
        if q>10
            for g=10:1
                if at(q)<at(q-g)
                    break;
                end
            end
            aaa=rand(1);
            aaa=(1-exp(-aaa/h))/(1-exp(-1/h));
            if aaa<0.5
                bt(q)=paixu(q,1)+fuwu+moceng(q)+jianju(q);
                bd(q)=0;
                for gg=g:1
                    bd(q-gg)=bd(q-gg)+fuwu+moceng(q)+jianju(q);
                    bt(q-gg)=bt(q-gg)+fuwu+moceng(q)+jianju(q);
                end
            end
        end
    end
    for q=2:1000
        weixian(q)=weixian(q-1)+weixian(q);
         if bd(q)<1
            bd(q)=0;
         end
    end
    for q=1:400
        if bfd(q)<1
            bfd(q)=0;
        end
    end
    for q=1:400
        if bpd(q)<1
            bpd(q)=0;
        end
    end
 
    pudengjun=mean(bpd);
    huidengjun=mean(bfd);
    quandengjun=mean(bd);
    pudengfang=std(bpd,0,1)*std(bpd,0,1);
    huidengfang=std(bfd,0,1)*std(bfd,0,1);
    quandengfang=std(bd,0,1)*std(bd,0,1);
bbb=[bbb;pudengjun,pudengfang,huidengjun,huidengfang,quandengjun,quandengfang];


zuiyouP=ones(10,10);
zuiyoujie=[10000,10000,10000,10000,10000,10000,10000,10000,10000,10000];
for M=2:1:10
    a=0.094;
    for q=1:10000
        p0=rand(1,M);
        y=sum(p0);p=p0/y;
        b=0;
        for m =1:M
            b=b+p(m)/(m*a-0.75*a*p(m))+0.5/(M-m+1)/p(m);
        end
        b=b+1/(M*a-0.25*a);
        if b <zuiyoujie(M)
            zuiyoujie(M)=b;
            zuiyouP(M,1:M)=p;
        end
    end
End



clc
s=1:1:10;k=1:1:10;
w2=zeros(10,10);
p = 0.084/0.034;
a=0;
for i = 1:10 
    for j = 1:10
        for q=1:i-1
            a=fact(i-1)*(i-p)/(fact(q)*p^(i-q));
        end
        w2(i,j)=(j+1)/(2*j*0.034*(i-p)*(a+1));
    end
end
mesh(s,k,w2)
hold on
scatter3(4,3,7.91855203619910,'.')
ylabel('The number of sevices')%3
xlabel('Erlang distribution order')%4
zlabel('Average waiting time')



