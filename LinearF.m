function[output]=LinearF(I,M)
%function for filtering image by Gaussian filter
%I is input image
%M is normalized filter matrix (N*N)
[N,N]=size(M);
[a,b]=size(I);
output=I;

% the algorithm of calculating Guassian filter while filtering
for i = 1:a-N+1;
    for j= 1:b-N+1
        X=I(i:i+N-1,j:j+N-1).*M;
        output(i+1,j+1)=sum(sum(X));
    end
end
output=uint8(output);