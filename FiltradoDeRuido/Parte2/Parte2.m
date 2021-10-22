clc
clear
close all
addpath(genpath('../../Practica 4'))
load ImagenesR.mat

I = imread('P4.tif');

%Filtro Gaussiano

W = 5;
sigma = W/5;

Mih = Mifspecial(W);
h = fspecial('gaussian',W,sigma); 

dif = Mih - h

Ifg = imfilter(Isp, h, 'replicate');
figure, imshow(Ifg);
%Filtro de la Mediana

Ifm = FiltroMediana(Isp, [5 5], 'replicate');
Ifm = uint8(Ifm);
figure, imshow(Ifm);

Ifm2 = medfilt2(Isp,[5 5], 'replicate');
figure, imshow(Ifm2);

Ib = Ifm == Ifm2;
a = find(Ib == 0);

%Filtro Adaptativo

Ruido = double(Isp) - double(I);
VarRuido = std(Ruido(:))^2;
tic
Ifa1 = FiltroAdaptativoV1(Isp, [5 5], VarRuido, 'symmetric');
toc
Ifa1 = uint8(Ifa1);
figure, imshow(Ifa1);

tic
Ifa2 = FiltroAdaptativoV2(Isp, [5 5], VarRuido, 'symmetric');
toc
Ifa2 = uint8(Ifa2);
figure, imshow(Ifa2);


