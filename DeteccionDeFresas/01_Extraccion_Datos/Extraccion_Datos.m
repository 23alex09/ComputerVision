clc
clear
close all
addpath(genpath('../../Practica 2'))

numImagen{1} = '1';
numImagen{2} = '2';
numImagen{3} = '3';

ValoresColores = [];
ValoresColoresNormalizados = [];
CodifValoresColores = [];

%Cada uno de los colores representativos tiene un nivel de intendidad
%diferente: 255->Rojo Fresa 
%           128->Verde Fresa inmadura   
%           64->Verde Hoja
%           32->Negro Fondo
CC = [255 128 64 32];

for i = 1:length(CC)
    for j = 1:3
        %Cargo la imagen de la fresas y la imagen con la codificacion
        Im = imread(['Color' numImagen{j} '.jpeg']);
        ICodif = imread(['Color' numImagen{j} '_MuestraColores.tif']);
        %Saco una imagen binaria con los puntos de interes de cada una de
        %las codificaciones de color
        POI = ICodif == CC(i);
        
        %RGB
        R = Im(:,:,1);
        G = Im(:,:,2);
        B = Im(:,:,3);
        
        RN = double(R)/255;
        GN = double(G)/255;
        BN = double(B)/255;
        
        %HSI
        %Los valores que devuelve esta funcion ya estan normalizados entre
        %0 y 1
        hsv = rgb2hsv(Im);
        
        H = hsv(:,:,1);
        S = hsv(:,:,2);
        %Para la I hacemos la media de cada uno de los canales de color
        %para cada pixel
        rgbN = cat(3, RN, GN, BN);
        I = mean(rgbN,3);
        
        %YUV
        %Hay que usar los datos de RGB ya normalizados
        Y = 0.299*RN + 0.587*GN + 0.114*BN;%Ya esta normalizado
        U = 0.492*(BN-Y);
        V = 0.877*(RN-Y);
        
        UN = mat2gray(U, [-0.6 0.6]);
        VN = mat2gray(V, [-0.6 0.6]);
        %Lab
        %Estos valores hay que normalizarlos segun sus rangos de valores
        Lab = rgb2lab(Im);
        L = Lab(:,:,1);%Valores de 0 a 100
        a = Lab(:,:,2);%Valores de -128 a 127
        b = Lab(:,:,3);%Valores de -128 a 127
        
        LN = L/100;
        aN = mat2gray(a,[-128 127]);
        bN = mat2gray(b,[-128 127]);
        %Cada una de las columnas es un canal de intensidad de cada modelo
        %de color
        ValoresColores = [ValoresColores; double(R(POI)) double(G(POI)) double(B(POI)) H(POI) S(POI) I(POI) Y(POI) U(POI) V(POI) L(POI) a(POI) b(POI)];
        ValoresColoresNormalizados = [ValoresColoresNormalizados; RN(POI) GN(POI) BN(POI) H(POI) S(POI) I(POI) Y(POI) UN(POI) VN(POI) LN(POI) aN(POI) bN(POI)];
        %Un vector columna en el que encontraremos a que color
        %representativo pertenece cada pixel de la matriz ValoresColores
        CodifValoresColores = [CodifValoresColores; CC(i)*ones(length(R(POI)),1)];
    end
end

save datos.mat  ValoresColores CodifValoresColores ValoresColoresNormalizados