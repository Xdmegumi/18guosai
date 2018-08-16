clc
clear
for iii=1:1  
    close all
    ch='2_0_0';
%     if (length(ch)==5)&&(iii<10)
%         ch=strcat(ch,'0');
%     end
%     ch1=num2str(iii);
%     ch=strcat(ch,ch1);
%     ch=strcat(ch,'.png');

I=imread('A.jpg');
Ir=I;
Ig=rgb2gray(Ir);
%维纳滤波
g1=wiener2(I(:,:,1),[2 2]);%%红
g2=wiener2(I(:,:,2),[2 2]);%%绿
g3=wiener2(I(:,:,3),[2 2]);%%蓝
I(:,:,1)=g1;
I(:,:,2)=g2;
I(:,:,3)=g3;
figure(2)
imshow(I)
title('维纳滤波');
%I=medfilt2(I,[3,3]);
%figure
%imshow(I);
I=rgb2hsv(I);
I=I(:,:,2);
figure(3)
imshow(I);

saveas(gcf,'hsv','png');    
II=I;
%Igray=hsv2gray(I);
%figure
%imshow(Igray);
Ibw=im2bw(I,0.46);
figure(4)
imshow(Ibw);
saveas(gcf,'erzhi','png');    

%I=~I;
SE=strel('disk',8);
IM=imopen(Ibw,SE);%开运算
figure(5)
imshow(IM);
saveas(gcf,'kai','png');    

IM=~IM;
IM=imfill(IM,'hole');
%标记连通区域
[IM,num]=bwlabel(IM,4);
IM2=label2rgb(IM);
figure(6),imshow(IM2);
stats = regionprops(IM,'Area');
%Area = [stats.Area];%最大区域面积
%image_bw=bwareaopen(IM,20000);
area=cat(1,stats.Area);
index=find(area==max(area));
image_bw=ismember(IM,index);
figure(7),imshow(image_bw);%显示最大联通区域
saveas(gcf,'liantong','png');    

IM=image_bw;
IM=~IM;
%%
%plot_x=zeros(1,1); %用于记录质心位置的坐标
%plot_y=zeros(1,1);
%%求质心
%sum_x=0;sum_y=0;area=0;
%[height,width]=size(IM);
%for i=1:height
%    for j=1:width
%        if IM(i,j)==0
%            sum_x=sum_x+i;
%            sum_y=sum_y+j;
%            area=area+1;
%        end
%    end
%end
%%质心坐标
%plot_x(1)=fix(sum_x/area);
%plot_y(1)=fix(sum_y/area);
%figure(2);imshow(IM);

%%标记质心点
%hold on
%plot(plot_y(1) ,plot_x(1), '*')
%plot_y(1) 
%plot_x(1)
%%
%边界
[m,n]=size(IM);
for i=1:m
    IM(i,n)=1;
    IM(i,1)=1;
end
for j=1:n
    IM(1,j)=1;
    IM(m,j)=1;
end
%% 
%计算内接圆
disp('内接圆半径和圆心位置：');
[R,cx,cy]=max_inscribed_circle(IM)
%%
%选取操作区域
for ii=1:n
    for jj=1:m
        if sqrt((ii-cy)^2+(jj-cx)^2)>R
            Ig(ii,jj)=0;
        end
    end
end
% Ig=imcrop(Ig,[cx-R/sqrt(2) cy-R/sqrt(2) sqrt(2)*R sqrt(2)*R]);
% saveas(gcf,'neijie','png');    

Ig=imresize(Ig,[200,200]);
figure(8)
imshow(Ig);
saveas(gcf,'jieguo','png');    
%%
%Ie=edge(IM,'prewitt');
%figure
%imshow(Ie);
%%
%灰度平均值、标准差
Imean=mean2(Ig);
Istd=std2(Ig);
 %   ch='data'
 %   ch1=num2str(iii);
 %   ch=strcat(ch,ch1);
 %   ch=strcat(ch,'.txt');
 ch='dataa.txt'
    file1=fopen(ch,'a+');
%fprintf(file1,'灰度平均值：   %f',Imean)  % 输出数据;
fprintf(file1,'%f',Imean)
fprintf(file1,'\r\n');
%fprintf(file1,'灰度标准差：   %f',Istd)
fprintf(file1,'%f',Istd)
fprintf(file1,'\r\n');
%%
% function T = Texture(Image)
Gray = Ig;
[M,N,O] = size(Gray);
%M = 128; 
%N = 128;

%--------------------------------------------------------------------------
%1.将各颜色分量转化为灰度
%--------------------------------------------------------------------------
% Gray = double(0.3*Image(:,:,1)+0.59*Image(:,:,2)+0.11*Image(:,:,3));

%--------------------------------------------------------------------------
%2.为了减少计算量，对原始图像灰度级压缩，将Gray量化成16级
%--------------------------------------------------------------------------
for i = 1:M
    for j = 1:N
        for n = 1:256/16
            if (n-1)*16<=Gray(i,j)&&Gray(i,j)<=(n-1)*16+15
                Gray(i,j) = n-1;
            end
        end
    end
end

%--------------------------------------------------------------------------
%3.计算四个共生矩阵P,取距离为1，角度分别为0,45,90,135
%--------------------------------------------------------------------------
P = zeros(16,16,4);
for m = 1:16
    for n = 1:16
        for i = 1:M
            for j = 1:N
                if j<N&&Gray(i,j)==m-1&&Gray(i,j+1)==n-1
                    P(m,n,1) = P(m,n,1)+1;
                    P(n,m,1) = P(m,n,1);
                end
                if i>1&&j<N&&Gray(i,j)==m-1&&Gray(i-1,j+1)==n-1
                    P(m,n,2) = P(m,n,2)+1;
                    P(n,m,2) = P(m,n,2);
                end
                if i<M&&Gray(i,j)==m-1&&Gray(i+1,j)==n-1
                    P(m,n,3) = P(m,n,3)+1;
                    P(n,m,3) = P(m,n,3);
                end
                if i<M&&j<N&&Gray(i,j)==m-1&&Gray(i+1,j+1)==n-1
                    P(m,n,4) = P(m,n,4)+1;
                    P(n,m,4) = P(m,n,4);
                end
            end
        end
        if m==n
            P(m,n,:) = P(m,n,:)*2;
        end
    end
end

%%---------------------------------------------------------
% 对共生矩阵归一化
%%---------------------------------------------------------
for n = 1:4
    P(:,:,n) = P(:,:,n)/sum(sum(P(:,:,n)));
end

%--------------------------------------------------------------------------
%4.对共生矩阵计算能量、熵、惯性矩、相关4个纹理参数
%--------------------------------------------------------------------------
H = zeros(1,4);
I = H;
Ux = H;      Uy = H;
deltaX= H;  deltaY = H;
C =H;
for n = 1:4
    E(n) = sum(sum(P(:,:,n).^2)); %%能量
    for i = 1:16
        for j = 1:16
            if P(i,j,n)~=0
                H(n) = -P(i,j,n)*log(P(i,j,n))+H(n); %%熵
            end
            I(n) = (i-j)^2*P(i,j,n)+I(n);  %%惯性矩
           
            Ux(n) = i*P(i,j,n)+Ux(n); %相关性中μx
            Uy(n) = j*P(i,j,n)+Uy(n); %相关性中μy
        end
    end
end
for n = 1:4
    for i = 1:16
        for j = 1:16
            deltaX(n) = (i-Ux(n))^2*P(i,j,n)+deltaX(n); %相关性中σx
            deltaY(n) = (j-Uy(n))^2*P(i,j,n)+deltaY(n); %相关性中σy
            C(n) = i*j*P(i,j,n)+C(n);             
        end
    end
    C(n) = (C(n)-Ux(n)*Uy(n))/deltaX(n)/deltaY(n); %相关性   
end

%--------------------------------------------------------------------------
%求能量、熵、惯性矩、相关的均值和标准差作为最终8维纹理特征
%--------------------------------------------------------------------------
a1 = mean(E)   ;
b1 = sqrt(cov(E));

a2 = mean(H) ;
b2 = sqrt(cov(H));

a3 = mean(I)  ;
b3 = sqrt(cov(I));

a4 = mean(C);
b4 = sqrt(cov(C));

%fprintf(file1,'0,45,90,135方向上的能量依次为：   %f, %f, %f, %f \r\n',E(1),E(2),E(3),E(4))  % 输出数据;
fprintf(file1,'%f, %f, %f, %f \r\n',E(1),E(2),E(3),E(4)) 
%fprintf(file1,'0,45,90,135方向上的熵依次为：     %f, %f, %f, %f \r\n',H(1),H(2),H(3),H(4))  
fprintf(file1,'%f, %f, %f, %f \r\n',H(1),H(2),H(3),H(4))  
%fprintf(file1,'0,45,90,135方向上的惯性矩依次为： %f, %f, %f, %f \r\n',I(1),I(2),I(3),I(4))  
fprintf(file1,'%f, %f, %f, %f \r\n',I(1),I(2),I(3),I(4))  
%fprintf(file1,'0,45,90,135方向上的相关性依次为： %f, %f, %f, %f \r\n',C(1),C(2),C(3),C(4))  
fprintf(file1,'%f, %f, %f, %f \r\n',C(1),C(2),C(3),C(4))  
fclose(file1);
end