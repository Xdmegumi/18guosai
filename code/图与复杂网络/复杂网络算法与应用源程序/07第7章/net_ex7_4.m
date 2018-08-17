clc, clear, n=13;
a=zeros(n); a(1,[2 3])=1; a(2,[3 4])=1;
a(3,4)=1; a(4,5)=1; a(5,[6 10])=1;
a(6,[7 8])=1; a(7,[8 9])=1; a(8,9)=1;
a(10,[11 12])=1; a(11,[12 13])=1; a(12,13)=1;
a=a+a'; %构造完整的邻接矩阵
s=zeros(n,1); %迭代上一步的初始值
q=ones(n,1)/n; %迭代的初值 
while sum(abs(s-q))>0.0001
    s=q; %把当前值保存
    q=q+a*q; q=q/sum(q); %继续迭代一步
end
q %显示最终的迭代值
B=diag(sum(a))-a-ones(n); %构造B矩阵
C=inv(B); %计算C矩阵
for i=1:n
    for j=1:n
        Q(i,j)=1/(C(i,i)+C(j,j)-2*C(i,j)); %计算信息量
    end
end
Cv=1./mean(1./Q,2) %计算信息指标
xlswrite('biao7.xls',[q Cv])
[sq,ind1]=sort(q,'descend'); %把指标值从大到小排列
[sCv,ind2]=sort(Cv,'descend');
[ind1 ind2] %比较两种指标值的计算结果
subplot(121), bar(q), subplot(122), bar(Cv)
