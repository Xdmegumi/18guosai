    function dx=SIR(t,x)
    % ��ʼ��
        dx=zeros(2,1); 
    %% �������
    % �սӴ���
    lambda=1
    % ��������
    mu=0.3
    %% ģ�� x(1)Ϊ��Ⱦ��
    dx(1)=lambda*x(1)*x(2)-mu*x(1);
    dx(2)=-lambda*x(1)*x(2);
