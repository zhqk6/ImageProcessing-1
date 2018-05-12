function[output]=Gkernel(a,dev);
%function to generate N*N size 2D Gaussian kernel
%a is the size of window, dev is the standard deviation
%output is the Gaussian kernel
output=zeros(a,a);
trans=zeros((a+1)/2,(a+1)/2);
%create a 2-D Gaussian kernel, 
%e.g, a=5, trans is (3,3) 
%trans is 0.6412    0.3292    0.1084
%         0.3292    0.1690    0.0556
%         0.1084    0.0556    0.0183
%than output is 
%     0.0183    0.0556    0.1084    0.0556    0.0183
%     0.0556    0.1690    0.3292    0.1690    0.0556
%     0.1084    0.3292    0.6412    0.3292    0.1084
%     0.0556    0.1690    0.3292    0.1690    0.0556
%     0.0183    0.0556    0.1084    0.0556    0.0183

for i=1:(a+1)/2
    for j=1:(a+1)/2
        trans(i,j)=exp(-(i^2+j^2)/(2*(dev^2)));
    end
end

for i=1:(a+1)/2
    for j=1:(a+1)/2
        output(i,j)=trans((a+3)/2-i,(a+3)/2-j);
    end
end

for i=1:(a+1)/2
    for j=(a+1)/2:a
        output(i,j)=trans((a+3)/2-i,j+1-(a+1)/2);
    end
end

for i=(a+1)/2:a
    for j=1:(a+1)/2
        output(i,j)=trans(i+1-(a+1)/2,(a+3)/2-j);
    end
end

for i=(a+1)/2:a
    for j=(a+1)/2:a
        output(i,j)=trans(i+1-(a+1)/2,j+1-(a+1)/2);
    end
end





