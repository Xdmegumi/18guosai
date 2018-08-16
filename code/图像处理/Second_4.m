close
SL=zeros(41,1);  
B=zeros(41,2);
for k=1:1
Icolor=imread(['p',num2str(k),'.jpg']);
Igray=rgb2gray(Icolor);
%figure
%subplot(1,2,1)
%imshow(Icolor);
Igray=imadjust(Igray);%对比度增强
%subplot(1,2,2)
figure,imshow(Igray);
Ibw=im2bw(Igray,0.9);%二值化，阈值0.9
%figure
%imshow(Ibw)
SE=strel('line',20,0);
IM=imclose(Ibw,SE);%闭运算
%figure,imshow(IM)
%IM2=bwperim(IM);
%figure,imshow(IM2)
IM=imcrop(IM,[349 736 500 121]);%图像分割
%figure,imshow(IM)
IM1=~IM;
[IM,num]=bwlabel(IM1,4);
IM2=label2rgb(IM);
%figure,imshow(IM2);


stats = regionprops(IM);
Area = [stats.Area];%最大区域面积
image_bw=bwareaopen(IM,4500);
%figure,imshow(image_bw);%显示最大联通区域
BW=image_bw;

thresh=[0.01,0.17];  
sigma=2;%定义高斯参数  
f = edge(double(BW),'canny',thresh,sigma);  
figure(),imshow(f,[]);  
title('canny 边缘检测');  

f=double(f);
[m,n]=size(f);

for i=n:-1:1
    for j=1:m
        if (double(f(j,i))==1)
            B(k,1)=i;
            B(k,2)=j;
            SL(k)=sqrt((j-105)^2+(i-75)^2)/140;
            break;
        end
    end
    if (double(f(j,i))==1)
        break;
    end
end
end