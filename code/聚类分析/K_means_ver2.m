clc
clear
%dataΪ150��8�еľ���ע�����ݵĸ�ʽΪ����Ϊ������Ϊ����
data = [randn(50,8)+ones(50,8);randn(50,8)-ones(50,8);randn(50,8)+[ones(50,4),-ones(50,4)]];
%��Ϊ3��
opts = statset('Display','final');
% [������,����,���ڵ㵽���ľ���ͣ��㵽�����ľ���] = kmeans(���ݼ�,��ĸ���,?,?)
[idx,C,sumd,D] = kmeans(data,3,'Replicates',5,'Options',opts);
dim_red_data = compute_mapping(data,'tSNE',2);
% dim_red_C = compute_mapping(C,'PCA',2);
% ����
plot(dim_red_data(idx == 1,1),dim_red_data(idx == 1,2),'o','color',[0.96,0.55,0.53],'Markersize',7,'LineWidth',1.2);
hold on;
plot(dim_red_data(idx == 2,1),dim_red_data(idx == 2,2),'s','color',[0.18,0.77,0.36],'Markersize',7,'LineWidth',1.2);
hold on;
plot(dim_red_data(idx == 3,1),dim_red_data(idx == 3,2),'^','color',[0.49,0.67,0.98],'Markersize',7,'LineWidth',1.2);
%������
% plot(dim_red_C(:,1),dim_red_C(:,2),'kx','MarkerSize',14,'LineWidth',2)
%ͼ��
legend('Cluster 1','Cluster 2','Cluster 3');%,'Centroids');
%fig2plotly(gcf,'offline',true);
%��ɫ����_1[0.96,0.55,0.53]-[0.18,0.77,0.36]-[0.49,0.67,0.98]
%��ɫ����_2[0,0.49,0.72][0.90,0.93,0.38][0,0.67,0.74]
