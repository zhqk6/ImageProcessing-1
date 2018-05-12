function[E]= equlization(I);
%Image Equalization
%The return value E is output equalized image
%I is the input Image
%For 8 bit (L=256) Images
[a,b]=size(I);
g=zeros(1,256);
ng=zeros(1,256);

%Calculating the pixels' value
for i=1:a
    for j=1:b
        g(I(i,j)+1)=g(I(i,j)+1)+1;
    end
end
% Create original histogram
figure;
subplot(2,2,1);
bar(0:255,g);
title('Histogram');xlabel('Gray Value');ylabel('Intensity')
ng=g/(a*b);
% Create Normalized original histogram
subplot(2,2,2);
bar(0:255,ng);
title('Normalized Hitogram');xlabel('Gray Value');ylabel('Normailized Intensity');


s=zeros(1,256);
ps=zeros(1,256);
%Cumulative histogram sk(CDF)
s(1)=ng(1);
for i=2:256
    s(i)=s(i-1)+ng(i);
end
subplot(2,2,3);
s = uint8(256.* s);  
bar(0:255,s);
title('transformation function CDF'); xlabel('Gray Value rk'); ylabel('Sk');

%Create equalized histogram
for j=1:256
   if s(j) ~= 0 && j <= 255
      if s(j) == s(j+1)
      ps(s(j)) = sum(ng(j:j+1));
      else 
      ps(s(j)) = ng(j);
      end
   end
end
subplot(2,2,4);
bar(0:255,ps);
title('Equalized Histogram');xlabel('Sk'); ylabel('Ps(Sk)');

%return equalized image
for i=1:a
    for j=1:b
    E(i,j)=s(I(i,j));
    end
end 

figure;
subplot(1,2,1);imshow(I);title('Original Image');
subplot(1,2,2);imshow(E);title('Equlized Image');