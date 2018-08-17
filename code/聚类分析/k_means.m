clc
clear
%data为150行8列的矩阵。注意数据的格式为：行为样本列为特征
data = [randn(50,8)+ones(50,8);randn(50,8)-ones(50,8);randn(50,8)+[ones(50,4),-ones(50,4)]];
%将8维数据降为2维后再聚为3类
dim_red_data = compute_mapping(data,'Autoencoder',2);
opts = statset('Display','final');
% [聚类标号,质心,类内点到质心距离和，点到各质心距离] = kmeans(数据集,类的个数,?,?)
[idx,C,sumd,D] = kmeans(dim_red_data,3,'Replicates',5,'Options',opts);
%画点
plot(dim_red_data(idx == 1,1),dim_red_data(idx == 1,2),'ro','Markersize',7);
hold on;
plot(dim_red_data(idx == 2,1),dim_red_data(idx == 2,2),'bo','Markersize',7);
hold on;
plot(dim_red_data(idx == 3,1),dim_red_data(idx == 3,2),'go','Markersize',7);
%画质心
plot(C(:,1),C(:,2),'kx','MarkerSize',14,'LineWidth',2)
%图例
legend('Cluster 1','Cluster 2','Cluster 3','Centroids');
%fig2plotly(gcf,'offline',true);