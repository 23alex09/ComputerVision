clc
clear
close all
addpath(genpath('../../../Practica 2'))
load datos2.mat
load datosOI.mat

CodifValoresColores(CodifValoresColores ~= 255) = 0;
CodifValoresColores(CodifValoresColores == 255) = 1;

%Lo primero es ver que pixeles pertenecen al rojo fresa y cuales a
%cualquier otra codificacion

%Representar con los distintos espacios de caracteristicas una vez hayamos
%diferenciado entre rojo fresa y otros

%Distancia de Mahalanobis: Lo primero es seleccionar el espacio de
%caracteristicas, por ejemplo RGB(Hacerlo con RSL). Necesitamos: Eliminar
%los puntos rojos que tienen un valor < 0.95 en la componente roja.
%Necesitamos el punto medio de la nube de puntos rojos. Tambien calcular la
%matriz de covarianzas de la nube roja de puntos- Criterios de umbral: 1.
%todos los puntos de la nube roja.

%Descriptores a considerar RGB, RSL, Lab
%RGB
CodifRGB = CodifValoresColores;
RGB = RGB';
POI = RGB(:,1) < 0.95 & CodifValoresColores == 1; 
RGB(POI,:) = [];
CodifRGB(POI) = [];

[CentroRadioRGB MCovRGB] = Mahalanobis(RGB, CodifRGB);

%RSL (Mejor combinacion de 3)
RSL = RSL';
CodifRSL = CodifValoresColores;
RSL(POI,:) = [];
CodifRSL(POI) = [];

[CentroRadioRSL MCovRSL] = Mahalanobis(RSL, CodifRSL);

%Lab
Lab = Lab';
CodifLab = CodifValoresColores;
Lab(POI,:) = [];
CodifLab(POI) = [];

[CentroRadioLab MCovLab] = Mahalanobis(Lab, CodifLab);

CentrosUmbrales = [CentroRadioRGB; CentroRadioRSL; CentroRadioLab]; 
Covs = [MCovRGB; MCovRSL; MCovLab];
save CentrosUmbrales.mat CentrosUmbrales Covs

CentroRadio = CentroRadioRGB;
MCov = MCovRGB;

Centro = CentroRadio(1:3);
[X1,X2,X3] = meshgrid(0:1/40:1);
Valores = [X1(:) X2(:) X3(:)];
[NumValores temp] = size(Valores);
distancia = [];
for j=1:NumValores
    X = Valores(j,:);
    distancia(j,1)=sqrt((X-Centro)*pinv(MCov)*(X-Centro)');
end
PosicionesInteres = distancia < CentroRadio(7);
datosMahal = Valores(PosicionesInteres,:);
% REPRESENTAMOS
colores{1} = '.b';
colores{2} = '.r'
for i = 0:1
    POI = CodifRGB == i;
    plot3(RGB(POI, 1), RGB(POI, 2), RGB(POI, 3), colores{i+1}); hold on; 
end
x = datosMahal(:,1); y = datosMahal(:,2); z = datosMahal(:,3);
plot3(x, y, z, '+g')

