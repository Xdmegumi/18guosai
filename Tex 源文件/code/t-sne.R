## 设置路径
setwd("C:/Users/16053/Documents/R/18guosai/降维/")
shouxin<-read.csv(file="tsne_train.csv",header = TRUE);shouxin

## Not run:
library(tsne)


vec=550:670
# 定义绘图函数
ecb = function(x,y){ plot(x,type ='p',lable='',pch=17,col=colors[shouxin$result[vec]]) }
# tsne 降维
tsne_iris = tsne(shouxin[vec,3:30], epoch_callback = ecb, perplexity=50)
# compare to PCA

dev.new()
pca_iris = princomp(shouxin[vec,3:30])$scores[,1:2]
plot(pca_iris, type ='p',lable='',pch=17,col=colors[shouxin$result[vec]])
## End(Not run)


## MDS 降维
## ggplot_mds
df <- scale(shouxin[,3:30]) ;df
d.mds<- dist(df)    
mds=cmdscale(d.mds,k=2,eig=T)
mds_1 = mds$points[,1]
mds_2 = mds$points[,2]
library(ggplot2)
library('grid') 

p=ggplot(data.frame(mds_1,mds_2),aes(mds_1,mds_2))
Default<-factor(shouxin$Class)
main_ploy<-p+geom_point(size=3,alpha=0.8,aes(colour=Default))+
  theme(legend.title = element_text (size=12,face ="bold"))+
  annotate("segment", x = -1.7, xend = -0.8, y = 2.8, yend = 6.8, size = 1.2,colour = "blue",
           arrow = arrow(ends = "both", angle = 30, length = unit(0.2,"cm")))

subplot<-p+geom_point(size=3,alpha=0.8,aes(colour=Default))+coord_cartesian(xlim=c(-2.8,-1),ylim = c(-2,2))+  
  theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
        legend.position = "none",panel.grid =element_blank(),panel.border = element_blank(),
        axis.text = element_blank(),axis.ticks = element_blank(),axis.title = element_blank())
main_ploy
subvp_1 <- viewport(width=0.5,height=0.4,x=0.35,y=0.75)
print(subplot,vp=subvp_1)


