clear 
clc 
fitnessfcn=@Fun2;        %������Ӧ�Ⱥ���
nvars=30;                %��������
lb=zeros(1,30);       %��������
ub=ones(1,30); 
N=30;                    %���д���
A=[];b=[];               %Լ������
IntCon=1;
Aeq=[];beq=[]; 
% [x,fval,exitflag] = ga(@rastriginsfcn,2,[],[],[],[],...
%     lb,ub,[],IntCon,opts)
% ��ͼ����
options=gaoptimset('populationsize',1000,'generations',300,'stallGenLimit',200,'TolFun',1e-10,'MutationFcn', {@mutationadaptfeasible, 0.9},'CrossoverFraction',0.9,'PlotFcns',{@gaplotbestindiv,@gaplotbestf});
[x,fval]=ga(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,[],[1:30],options);   %��ʼ��һ��ͼ������ѭ���Ƚ�
saveas(gcf,'output','png');                                   %�洢��һ��ͼ
INDEX(1)=fval;                                                %ͨ��������Ӧ�Ⱥ���ֵ���鶨λȫ�֣�ָ��30���У����Ž�
Anwser(1).x=x;                                                %ͨ���ṹ�屣��ÿһ�ε����Ž�
%  for i=2:N
%  [x,fval]=ga(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,[],options);
%  %�Ա���Ϣ���б���
%  INDEX(i)=fval;          
%  Anwser(i).x=x;    
%  %ѡ�����ͼƬ����
%  if(fval==min(INDEX))
%      delete output;
%      saveas(gcf,'output','png');
%  end   
%  end 

[minvalue,indexmin]=min(INDEX);   %ȷ�����Ž�λ��
[maxvalue,indexmax]=max(INDEX);   %ȷ������λ��

%����������ݣ����Ʊ��
r=mean(INDEX);
t=var(INDEX);
table=[minvalue,maxvalue,r,t];
bestanwser=Anwser(indexmin).x;
bestvalue=INDEX(indexmin);
disp(table);
disp(bestvalue);