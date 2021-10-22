clc
clear
close all
addpath(genpath('../../Practica 2'))
load nets.mat
load ModeloKNNVerde.mat
load ModeloKNN.mat
load combinacion3V.mat
load combinacion3.mat

%Para la deteccion del rojo voy a usar la NN RGB



numImagen{1} = '1';
numImagen{2} = '2';
numImagen{3} = '3';
rendimiento = [];
for i = 1:3
   Im = imread(['SegFresas' numImagen{i} '.tif']);
   Gold = imread(['SegFresas' numImagen{i} '_Gold.tif']); 

   Ir = imresize(Im, 0.5);

   [F C canal] = size(Im);
   [Fr Cr canalr] = size(Ir);

   datos = ExtraeDatos(Ir);

   salidaR = round(sim(netRGB, datos(:,1:3)'));
   salidaRojo = zeros(Fr,Cr);
   salidaRojo(salidaR == 1) = 1;
   salidaRojo = round(imresize(salidaRojo,[F C],'nearest'));
   
   salidaV = predict(ModeloKNNVerde, datos(:,MejorComb3));
   salidaVerde = zeros(Fr,Cr);
   salidaVerde(salidaV == 1) = 1;
   salidaVerde = round(imresize(salidaVerde,[F C],'nearest'));
   
   ImColor = Im;
   
   for j = 1:F
       for k = 1:C
           if salidaRojo(j,k) == 1
                ImColor(j,k,:) = [255 0 0];               
           end
           if salidaVerde(j,k) == 1
                ImColor(j,k,:) = [0 0 255];
           end
       end
   end
   
%    salidaF = predict(ModeloKNNVerde, datos(:,combinacion3));
%    salidaFinal = zeros(Fr,Cr);
%    salidaFinal(salidaF == 1) = 1;
%    salidaFinal = round(imresize(salidaFinal,[F C],'nearest'));
   
   %figure, imshow(Im), figure, imshow(Gold), figure, imshow(ImColor);
   salida = salidaVerde | salidaRojo;
    
   salidaRojo = bwareaopen(salidaRojo,50);
   salidaVerde = bwareaopen(salidaVerde,50);
   [Ie,N] = bwlabel(salida);
    
    Ib = zeros(size(salida));
    R = find(salidaRojo==1);
    
    for j=1:N
        Ibe = Ie==j;
        S = sum(sum(ismember(find(Ibe==1),R)));
        if(S > 0)
            Ib = Ib | Ibe;
        end
    end
    ImColor = Im;
    for j = 1:F
       for k = 1:C
           if Ib(j,k) == 1
                ImColor(j,k,:) = [255 0 0];               
           end
       end
    end
   %figure, imshow(ImColor);
   
   [Sens Esp Prec FalsosPositivos] = funcion_metricas(Ib, Gold);
   rendimiento = [rendimiento; Sens Esp Prec FalsosPositivos];
end