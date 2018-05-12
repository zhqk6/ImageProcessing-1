clear;
I=imread('A_pattern.jpg');
I1=double(I);
[a,b]=size(I);

%Gradient Image using Sobel operator
M=I1;
for i=2:a-1
    for j=2:b-1
    gx=I1(i-1,j+1)+2*I1(i,j+1)+I1(i+1,j+1)-I1(i-1,j-1)-2*I1(i,j-1)-I1(i+1,j-1);
    gy=I1(i+1,j-1)+2*I1(i+1,j)+I1(i+1,j+1)-I1(i-1,j-1)-2*I1(i-1,j)-I1(i-1,j+1);
    M(i,j)=sqrt(gx^2+gy^2);
    end
end
M=uint8(M);
figure;
subplot(1,2,1);imshow(I);title('Original Image');
subplot(1,2,2);imshow(M);title('Gradient Image');

%Average Filter, L is 3*3, 1/9
L(1:3,1:3)=1;
for i=1:a-2
    for j=1:b-2
        X=I1(i:i+2,j:j+2).*L;
        K(i+1,j+1)=sum(sum(X))/9;
    end
end
K=uint8(K);
figure;
subplot(1,2,1);imshow(I);title('Original Image');
subplot(1,2,2);imshow(K);title('Image after Average Filter');

%2D Gaussian kernel
GK1=Gkernel(5,1.5);
GK2=Gkernel(9,1.5);
GK3=Gkernel(15,1.5);
%Normalize the Gaussian kernel
GaussFilter1=(GK1)./(sum(sum(GK1)));
GaussFilter2=(GK2)./(sum(sum(GK1)));
GaussFilter3=(GK3)./(sum(sum(GK1)));
%Create a function LinearF to calculate
K1=LinearF(I1,GaussFilter1);
K2=LinearF(I1,GaussFilter2);
K3=LinearF(I1,GaussFilter3);
%Compare to the original image
figure;
subplot(1,2,1);imshow(I);title('Original Image');
subplot(1,2,2);imshow(K1);title('Image after 5*5 Gaussian Filter');
figure;
subplot(1,2,1);imshow(I);title('Original Image');
subplot(1,2,2);imshow(K2);title('Image after 9*9 Gaussian Filter');
figure;
subplot(1,2,1);imshow(I);title('Original Image');
subplot(1,2,2);imshow(K3);title('Image after 15*15 Gaussian Filter');
