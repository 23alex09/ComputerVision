clc
clear
close all
addpath(genpath('../../../Practica 2'))
load ModelosSVM.mat

numImagen{1} = '1';
numImagen{2} = '2';

%RGB
RendimientoSVMRGB = [];
for i = 1:2
    Im = imread(['EvRojo' numImagen{i} '.tif']);
    Gold = imread(['EvRojo' numImagen{i} '_Gold.tif']);

    Ir = imresize(Im, 0.5);

    [F C canal] = size(Im);
    [Fr Cr canalr] = size(Ir);

    datos = ExtraeDatos(Ir);

    salida = predict(ModeloSVMRGB, datos(:,1:3));
    salidaRGB = zeros(Fr,Cr);
    salidaRGB(salida == 1) = 1;
    salidaRGB = round(imresize(salidaRGB,[F C],'nearest'));

    [Sens Esp Prec FalsosPositivos] = funcion_metricas(salidaRGB, Gold);

    RendimientoSVMRGB = [RendimientoSVMRGB; Sens Esp Prec FalsosPositivos];
end

CC = [1];

c1 = [255 0 0 0];
c2 = [0 255 0 0];
c3 = [0 255 255 0];

R = Im(:,:,1);
G = Im(:,:,2);
B = Im(:,:,3);

for i = 1:length(CC)
   Ibin = salidaRGB == CC(i);
   R(Ibin) = c1(i);
   G(Ibin) = c2(i);
   B(Ibin) = c3(i);
end

IColor = cat(3, R, G, B);

imshow(IColor);

%RSL
RendimientoSVMRSL = [];
for i = 1:2
    Im = imread(['EvRojo' numImagen{i} '.tif']);
    Gold = imread(['EvRojo' numImagen{i} '_Gold.tif']);

    Ir = imresize(Im, 0.5);

    [F C canal] = size(Im);
    [Fr Cr canalr] = size(Ir);

    datos = ExtraeDatos(Ir);

    salida = predict(ModeloSVMRSL, datos(:,[1 5 10]));
    salidaRSL = zeros(Fr,Cr);
    salidaRSL(salida == 1) = 1;
    salidaRSL = round(imresize(salidaRSL,[F C],'nearest'));

    [Sens Esp Prec FalsosPositivos] = funcion_metricas(salidaRSL, Gold);

    RendimientoSVMRSL = [RendimientoSVMRSL; Sens Esp Prec FalsosPositivos];
end

%Lab
RendimientoSVMLab = [];
for i = 1:2
    Im = imread(['EvRojo' numImagen{i} '.tif']);
    Gold = imread(['EvRojo' numImagen{i} '_Gold.tif']);
    Ir = imresize(Im, 0.5);

    [F C canal] = size(Im);
    [Fr Cr canalr] = size(Ir);

    datos = ExtraeDatos(Ir);

    salida = predict(ModeloSVMLab, datos(:,10:12));
    salidaLab = zeros(Fr,Cr);
    salidaLab(salida == 1) = 1;
    salidaLab = round(imresize(salidaLab,[F C],'nearest'));
    [Sens Esp Prec FalsosPositivos] = funcion_metricas(salidaLab, Gold);

    RendimientoSVMLab = [RendimientoSVMLab; Sens Esp Prec FalsosPositivos];
end

save RendimientoSVM.mat RendimientoSVMRGB RendimientoSVMRSL RendimientoSVMLab