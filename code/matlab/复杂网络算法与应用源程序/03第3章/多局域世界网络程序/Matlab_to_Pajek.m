function Matlab_to_Pajek(A,k)  
%Matlab邻接矩阵A转换成Pajek数据的函数
%k是第k次转换，生成的文件命名成Pajek_datak.net,
%如果不输入第2个参数k,默认文件名为Pajek_data1.net
if nargin==1
    str='Pajek_data1.net';
else
    str=['Pajek_data',int2str(k),'.net'];
end
n=length(A); v=1:n;
fid=fopen(str,'w');  %创建纯文本文件Pajek_data.net
fprintf(fid,'%s%d\n','*Vertices  ',n); %写入字符串并换行
for i=1:n
   fprintf(fid,' %d  ',v(i));   %写入节点编号
   
   fprintf(fid,'"%d"\n',v(i));  %写入双引号节点字符串并换行
end
fprintf(fid,'%s\n%s\n','*Arcs','*Edges'); %写入两个字符串并各自换行
A=tril(A);  %截取邻接矩阵的下三角元素
[u,v]=find(A); n=length(u); %找非零元素，并计算个数
for i=1:n
    fprintf(fid,'  %d  %d  1\n',u(i),v(i));  %逐条边写入信息并换行
end
fclose(fid);
