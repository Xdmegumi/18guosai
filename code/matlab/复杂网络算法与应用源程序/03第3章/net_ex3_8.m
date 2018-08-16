clc, clear, hold on
m=100; n=100; num=100;%m和n分别为水平方向和垂直方向点的个数;num为选择节点的个数
hh=10; gamma=0.15; %hh为格子点水平方向和垂直方向的步长,gamma为重要节点比率 
k0=8; %k0为重要节点安全度的阈值
u=0:hh:(m-1)*hh; v=0:hh:(n-1)*hh; %在平面中取m×n个hh×hh的格子点
xr=randi([1,m]); yr=randi([1,n]); %随机选取第一个点的x和y标号
label=[xr;yr];
xy=[u(xr),v(yr)]; %提取第一个点的坐标
for i=1:num-1   %选取另外的num-1个点
    flag=1; %循环选点控制变量初始化
    while flag
      xr=randi([1,m]); yr=randi([1,n]);%随机选下个点的x和y的标号  
      xt=u(xr); yt=v(yr); %提取选取的另外一点坐标  
      tt=[xy;[xt,yt]];
      if all(pdist(tt)>10*sqrt(2))   %如果所有点两两距离大于指定阈值
          label=[label,[xr;yr]];
          xy=[xy; [xt,yt]]; flag=0; %选点成功 
      end
    end
end
dd0=dist(xy');  %求选取的所有节点对之间的两两距离邻接矩阵 
dd=tril(dd0); dd=sparse(dd); %生成Matlab需要的下三角阵的稀疏矩阵
[st,pred]=graphminspantree(dd); %求最小生成树
[k1,k2]=find(st); %找st中非零元的行标和列标，即最小生成树连边端点
z1=complex(xy(k1,1),xy(k1,2)); z2=complex(xy(k2,1),xy(k2,2));
z=[z1.'; z2.']; h=plot(z,'-P'); %使用复数画图比较方便
set(h,'Color','k','LineWidth',1.3)
stw=full(st); %把稀疏矩阵转化为普通矩阵
stw=stw+stw'; %最小生成树的完整距离邻接矩阵
dm=zeros(size(stw));  %最小生成树的0-1邻接矩阵的初始值
dm(find(stw))=1; %把stw中非零元素换成1，构造最小生成树的0-1邻接矩阵
deg=sum(dm);   %求最小生成树各节点的度
dd2=dd0; dd2(1:num+1:end)=inf;  %为了下面找权重最小的边作为添加边，对角线换成inf
rnum=randperm(num); %产生1~num的一个全排列
addnode=rnum(1:round(gamma*num)); %产生加边的节点编号
for k=addnode
    if deg(k)<k0
        tt=dm(:,k); %提出邻接矩阵的第k列
        tt(tt==1)=inf; %把tt中的1变换成无穷
        dd2(:,k)=dd2(:,k)+tt; %把已选取边对应的元素换成无穷
        dd2(k,:)=dd2(k,:)+tt';
        [sd,ind]=sort(dd2(:,k)); %把离节点k的节点按从近到远排序
        knode=ind(1:min(k0-deg(k),length(ind))); %选取k节点对应的加边节点
        dm(k,knode)=1; dm(knode,k)=1; %加边     
    end
end
figure, hold on %画第二个图形
[k1,k2]=find(dm);
z1=complex(xy(k1,1),xy(k1,2)); z2=complex(xy(k2,1),xy(k2,2));
z=[z1.'; z2.']; h=plot(z,'-P');
set(h,'Color','k','LineWidth',1.3)
