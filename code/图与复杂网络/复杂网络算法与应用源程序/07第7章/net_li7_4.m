a=zeros(19); %连接关系矩阵的初始化
w=randi([1,10],19); %生成随机矩阵
a(1,[2 3])=1; a(2,[3:5])=1; a(3,[4 7])=1;
a(4,[5 7])=1; a(5,[6 7])=1; a(6,7)=1;
a(7,8)=1; a(8,[9 10 13])=1; a(9,[10 11 13])=1;
a(10,[11 13])=1; a(11,[12 14])=1; a(12,13)=1;
a(14,[15 17 19])=1; a(15,[16:18])=1; A(16,[17 19])=1;
a(17,[18 19])=1; a(18,19)=1; 
w=a.*w; W=w+w'; %构造权重矩阵
D=diag(sum(W,2)); N=D^(-1)*W; %构造标准矩阵
[vec,val]=eigs(N,2) %求前2个最大特征值对应的特征向量
plot([1:length(vec(:,2))]', vec(:,2),'.k','MarkerSize',15) %画出第2大特征值对应的特征向量
