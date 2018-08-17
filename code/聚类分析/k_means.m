clc
clear
%dataΪ150��8�еľ���ע�����ݵĸ�ʽΪ����Ϊ������Ϊ����
data = [randn(50,8)+ones(50,8);randn(50,8)-ones(50,8);randn(50,8)+[ones(50,4),-ones(50,4)]];
%��8ά���ݽ�Ϊ2ά���پ�Ϊ3��
dim_red_data = compute_mapping(data,'Autoencoder',2);
opts = statset('Display','final');
% [������,����,���ڵ㵽���ľ���ͣ��㵽�����ľ���] = kmeans(���ݼ�,��ĸ���,?,?)
[idx,C,sumd,D] = kmeans(dim_red_data,3,'Replicates',5,'Options',opts);
%����
plot(dim_red_data(idx == 1,1),dim_red_data(idx == 1,2),'ro','Markersize',7);
hold on;
plot(dim_red_data(idx == 2,1),dim_red_data(idx == 2,2),'bo','Markersize',7);
hold on;
plot(dim_red_data(idx == 3,1),dim_red_data(idx == 3,2),'go','Markersize',7);
%������
plot(C(:,1),C(:,2),'kx','MarkerSize',14,'LineWidth',2)
%ͼ��
legend('Cluster 1','Cluster 2','Cluster 3','Centroids');
%fig2plotly(gcf,'offline',true);