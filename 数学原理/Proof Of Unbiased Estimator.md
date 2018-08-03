#Proof Of Unbiased Estimator 

##Distribution

Random varaiables $X,Y$ obey their distribution

Their distribution's mean	
$$
E(X)=\mu_X,E(Y)=\mu_Y
$$
Variance		
$$
\sigma_X^2,\sigma_Y^2
$$
Covariance 	
$$
Cov(X,Y)=\sigma_{XY}
$$

##Sample

**Independent and identical distribution (I.I.D)** random variables
$$
X_i,Y_i	\quad i=1,2,\dots,n
$$
> which means $E(X_i)=\mu_X,D(X_i)=\sigma_X^2,i=1,2,\cdots,n$ 


Sample mean
$$
\overline X=\frac{1}{n}\sum_{i=1}^nX_i,\overline Y=\frac{1}{n}\sum_{i=1}^nY_i
$$
**For** biased estimator is

Variance
$$
S_{X}^2=\frac{1}{n}\sum_{i=1}^n(X_i-\overline X)^2,S_{Y}^2=\frac{1}{n}\sum_{i=1}^n(Y_i-\overline Y)^2
$$
Covariance
$$
S_{XY}=\frac{1}{n}\sum_{i=1}^n(X_i-\overline X)(Y_i-\overline Y)
$$
**For** unbiased estimator is

Sample variance
$$
\sigma_{estimate}^2=\frac{1}{n-1}\sum_{i=1}^n(X_i-\overline X)^2
$$
Sample covariance
$$
\sigma_{estimate}=\frac{1}{n-1}\sum_{i=1}^n(X_i-\overline X)(Y_i-\overline Y)
$$



## definition of  unbiased estimator 

设样本 $X$ 的总体分布依赖于参数 $\theta$ ，$g(\theta)$ 是已知函数（但是不能直接求出来），$\widehat{g}(X)$ 是 $g(\theta)$ 的一个估计值，估计是是无偏的，即
$$
E_{\theta}[\widehat{g}(X)]=g(\theta)
$$

> For example:
>
> 1. 取 $g(\theta)$ 为分布的期望 $\mu_X$，$\overline{X}$ 便是它的一个估计 $\widehat{g}(X)$

### Biased Sample Expectation's expectation

$$
E(\overline{X})=E(\frac{1}{n}\sum_{i=1}^nX_i)=\frac{1}{n}\sum_{i=1}^nE(X_i)=\frac{1}{n}\sum_{i=1}^n \mu_X=\mu_X
$$

> 从而用均值估计期望是无偏的

### Biased Sample Variance's expectation

![](https://i.loli.net/2018/08/03/5b63cc140dfb8.png)

> 从而分母为 $n$ 估计出的方差与真实方差有偏离，可以进行修正

$\therefore$ unbiased estimator is
$$
\sigma^2=\frac{n}{n-1}E[S_X^2]=\frac{1}{n-1}\sum_{i=1}^n(X_i-\overline X)^2 \\
s.t. \quad E(\sigma^2)=\sigma_{X}^2
$$

### Biased Sample Convariance's expectation

