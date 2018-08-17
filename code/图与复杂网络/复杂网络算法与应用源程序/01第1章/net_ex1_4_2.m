clc, clear
a=[1.48  2.85  3.02  0.90  2.14  2.93  3.98  0.95  2.26  0.96  0.61  0.70  3.43  2.42  1.49  1.66  4.54  2.41  1.52  4.01  1.94  1.74  1.95  2.47  1.33  2.08  1.40  0.41  1.50  1.16  3.96  1.50  2.47  3.07  1.28  2.63  0.71  2.14  3.82  1.83];
mu=mean(a), sigma2=var(a,1)
beta=sigma2/mu, alpha=mu/beta
pd=makedist('gamma','a',alpha,'b',beta) %定义gamma分布
qqplot(a,pd)  %Matlab画Q-Q图
