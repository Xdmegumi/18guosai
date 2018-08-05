    function dx=SIB(t,x)
    % 初始化
        dx=zeros(3,1); 
    %% 定义参数
    % 日接触率
    lambda=1
    % 日治愈率
    mu=0.3
    % 过渡率
    p=0.8
    %% 模型 x(1)为感染者 x(2)为健康者，x(3)为过渡期者
    dx(1)=lambda*x(2)*(x(3)+x(1))-x(1)*(mu+lambda*p);
    % 不考虑死亡
    dx(2)=-lambda*x(1)*x(2)+mu*(x(1)+x(3));
    % 考虑死亡
%     dx(2)=-lambda*x(1)*x(2);
    dx(3)=lambda*x(1)*(p*x(2)-x(3))-mu*x(3);
