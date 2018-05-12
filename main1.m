clear;
I = imread('lena_biased.jpg');
equlization(I);%Do histogram equalization

fp = importdata('pdf_z.txt');
K = imread('mandrill_washedout.jpg');
imspec(K,fp); %Do histogram specification