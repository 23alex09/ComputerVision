clc
clear
close all
addpath(genpath('../../../Practica 2'))
load ModeloKNNVerde.mat
load combinacion3V.mat

numImagen{1} = '1';
numImagen{2} = '2';

%RGB
RendimientoKNNVerde = [];
for i = 1:2
    Im = imread(['EvRojo' numImagen{i} '.tif']);
    Gold = imread(['EvRojo' numImagen{i} '_Gold.tif']);

    Ir = imresize(Im, 0.5);

    [F C canal] = size(Im);
    [Fr Cr canalr] = size(Ir);

    datos = ExtraeDatos(Ir);

    salida = predict(ModeloKNNVerde, datos(:,MejorComb3));
    salidaVerde = zeros(Fr,Cr);
    
    salidaVerde(salida == 1) = 1;
    salidaVerde = round(imresize(salidaVerde,[F C],'nearest'));
    %figure, imshow(Im), figure, imshow(salidaVerde);
    %[Sens Esp Prec FalsosPositivos] = funcion_metricas(salidaVerde, Gold);

    %RendimientoKNNVerde = [RendimientoKNNVerde; Sens Esp Prec FalsosPositivos];
end


%save RendimientoKNN.mat RendimientoKNNRGB RendimientoKNNRSL RendimientoKNNLab