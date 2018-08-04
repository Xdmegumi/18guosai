## Bootstrap 方法

一般情况下，总体永远都无法知道，我们能利用的只有样本，现在的问题是，样本该怎样利用呢？Bootstrap 的奥义也就是：既然样本是抽出来的，那我何不从样本中**再抽样（Resample）**？

Bootstrap 方法最初由美国斯坦福大学统计学教授 Efron 在 1977 年提出。作为一种**崭新的增广样本统计方法**，Bootstrap 方法为解决小规模子样试验评估问题提供了很好的思路。

> 在这里 “bootstrap” 法是指用原样本自身的数据抽样得出新的样本及统计量，根据其意现在普遍将其译为“自助法”。 

这种方法可以用于对**总体知之甚少**的情况。

### 非参数 Bootstrap 方法

#### 估计量的标准差的 bootstrap 估计

在估计总体的未知参数 $\theta$ 时，不仅要给出估计值，还要给出估计值的精度，通常用其标准差 $\sqrt{D(\widehat{\theta})}$ 来度量（似乎还有一定显著水平下的置信区间把。。）。

设 $X_1,X_2,\cdots,X_n$ 为来自以 $F(x)$ 为分布函数的总体的样本，用 
$$
\widehat{\theta}=\widehat{\theta}(X_1,X_2,\cdots,X_n)
$$
作为 $\theta$ 的估计量，在应用中其抽样分布是很难得到的，这里 $\sqrt{D(\widehat{\theta})}$ 通常没有一个好的表达式，但可以用计算机模拟估计其值。为此自 $F$ 产生很多容量为 $n$ 的 $B$ 个样本估计出 $\widehat{\theta}_1,\widehat{\theta}_2,\cdots,\widehat{\theta}_B$ ,则 $\sqrt{D(\widehat{\theta})}$ 可以用
$$
\widehat{\sigma}_{\widehat{\theta}}=\sqrt{\frac{1}{B-1}\sum_{i=1}^B(\widehat{\theta}_i-\overline{\theta})^2}
$$
来估计。其中 $\overline{\theta}=\sum \limits_{i=1}^B\widehat{\theta}_i$ 。

> 其实就是再造出几个样本（**resampling**）来进行无偏估计。

算法步骤：

1. 自原始数据样本 $x_1,x_2,\cdots,x_n$ 按**放回的抽样法** 抽的容量为 $n$ 的样本，称为 Bootstrap 样本

2. 相继、独立的抽取 $B$ （ $B\ge1000$ ）个bootstrap 样本，$x_1^{*i},x_2^{*i},\cdots，x_n^{*i},i=1,2,\cdots,B$ 对第 $i$ 个样本计算估计 $\widehat{\theta}_i^*=\widehat{\theta}(x_1^{*i},x_2^{*i},\cdots，x_n^{*i})$  

3. 计算
   $$
   \widehat{\sigma}_{\widehat{\theta}}=\sqrt{\frac{1}{B-1}\sum_{i=1}^B(\widehat{\theta}_i^*-\overline{\theta^*})^2}
   $$
   其中 $\overline{\theta^*}=\sum \limits_{i=1}^B\widehat{\theta}_i^*$



#### bootstrap估计近似置信区间

代码见小黄书 144 页

优点：

1. 不用对总体有任何假设，试用与小样本（一般多用的 $t$ 分布求置信区间对总体是有要求的）
2. 不限于某些统计量，如样本均值，均可以近似估计



### 参数 Bootstrap 方法

先用极大似然法估计出总体的分布，然后再放回取样做推断



## 方差分析（ANOVA）

先从因子试验模型说起，假设我们感兴趣的是指标 $y$ ，把它视为因变量，而影响他的有很多因子，记为 $F_1,F_2,\cdots,F_k$ ，其中因子 $F_i$ 有 $S_i$ 个水平。在因子试验模型中每个因子的**每个水平才是自变量**（在因子的叫法上与回归分析等是有区别的），而且这是一个0-1标号变量，在某一个试验点上，因子 $F_i$ 的第 $j$ 个水平被使用，则与之相应的变量才取1，称作该自变量的效应。

> 从而一个试验点上一个因子有且只有一个水平取1

模型的假定是各效应对 $y$ 的效应是可以累加的，故亦可以成为可加模型。如果一个因子的各个水平的效应有不同，则这个因子是显著的

方差分析正是**检验**因子在试验过程中的显著性而引进的一种方法。

### 方差分析模型

设在 $n$ 个点上做了实验，得到观察值向量 $\boldsymbol{y}=(y_1,y_2,\cdots,y_n)^T$ ，它满足一个线性模型
$$
\boldsymbol{y}=\boldsymbol{X}\boldsymbol{\beta}+\boldsymbol{\varepsilon}
$$
称 $||\boldsymbol{y}||^2=\sum \limits_{a=1}^ny_a^2$ 为总的平方和，如果这个总平方和可以拆成一些非负项的和，比如 $||\boldsymbol{y}||^2=\sum \limits_{i=1}^r \xi _i$ ，而 $\xi_i$ 又有明确的统计解释，那么上述分解式便可用语统计推断，**这种分解叫做方差分析**

**假设前提**

1. 对因子的某一个水平，例如第 $j$ 个水平，把观察得到的值 $X_{1j}，X_{2j}，\cdots,X_{nj}$  看成从正态分布总体 $N(\mu_j,\sigma^2)$ 中获得的一个样本。亦即不同样本中同一因子的某个水平近似为正态分布
2. 代表不同水平的总体正态方差相同



**待检假设**：这 $s$ 个水平期望相同 $\mu_1,\mu_2,\cdots,\mu_s$ 

若统计量 $F$ 的观察值大于临界值 $F_\alpha$ ，则拒绝原假设，并认为**各水平之间存在显著差异**



以上即单因素方差分析



感觉方差分析这块有待进一步整理。。。









