Icolor=imread('1.jpg');
imshow(Icolor);
for j=869:1225
    for i=884:889
        for k=1:3
Icolor(i,j,k)=0;
        end
    end
end
x1=1;
y1=1080;
dx=1920;
dy=1080;
imshow(Icolor);
%set(gcf,'position',[x1,y1,dx,dy]);  
imwrite(Icolor,'test1.jpg');