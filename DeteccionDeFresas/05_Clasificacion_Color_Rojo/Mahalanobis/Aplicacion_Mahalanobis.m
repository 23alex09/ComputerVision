clc
clear
close all
addpath(genpath('../../../Practica 2'))
load CentrosUmbrales.mat



Im = imread('EvRojo2.tif');
Imuestra = imread('EvRojo2_Gold.tif');

Ir = imresize(Im, 0.5);

[F C canal] = size(Im);
[Fr Cr canalr] = size(Ir);

%Extraer los datos de la imagen de test (R,G,B,L,a,b,S)
%RGB
Centro = CentrosUmbrales(1,1:3);
MCov = Covs(1:3,:);
Umbral = CentrosUmbrales(1,6);

Res = zeros(Fr, Cr);

for i = 1:Fr
   for j = 1:Cr
       Valor = [Ir(i,j,1) Ir(i,j,2) Ir(i,j,3)];
       Valor = double(Valor)/255;
       distancia = sqrt((Valor-Centro)*pinv(MCov)*(Valor-Centro)');
       if distancia < Umbral
           Res(i,j) = 1;
       end
   end

end
Res = round(imresize(Res,[F C],'nearest'));
Imuestra(Imuestra == 255) = 1;

[Sens Esp Prec FalsosPositivos] = funcion_metricas(Res,Imuestra);


RendimientoMahalRGB = [Sens Esp Prec FalsosPositivos];

CC = [1]

c1 = [255 0 0 0];
c2 = [0 255 0 0];
c3 = [0 255 255 0];

R = Im(:,:,1);
G = Im(:,:,2);
B = Im(:,:,3);

for i = 1:length(CC)
   Ibin = Imuestra == CC(i);
   R(Ibin) = c1(i);
   G(Ibin) = c2(i);
   B(Ibin) = c3(i);
end

IColor = cat(3, R, G, B);

imshow(IColor);
%Lab
Lab = rgb2lab(Ir);
L = Lab(:,:,1);%Valores de 0 a 100
a = Lab(:,:,2);%Valores de -128 a 127
b = Lab(:,:,3);%Valores de -128 a 127

LN = L/100;
aN = mat2gray(a,[-128 127]);
bN = mat2gray(b,[-128 127]);

Centro = CentrosUmbrales(3,1:3);
MCov = Covs(7:9,:);
Umbral = CentrosUmbrales(3,5);

Res = zeros(Fr, Cr);

for i = 1:Fr
   for j = 1:Cr
       Valor = [LN(i,j) aN(i,j) bN(i,j)];
       distancia = sqrt((Valor-Centro)*pinv(MCov)*(Valor-Centro)');
       if distancia < Umbral
           Res(i,j) = 1;
       end
   end

end
Res = round(imresize(Res,[F C],'nearest'));
Imuestra(Imuestra == 255) = 1;

[Sens Esp Prec FalsosPositivos] = funcion_metricas(Res,Imuestra);


RendimientoMahalLab = [Sens Esp Prec FalsosPositivos];

%RSL
hsv = rgb2hsv(Ir);
S = hsv(:,:,2);

Centro = CentrosUmbrales(2,1:3);
MCov = Covs(4:6,:);
Umbral = CentrosUmbrales(2,5);

Res = zeros(Fr, Cr);

for i = 1:Fr
   for j = 1:Cr
       Valor = [double(Ir(i,j,1))/255 S(i,j) LN(i,j)];
       distancia = sqrt((Valor-Centro)*pinv(MCov)*(Valor-Centro)');
       if distancia < Umbral
           Res(i,j) = 1;
       end
   end

end
Res = round(imresize(Res,[F C],'nearest'));
Imuestra(Imuestra == 255) = 1;

[Sens Esp Prec FalsosPositivos] = funcion_metricas(Res,Imuestra);


RendimientoMahalRSL = [Sens Esp Prec FalsosPositivos];




save RendimientoMahal.mat RendimientoMahalRGB RendimientoMahalRSL RendimientoMahalLab;
%El primer umbral, no se pierde ningun pixel rojo, es demasiado permisivo y
%asume pixeles que no son rojos como pixeles rojos y el ultimo umbral en el
%que metemos un poco de ruido sigue metiendo demasiado ruido



