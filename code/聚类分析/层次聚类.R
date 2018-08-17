# 设置路径
setwd("C:/Users/16053/Documents/R/18guosai/聚类分析/")
# 读取数据
nutrient<-read.csv(file="nutrient.csv",header = TRUE)
row.names(nutrient) <- nutrient$X # 第一列改为行名
nutrient<-nutrient[,-1] # 删除第一列
# 标准差法（z-score）进行标准化处理 （无量纲化的一种，均值为0，标准差为1。还有极值差法，【0,1】区间，但要知道最大最小值）
nutrient.scaled <- scale(nutrient) 
# 计算距离矩阵
d <- dist(nutrient.scaled,method = "euclidean")
## method 可选：manhattan——曼哈顿距离、maximum——切比雪夫距离、minkowski——闵式距离
as.matrix(d)[1:4,1:4] #  展现前几个变量的距离
# 绘制距离热力图
heatmap(as.matrix(d),labRow = F, labCol = F)
# 选取聚类方法
fit.average <- hclust(d, method="average") 
## method 可选：ward.D、ward.D2、single、complete、average、mcquitty（质心）
plot(fit.average, hang=-1, cex=.8, main="Average Linkage Clustering",xlab="聚类指标")

# 选取聚类个数——依赖包中的评价标准
library(NbClust)
nc <- NbClust(nutrient.scaled, distance="euclidean", 
              min.nc=2, max.nc=15, method="average")
par(opar)
table(nc$Best.n[1,])
barplot(table(nc$Best.n[1,]), 
        xlab="Numer of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen by 26 Criteria") 

# 确定最终模型
clusters <- cutree(fit.average, k=5) # 3 参考之前评价标准给出
table(clusters)
aggregate(nutrient, by=list(cluster=clusters), median) 
aggregate(as.data.frame(nutrient.scaled), by=list(cluster=clusters),
          median)
plot(fit.average, hang=-1, cex=.8,  
     main="Average Linkage Clustering\n5 Cluster Solution")
rect.hclust(fit.average, k=5)


# MDS 可视化
mds=cmdscale(d,k=2,eig=T)
x = mds$points[,1]
y = mds$points[,2]
class=factor(clusters)
library(ggplot2)
p=ggplot(data.frame(x,y),aes(x,y))
p+geom_point(size=3, alpha=0.8, aes(colour=class))