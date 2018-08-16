close
SL=zeros(41,1);  
B=zeros(41,2);
for k=1:1
Icolor=imread(['p',num2str(k),'.jpg']);
Igray=rgb2gray(Icolor);
%figure
%subplot(1,2,1)
%imshow(Icolor);
Igray=imadjust(Igray);%�Աȶ���ǿ
%subplot(1,2,2)
figure,imshow(Igray);
Ibw=im2bw(Igray,0.9);%��ֵ������ֵ0.9
%figure
%imshow(Ibw)
SE=strel('line',20,0);
IM=imclose(Ibw,SE);%������
%figure,imshow(IM)
%IM2=bwperim(IM);
%figure,imshow(IM2)
IM=imcrop(IM,[349 736 500 121]);%ͼ��ָ�
%figure,imshow(IM)
IM1=~IM;
[IM,num]=bwlabel(IM1,4);
IM2=label2rgb(IM);
%figure,imshow(IM2);


stats = regionprops(IM);
Area = [stats.Area];%����������
image_bw=bwareaopen(IM,4500);
%figure,imshow(image_bw);%��ʾ�����ͨ����
BW=image_bw;

thresh=[0.01,0.17];  
sigma=2;%�����˹����  
f = edge(double(BW),'canny',thresh,sigma);  
figure(),imshow(f,[]);  
title('canny ��Ե���');  

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