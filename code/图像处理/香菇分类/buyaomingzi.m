clear;
close all;
%?����ͼ��?
for i450=1:1
    close all
    ch='4_1_1_0';
    if (length(ch)==7)&&(i450<10)
        ch=strcat(ch,'0');
    end
    ch1=num2str(i450);
    ch=strcat(ch,ch1); 
    ch=strcat(ch,'.JPEG');
I=imread(ch);%?ȡ����ͼ���R����?
Ir=I;
R=I(:,:,1);
[N1,M1]=size(R);
%?��R������������ת��,������ȡ����?
R0=double(R);
Rlog=log(R0+1);
%?��R�������ж�ά����Ҷ�任?
Rfft2=fft2(R0);
%?�γɸ�˹�˲�����?
sigma=250;
F =zeros(N1,M1);
for i=1:N1 
     for j=1:M1
F(i,j)=exp(-((i-N1/2)^2+(j-M1/2)^2)/(2*sigma*sigma));
     end
end
F=F./(sum(F(:)));
%?�Ը�˹�˲��������ж�ά����Ҷ�任?
Ffft=fft2(double(F));
%?��R�������˹�˲��������о������?
DR0=Rfft2.*Ffft;
DR=ifft2(DR0);
%?�ڶ������У���ԭͼ���ȥ��ͨ�˲����ͼ�񣬵õ���Ƶ��ǿ��ͼ��?
DRdouble=double(DR);
DRlog=log(DRdouble+1);
Rr=Rlog-DRlog;
%?ȡ���������õ���ǿ���ͼ�����?
EXPRr=exp(Rr);
%?����ǿ���ͼ����жԱȶ�������ǿ?
MIN=min(min(EXPRr));
MAX=max(max(EXPRr));
EXPRr=(EXPRr-MIN)/(MAX-MIN);
EXPRr=adapthisteq(EXPRr);
%?ȡ����ͼ���G����
G=I(:,:,2);
[N1,M1]=size(G);
%?��G������������ת��,������ȡ����?
G0=double(G);
Glog=log(G0+1);
%?��G�������ж�ά����Ҷ�任?
Gfft2=fft2(G0);
%?�γɸ�˹�˲�����?
sigma=250;
for i=1:N1
    for j=1:M1
    F(i,j)=exp(-((i-N1/2)^2+(j-M1/2)^2)/(2*sigma*sigma));
    end
end
F=F./(sum(F(:)));
%?�Ը�˹�˲��������ж�ά����Ҷ�任?
Ffft=fft2(double(F));
%?��G�������˹�˲��������о������?
DG0=Gfft2.*Ffft;
DG=ifft2(DG0);
%?�ڶ������У���ԭͼ���ȥ��ͨ�˲����ͼ�񣬵õ���Ƶ��ǿ��ͼ��
DGdouble=double(DG);
DGlog=log(DGdouble+1);
Gg=Glog-DGlog;
%?ȡ���������õ���ǿ���ͼ�����
EXPGg=exp(Gg);
%?����ǿ���ͼ����жԱȶ�������ǿ?
MIN=min(min(EXPGg));
MAX=max(max(EXPGg));
EXPGg=(EXPGg-MIN)/(MAX-MIN);
EXPGg=adapthisteq(EXPGg);
%?ȡ����ͼ���B����
B=I(:,:,3);
[N1,M1]=size(B);
%?��B������������ת��,������ȡ����
B0=double(B);
Blog=log(B0+1);
%?��B�������ж�ά����Ҷ�任?
Bfft2=fft2(B0);
%?�γɸ�˹�˲�����?
sigma=250;
for i=1:N1
    for j=1:M1
     F(i,j)=exp(-((i-N1/2)^2+(j-M1/2)^2)/(2*sigma*sigma));
    end
end
F=F./(sum(F(:)));
%?�Ը�˹�˲��������ж�ά����Ҷ�任
Ffft=fft2(double(F));
%?��B�������˹�˲��������о������?
DB0=Gfft2.*Ffft;
DB=ifft2(DB0);
%?�ڶ������У���ԭͼ���ȥ��ͨ�˲����ͼ�񣬵õ���Ƶ��ǿ��ͼ��
DBdouble=double(DB);
DBlog=log(DBdouble+1);
Bb=Blog-DBlog;
EXPBb=exp(Bb);
%?����ǿ���ͼ����жԱȶ�������ǿ
MIN=min(min(EXPBb));
MAX=max(max(EXPBb));
EXPBb=(EXPBb-MIN)/(MAX-MIN);
EXPBb=adapthisteq(EXPBb);%?����ǿ���ͼ��R��G��B���������ں�?
I0(:,:,1)=EXPRr;
I0(:,:,2)=EXPGg;
I0(:,:,3)=EXPBb;
%?��ʾ���н��?
I=rgb2gray(I);
I0=rgb2gray(I0);
figure
subplot(2,2,1)
imshow(I);
subplot(2,2,2)
imshow(I0);
subplot(2,2,3)
imhist(I);
subplot(2,2,4)
imhist(I0)

I=I0;
%I=rgb2hsv(Itest);
%I=I(:,:,2);
%Ibw=im2bw(I,0.46);
[m,n]=size(I);

for ii=1:n
    for jj=1:m
        if I0(ii,jj)>0.5&&I0(ii,jj)<0.89
            I(ii,jj)=0;
        else
            I(ii,jj)=1;
        end
    end
end
figure
imshow(I)
SE=strel('disk',2);
I=imclose(I,SE);%������
SE=strel('disk',1)
IM=imopen(I,SE);%������
figure
imshow(IM);
IM=~IM;
IM=imfill(IM,'hole');

SE=strel('disk',7);
IM=imerode(IM,SE);

figure
imshow(IM);
[IM,num]=bwlabel(IM,4);
IM2=label2rgb(IM);
figure,imshow(IM2);
stats = regionprops(IM,'Area');
%Area = [stats.Area];%����������
%image_bw=bwareaopen(IM,20000);
area=cat(1,stats.Area);
%%
if i450==10
[C,L]=max(area);
area(L)=0;
end
%%

index=find(area==max(area));
image_bw=ismember(IM,index);

figure,imshow(image_bw);%��ʾ�����ͨ����
%%
IM=image_bw;
IM=~IM;
for i=1:m
    IM(i,n)=1;
    IM(i,1)=1;
end
for j=1:n
    IM(1,j)=1;
    IM(m,j)=1;
end
disp('�ڽ�Բ�뾶��Բ��λ�ã�');
[R,cx,cy]=max_inscribed_circle(IM)

for iii=1:n
    for jjj=1:m
        if sqrt((iii-cy)^2+(jjj-cx)^2)>(2*R-1)&&sqrt((iii-cy)^2+(jjj-cx)^2)<2*R+1
            Ir(iii,jjj,1)=255;
            Ir(iii,jjj,2)=0;
            Ir(iii,jjj,3)=0;
        end
    end
end
figure
imshow(Ir)
    ch='result';
    ch1=num2str(i450);
    ch=strcat(ch,ch1);
    ch=strcat(ch,'.jpg');
saveas(gcf,['',ch]);
end