%% ŷ�Ͼ���
load data1.txt %�������ݣ���Ϊ��������Ϊ����
X=data1; %��ֵ��X
u=mean(X); %���ֵ
[m,n]=size(X);
for i=1:m
dist(i)=sqrt(sum(X(i,:)-u).^2);
end
[a,b]=sort(dist);%��ŷ�Ͼ����������
T=ceil(m*0.02)%���÷�ֵ
Threshold=a(m-T);%��Ϊ��ֵ
len=length(a);
for i = 1:len %���������С�ڷ�ֵΪ������
    if a(i) < Threshold
        inlier(i) = [b(i)];
        s=b(i);
        disp(['���������кţ�',num2str(s)])
    end
end
% inlier
for i = 1:len %������������ڵ��ڷ�ֵΪ������
    if a(i)>= Threshold
        outlier(i) = [b(i)];
        ns=b(i)
        disp(['��Ⱥ�����кţ�',num2str(ns)])
    end
end
% outlier

%% �������Ͼ���ģ�
load data1.txt %�������ݣ���Ϊ��������Ϊ����
X=data1; %��ֵ��X
u=mean(X); %���ֵ
[m,n]=size(X);
for i=1:m
newdata=[X(i,:);u]
cov_w=cov(newdata);%��Э�������
dist(i)=(X(i,:)-u)*cov_w*(X(i,:)-u)'%���ÿ��������u�����Ͼ���
end
[a,b]=sort(dist);%�����Ͼ����������
T=ceil(m*0.02)%���÷�ֵ
Threshold=a(m-T);%��Ϊ��ֵ
clear T;
len=length(a);
for i = 1:len %���������С�ڷ�ֵ,Ϊ������
    if a(i) < Threshold
        inlier(i) = [b(i)];
        s=b(i);
        disp(['���������кţ�',num2str(s)])
    end
end

% inlier
for i = 1:len %������������ڵ��ڷ�ֵΪ�쳣��
    if a(i)>= Threshold
        outlier(i) = [b(i)];
        l=b(i)
        disp(['��Ⱥ�����кţ�',num2str(l)])
    end
end
% outlier