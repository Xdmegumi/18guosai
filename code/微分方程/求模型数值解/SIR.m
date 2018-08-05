    function dx=SIR(t,x)
    % 初始化
        dx=zeros(2,1); 
    %% 定义参数
    % 日接触率
    lambda=1
    % 日治愈率
    mu=0.3
    %% 模型 x(1)为感染者
    dx(1)=lambda*x(1)*x(2)-mu*x(1);
    dx(2)=-lambda*x(1)*x(2);
