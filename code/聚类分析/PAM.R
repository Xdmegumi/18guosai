# 设置路径
setwd("C:/Users/16053/Documents/R/18guosai/聚类分析/")
#基于中心点的划分 PAM
wine<-read.csv(file="wine.csv",header = FALSE);wine
True_type<-factor(wine$V1)
df <- scale(wine[-1]) ;df 

library(cluster)
set.seed(1234)
fit.pam <- pam(wine[-1], k=3, stand=TRUE)  
PAM_result<-factor(fit.pam$clustering)
fit.pam$medoids                                 
clusplot(fit.pam, main="Bivariate Cluster Plot")

# evaluate clustering
ct.pam <- table(wine$V1, fit.pam$clustering)
ct.pam
randIndex(ct.pam)

# ggplot
d.center<- dist(df)    
mds=cmdscale(d.center,k=2,eig=T)
x = mds$points[,1]
y = mds$points[,2]
library(ggplot2)
p=ggplot(data.frame(x,y),aes(x,y))
p+geom_point(size=3,alpha=0.8,aes(colour=True_type,shape=PAM_result))