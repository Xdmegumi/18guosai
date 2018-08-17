clc, clear, format rat
a=[1 6 4 6]; b=[1 2 2 3]; n=3;
w=factorial(n-b).*factorial(b-1)/factorial(3) %计算权重
c=w.*a, fai1=sum(c) %计算甲的Shapley值
