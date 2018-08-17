# 设置路径
setwd("C:/Users/16053/Documents/R/18guosai/聚类分析/")
wine<-read.csv(file="wine.csv",header = FALSE);wine
# 备份类别属性，用于ggplot可视化
True_type<-factor(wine$V1)
df <- scale(wine[-1]) ;df # 对去掉类别属性的一列进行Z-score标准化

# Plot function for within groups sum of squares by number of clusters
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")}

wssplot(df)    # 看图初步判断聚类个数
library(NbClust) # 用指标说话，判断聚类个数
set.seed(1234)
nc <- NbClust(df, min.nc=2, max.nc=15, method="kmeans")
par(opar)
table(nc$Best.n[1,])
barplot(table(nc$Best.n[1,]), 
        xlab="Numer of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen by 26 Criteria") 
set.seed(1234)
fit.km <- kmeans(df, 3, nstart=25) 
kmeans_result=factor(fit.km$cluster)
fit.km$size
fit.km$centers    # 聚类中心                                       
aggregate(wine[-1], by=list(cluster=fit.km$cluster), mean)# 统计信息

# evaluate clustering
ct.km <- table(wine$V1, fit.km$cluster)
ct.km   # 统计的总体个数分错的情况，对角则完全准确
library(flexclust)
randIndex(ct.km) # 兰德指数

# ggplot
d.kmeans<- dist(df)    # 距离矩阵
mds=cmdscale(d.kmeans,k=2,eig=T) # MDS 缩放降维至2维，方便绘图
x = mds$points[,1]
y = mds$points[,2]
library(ggplot2)
p=ggplot(data.frame(x,y),aes(x,y))
p+geom_point(size=3,alpha=0.8,aes(colour=True_type,shape=kmeans_result))