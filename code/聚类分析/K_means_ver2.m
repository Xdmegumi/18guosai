clc
clear
%data为150行8列的矩阵。注意数据的格式为：行为样本列为特征
data = [randn(50,8)+ones(50,8);randn(50,8)-ones(50,8);randn(50,8)+[ones(50,4),-ones(50,4)]];
%聚为3类
opts = statset('Display','final');
% [聚类标号,质心,类内点到质心距离和，点到各质心距离] = kmeans(数据集,类的个数,?,?)
[idx,C,sumd,D] = kmeans(data,3,'Replicates',5,'Options',opts);
dim_red_data = compute_mapping(data,'tSNE',2);
% dim_red_C = compute_mapping(C,'PCA',2);
% 画点
plot(dim_red_data(idx == 1,1),dim_red_data(idx == 1,2),'o','color',[0.96,0.55,0.53],'Markersize',7,'LineWidth',1.2);
hold on;
plot(dim_red_data(idx == 2,1),dim_red_data(idx == 2,2),'s','color',[0.18,0.77,0.36],'Markersize',7,'LineWidth',1.2);
hold on;
plot(dim_red_data(idx == 3,1),dim_red_data(idx == 3,2),'^','color',[0.49,0.67,0.98],'Markersize',7,'LineWidth',1.2);
%画质心
% plot(dim_red_C(:,1),dim_red_C(:,2),'kx','MarkerSize',14,'LineWidth',2)
%图例
legend('Cluster 1','Cluster 2','Cluster 3');%,'Centroids');
%fig2plotly(gcf,'offline',true);
%配色方案_1[0.96,0.55,0.53]-[0.18,0.77,0.36]-[0.49,0.67,0.98]
%配色方案_2[0,0.49,0.72][0.90,0.93,0.38][0,0.67,0.74]
