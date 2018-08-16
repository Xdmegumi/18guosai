clc, clear, a=zeros(34); %Zachary网络邻接矩阵初始化
a(1,[2:9,11:14,18,20,22,32])=1; %输入邻接矩阵上三角元素
a(2,[3,4,8,14,18,20,22,31])=1; a(3,[4,8:10,14,28,29,33])=1;
a(4,[8,13,14])=1; a(5,[7,11])=1; a(6,[7,11,17])=1; a(7,17)=1;
a(9,[31,33,34])=1; a(10,34)=1; a(14,34)=1; a(15,[33,34])=1;
a(16,[33,34])=1; a(19,[33,34])=1; a(20,34)=1; a(21,[33,34])=1;
a(23,[33,34])=1; a(24,[26,28,30,33,34])=1; a(25,[26,28,32])=1; a(26,32)=1;
a(27,[30,34])=1; a(28,34)=1; a(29,[32,34])=1; a(30,[33,34])=1;
a(31,[33,34])=1; a(32,[33,34])=1; a(33,34)=1; 
a=a+a'; %写出完整的邻接矩阵
r=randperm(34); %取1,2,...,34的一个随机全排列
b1=r(1:16); b2=r(17:34); %社团初始化
flag=0; %计数交换次数的初始值
for k=1:length(b2) %最大的交换次数
  for i=1:length(b1)
    for j=1:length(b2)
        c(i,j)=sum(sum(a(b1,b1)))/2+sum(sum(a(b2,b2)))/2-...
            sum(sum(a(b1,b2)));
        d1=b1; d2=b2; t=d1(i); d1(i)=d2(j); d2(j)=t; %交换位置
        e(i,j)=sum(sum(a(d1,d1)))/2+sum(sum(a(d2,d2)))/2-...
        sum(sum(a(d1,d2)));
        f(i,j)=e(i,j)-c(i,j); %计算增量
    end
  end
  if max(max(f))>0 %如果Q值变大，就交换
    [id,jd]=find(f==max(max(f)),1); %求其中最大的一个Q值位置
    tt=b1(id); b1(id)=b2(jd); b2(jd)=tt; %交换位置
    flag=flag+1
  end
end
b1=sort(b1), b2=sort(b2), flag %显示最后计算结果及有效交换次数
