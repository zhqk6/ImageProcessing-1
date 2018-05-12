function[output,s1]=imspec(I,input);
%Image Specification
%The return value s is output image after specification
%I is the input Image
%Input is now known as a (1,256) matrix.It is given histogram
%For 8 bit (L=256) Images

[a,b]=size(I);
g=zeros(1,256);
for i=1:a
    for j=1:b
        g(I(i,j)+1)=g(I(i,j)+1)+1;
    end
end
figure;
subplot(3,2,1);
bar(0:255,g);
title('Original Histogram');xlabel('Gray Value');ylabel('Intensity')
% Create original histogram
% ng is normalized. Pr(rk)
subplot(3,2,2);
ng=g/(a*b);
bar(0:255,ng);
title('Original Normalized Hitogram');xlabel('Gray Value');ylabel('Normailized Intensity');

s=zeros(1,256);
ps=zeros(1,256);
s(1)=ng(1);
for i=2:256
    s(i)=s(i-1)+ng(i);
end
subplot(3,2,3);
s = uint8(256 .* s);  
bar(0:255,s);
title('Original transformation function CDF'); xlabel('Gray Value rk'); ylabel('Sk');

for j=1:256
   if s(j) ~= 0 && j <= 255
      if s(j) == s(j+1)
      ps(s(j)) = sum(ng(j:j+1));
      else 
      ps(s(j)) = ng(j);
      end
   end
end
subplot(3,2,4);
bar(0:255,ps);
title('Original Equalized Histogram');xlabel('Sk'); ylabel('Ps(Sk)');

%Process above is producing the original equlized histogram, the same as
%the function equalizaion.m.

%Calculate cumulative histogram G(z) for the given specified histogram
%Which is also the same as calculating Sk in the function equlization.m.
subplot(3,2,5);
bar(0:255,input);
title('Given Histogram');xlabel('Gray Value zq');ylabel('Normailized Intensity');
Gz=zeros(1,256);
Gz(1)=input(1);
for i=2:256
    Gz(i)=Gz(i-1)+input(i);
end
subplot(3,2,6);
Gz =(256 .* Gz);  
bar(0:255,Gz);
title('Given histogram CDF'); xlabel('Gray Value zq'); ylabel('Gz');

%Calculating the differencee between two cumulative histogram G(z) and Sk
%different(256,256)is the 2-d array of the differences between G(z) and Sk
pz=zeros(1,256);
different=zeros(256,256);
for i=1:256
   for j=1:256
    different(i,j)=abs((s(i)-Gz(j)));
   end
end 

%Calculating result histogram pz
minvalue=0;
for i=1:256
    minimum=min(different(i,:));
    [~,v1]=find(different(i,:)==minimum);
    if minvalue<min(v1);
%minvalue is a label which makes the mapping monotonically increasing
    pz(min(v1))=ng(i);
    minvalue=min(v1);
    end
end

figure;bar(0:255,pz);title('Histogram after specification');
xlabel('Gray Value');ylabel('Pz');

%Get the new specified image from pz and cumulative pz---s1
s1=zeros(1,256);
s1(1)=pz(1);
for i=2:256
    s1(i)=s1(i-1)+pz(i);
end
s1 = uint8(256.*s1);  
for i=1:a
    for j=1:b
    output(i,j)= s1(I(i,j));
    end
end

figure;
subplot(1,2,1);imshow(I);title('Original Image');
subplot(1,2,2);imshow(output);title('Image after specification');