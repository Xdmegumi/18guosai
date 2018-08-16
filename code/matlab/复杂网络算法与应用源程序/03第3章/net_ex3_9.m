clc, clear
p=0.6; q=0.1; r=0.3;
pf=[p,q,r]; pp=cumsum(pf);
m0=2; m=2; a=zeros(m0);
for i=1:2000
    ind=find(pp>=rand);  %产生一个随机数，找pp中大于该随机数的地址
    if ind(1)==1
        a=addedge(a,m,1);   %调用自定义函数
    elseif ind(1)==2
        a=deleteadd(a,m,1);   %调用自定义函数
    else
        a=addnode(a,m,1);   %调用自定义函数
    end
end
dp=mydegree(a);  %求度的频数分布表
subplot(1,2,1), plot(dp(1,:),dp(2,:)/length(a),'-o')
xlabel('度'),ylabel('度的频率'),title('线性坐标')
subplot(1,2,2), loglog(dp(1,:),dp(2,:)/length(a),'-*')
xlabel('度'),ylabel('度的频率'), title('对数坐标')
