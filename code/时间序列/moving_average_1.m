clc
clear
%前11个月的数据
y = [533.8  574.6  606.9  649.8   705.1  772.0  816.4  892.7  963.9  1015.1  1102.7];
m = length(y);%历史序列长度
N = [4,5];%最近N期序列的平均值
for i = 1 : length(N)
    for j = 1 : m - N(i) + 1
        %不同的N(i)生成的结果向量维度不同，故不用矩阵而用元胞数组
        %yhat{1}返回第一个结果向量
        %在MATLAB中，求和不用for循环，而用sum函数
        yhat{i}(j) = sum(y(j : j + N(i) - 1)) / N(i);
    end
    y12(i) = yhat{i}(end);%预测结果
    s(i) = sqrt(mean((y(N(i) + 1 : end) - yhat{i}(1 : end - 1)).^2))%标准误差
end 
plot(y,'*');hold on;plot([5 : 12],yhat{1} + 175,'o');
y12
s