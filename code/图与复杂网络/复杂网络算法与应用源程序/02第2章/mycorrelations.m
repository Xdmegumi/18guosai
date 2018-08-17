function r=mycorrelations(a);
%输出参数r为度相关系数，输入参数a为邻接矩阵
d=sum(a); %计算每个节点的度
M=sum(d)/2;  %计算总边数，边的总数等于所有点度的和的一半
[i,j]=find(triu(a)); %找a矩阵上三角元素中的非零元素所在的行标和列标，即每条边的两个端点
ki=d(i); kj=d(j); %提取所有边的起点度和终点度
r=(ki*kj'/M-(sum(ki+kj)/2/M)^2)/(sum(ki.^2+kj.^2)/2/M-(sum(ki+kj)/2/M)^2);
