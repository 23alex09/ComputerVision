clc
clear
close all
addpath(genpath('../../Practica 4'))

I = imread('P4.tif');
Isp = SalyPimienta(I,0.9,0.95);

subplot(1,2,1)
imshow(I)
subplot(1,2,2)
imshow(Isp)

Ig = RuidoGaussiano(I,0,10);
figure
subplot(1,2,1)
imshow(I)
subplot(1,2,2)
imshow(Ig)

[N M] = size(I);
centro = round(N/2);

lineaN = I(centro,:);
lineaG = Ig(centro,:);
lineaSP = Isp(centro,:);
figure('Name','Ruido Gausiano','NumberTitle','off')
plot([1:M], lineaG,'r'), hold on
plot([1:M], lineaN,'b')
figure('Name','Ruido Sal y Pimienta','NumberTitle','off')
plot([1:M], lineaSP,'r'), hold on
plot([1:M], lineaN,'b')

save ImagenesR.mat Ig Isp