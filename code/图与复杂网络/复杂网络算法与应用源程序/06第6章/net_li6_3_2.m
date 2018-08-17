clc;clear; N=1000; m=4;
for t=1:10
    gamma=[2.01,2.05,2.1,2.2,2.5,3,4,6,8,10];  
    A=scale_free_net(N,gamma(t),m);
    Kmax(t)=max(sum(A));
end
plot(gamma,Kmax,'ks-');
xlabel('\gamma'), ylabel('×î´ó¶ÈK_{max}')
