function a=generategraph(m0,e0); %生成m0个节点，e0条边的网络的邻接矩阵a
if e0>m0*(m0-1)/2
    fprintf('输入数据m0,e0不匹配\n'); return
end
a=zeros(m0); %邻接矩阵初始化
ra=rand(m0); %生成m0阶的随机方阵
ra=tril(ra); %截取下三角部分元素
ra([1:m0+1:end])=0; %对角线元素置0
[sra,ind]=sort(nonzeros(ra),'descend'); %把矩阵ra中的非零元素按照从大到小排序
p=sra(e0);  %提取排序后的第e0个元素
a(ra>=p)=1; %生成e0条边的邻接矩阵的下三角元素
a=a+a';  %生成完整的邻接矩阵
