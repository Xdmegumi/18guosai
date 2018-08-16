clc, clear
alpha=0.25; beta=0.3;
m=15; n=10; s=10; %设置网络节点纵横个数，及水平和垂直间距
u=0:s:(m-1)*s; v=0:s:(n-1)*s;
[u,v]=meshgrid(u,v); %生成网格节点的横坐标和纵坐标
u=u(:); v=v(:);  %转换成列向量
hold on, plot(u,v,'*')  %画m×n个点
uv=[u';v'];  %构造m×n个点的坐标
d=dist(uv);  %求m×n个点之间的两两距离矩阵
L=max(max(d)); %求最大距离
gailv=alpha*exp(-d/(beta*L)); %计算概率矩阵
gailv=tril(gailv);  %提取概率矩阵的下三角元素
gailv(1:m*n+1:end)=0; %概率矩阵的对角线元素置0
randnum=rand(m*n); %生成服从[0,1]上均匀分布随机数的150×150矩阵
[i,j]=find(randnum<=gailv) ;  %节点i和j之间连边
a=zeros(m*n); %邻接矩阵初始化
for k=1:length(i)
    a(i(k),j(k))=1; a(j(k),i(k))=1;  %构造邻接矩阵
    plot([u(i(k)),u(j(k))],[v(i(k)),v(j(k))]); %节点i和j之间画线
end
deg=sum(a); %计算所有节点的度
dminmax=minmax(deg)  %求度的最小值和最大值
pinshu=hist(deg,[dminmax(1):dminmax(2)]); %计算度取值的频数
figure, loglog([dminmax(1):dminmax(2)],pinshu,'.-') %对数坐标系画图
xlabel('度'), ylabel('度的频数')
Matlab_to_Pajek(a)  %生成Pajek数据，文件名为Pajek_data1.net
