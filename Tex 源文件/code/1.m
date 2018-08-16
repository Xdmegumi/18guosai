i=100;
stf=exprnd(10.64,[i 1]);
tf=[];
tf(1)= stf(1);
for k=2:i
    tf(k)=tf(k-1)+stf(k);
end
tf=tf'; 
f=1; 
af = 2;  atf=[]; 
atf(1)=tf(1)+1/0.088;  
atf(2)=tf(2)+1/0.088;  

for q=3:i
    if tf(q)<atf(q-1)&&tf(q)<atf(q-2)
        atf(q)= atf(q-2)+1/0.088;
    else
        atf(q)=tf(q)+1/0.088;
    end
end
atf=atf';

afd=zeros(i,1);
for q=3:i
    afd(q)=atf(q)-tf(q)-1/0.088;
    if afd(q)<1
        afd(q)=0;
    end
end
