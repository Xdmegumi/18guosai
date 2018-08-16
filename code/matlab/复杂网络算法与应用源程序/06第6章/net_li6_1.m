clc;clear;
%网络规模N与三种策略平均搜索步数的关系
%适当改变可换为邻耦合参数k或重连概率p与三种策略平均搜索步数的关系
k=2;p=0.2; N=[20,40,100,150,300]; n=5;
URW_total=zeros(1,n); NRRW_total=zeros(1,n);   SARW_total=zeros(1,n);
URW_Aver_Search_times=zeros(1,length(N));
NRRW_Aver_Search_times=zeros(1,length(N));
SARW_Aver_Search_times=zeros(1,length(N));
for t=1:length(N)
    A=WS_net(N(t),k,p); 
    rand_permutation=randperm(N(t));
    URW_t=zeros(1,N(t));    NRRW_t=zeros(1,N(t));   SARW_t=zeros(1,N(t));
    for j=1:n
        for i=1:N(t)
            URW_t(i)=myURW(A,rand_permutation(j),i);
            NRRW_t(i)=myNRRW(A,rand_permutation(j),i);
            SARW_t(i)=mySARW(A,rand_permutation(j),i);
        end
        URW_total(j)=sum(URW_t);
        NRRW_total(j)=sum(NRRW_t);
        SARW_total(j)=sum(SARW_t);
    end
    URW_Aver_Search_times(t)=sum(URW_total)/(n*(N(t)-1));
    NRRW_Aver_Search_times(t)=sum(NRRW_total)/(n*(N(t)-1));
    SARW_Aver_Search_times(t)=sum(SARW_total)/(n*(N(t)-1));
end
hold on, plot(N,URW_Aver_Search_times,'rs-')
plot(N,NRRW_Aver_Search_times,'g^-'), plot(N,SARW_Aver_Search_times,'bo-')
legend('URW','NRRW','SARW', 'Location', 'northwest'), title('k=2,p=0.2')
xlabel('网络规模N'), ylabel('平均搜索步数T')
