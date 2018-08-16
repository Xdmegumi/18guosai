clc, clear
ni=[112 20 11 7]; n=sum(ni);
fi=[0:3];
phat=dot(ni,fi)/n/3  %计算p的极大似然估计值
ph=binopdf([0:3],3,phat)  %计算理论概率
ei=n*ph  %计算理论频数
eih=[ei(1:end-2),sum(ei(end-1:end))]  %计算合并区间后的频数值
nih=[ni(1:2), sum(ni(3:4))];
chistat=sum((eih-nih).^2./eih)
bd=chi2inv(0.95,1)  %给出chi2检验的临界值
