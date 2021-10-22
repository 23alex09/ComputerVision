clc
clear
close all
addpath(genpath('../../Practica 2'))
load datos2.mat
%Determinar la media y la desviacion tipica de cada una de las componentes
%de  color

Medias = [];
Desviaciones = [];

CC = [255 128 64 32];

for i = 1:length(CC)
    POI = CodifValoresColores == CC(i);
    Medias = [Medias; CC(i) mean(VCN(POI,1)) mean(VCN(POI,2)) mean(VCN(POI,3)) mean(VCN(POI,4)) mean(VCN(POI,5)) mean(VCN(POI,6)) mean(VCN(POI,7)) mean(VCN(POI,8)) mean(VCN(POI,9)) mean(VCN(POI,10)) mean(VCN(POI,11)) mean(VCN(POI,12))];
    Desviaciones = [Desviaciones; CC(i) std(VCN(POI,1)) std(VCN(POI,2)) std(VCN(POI,3)) std(VCN(POI,4)) std(VCN(POI,5)) std(VCN(POI,6)) std(VCN(POI,7)) std(VCN(POI,8)) std(VCN(POI,9)) std(VCN(POI,10)) std(VCN(POI,11)) std(VCN(POI,12))];
end

save MedDes.mat Medias Desviaciones
%Con una funcion que hare, realizare el clasificador basado en las
%medias y desviaciones tipicas, en este caso lo hare para RGB (Columnas de 
%la 2 a la 4)
%A la funcion del clasificador le pasare la matriz con los canales de color
%ya normalizados

I = imread('imagen01.jpeg');
RN = double(I(:,:,1))/255;
GN = double(I(:,:,2))/255;
BN = double(I(:,:,3))/255;

IN = cat(3, RN, GN, BN);

ICodif = clasificador(IN, 1.5, Medias(:,2:4), Desviaciones(:,2:4));
[f, c] = size(ICodif);
c1 = [255 0 0 0];
c2 = [0 255 0 0];
c3 = [0 255 255 0];

R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

for i = 1:length(CC)
   Ibin = ICodif == CC(i);
   R(Ibin) = c1(i);
   G(Ibin) = c2(i);
   B(Ibin) = c3(i);
end

IColor = cat(3, R, G, B);
% for i =1:f
%     for j = 1:c
%         for k = 1:length(CC)
%             if ICodif(i,j) == CC(k)
%                 IColor(i,j,:) = [c1(k) c2(k) c3(k)];
%             end
%         end
%     end
% end
unique(ICodif)
imshow(I), figure, imtool(uint8(ICodif)), figure, imshow(IColor);

