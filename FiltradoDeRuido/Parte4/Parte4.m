clc
clear
close all
addpath(genpath('../../Practica 4'))

%Filtro Temporal
I = imread('P4.tif');
Ir1 = double(RuidoGaussiano(I,0,35));
Ir2 = double(RuidoGaussiano(I,0,35));
Ir3 = double(RuidoGaussiano(I,0,35));
Ir4 = double(RuidoGaussiano(I,0,35));
Ir5 = double(RuidoGaussiano(I,0,35));
Ir6 = double(RuidoGaussiano(I,0,35));
Ir7 = double(RuidoGaussiano(I,0,35));
Ir8 = double(RuidoGaussiano(I,0,35));
Ir9 = double(RuidoGaussiano(I,0,35));
Ir10 = double(RuidoGaussiano(I,0,35));

Isuma = Ir1 + Ir2 + Ir3 + Ir4 + Ir5 + Ir6 + Ir7 + Ir8 + Ir9 + Ir10;
If= Isuma/10;

figure
subplot(1,2,1)
imshow(uint8(Ir5))
subplot(1,2,2)
figure,imshow(uint8(If))