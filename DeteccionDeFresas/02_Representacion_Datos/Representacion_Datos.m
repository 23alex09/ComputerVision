clc
clear
close all
addpath(genpath('../../Practica 2'))
load datos.mat

CC = [255 128 64 32];
colores{1} = '.r';
colores{2} = '.g';
colores{3} = '.b';
colores{4} = '.black';

descriptores{1} = 'R';
descriptores{2} = 'G';
descriptores{3} = 'B';
descriptores{4} = 'H';
descriptores{5} = 'S';
descriptores{6} = 'I';
descriptores{7} = 'Y';
descriptores{8} = 'U';
descriptores{9} = 'V';
descriptores{10} = 'L';
descriptores{11} = 'a';
descriptores{12} = 'b';

leyenda{1} = 'Rojo Fresa - Rojo';
leyenda{2} = 'Verde Fresa - Verde';
leyenda{3} = 'Verde Planta - Azul';
leyenda{4} = 'Negro Lona - Negro';
%RGB
for i = 1:length(CC)
    %Por cada iteracion cojo los pixeles que pertenezcan al color
    %caracteristico correspondiente
    POI = CodifValoresColores == CC(i);
    %Asigno a los ejes el nombre que corresponde
    xlabel(descriptores{1});
    ylabel(descriptores{2});
    zlabel(descriptores{3});
    plot3(ValoresColoresNormalizados(POI, 1), ValoresColoresNormalizados(POI, 2), ValoresColoresNormalizados(POI, 3), colores{i}); hold on; 
end
legend(leyenda);
figure
%HS
for i = 1:length(CC)
    POI = CodifValoresColores == CC(i);
    xlabel(descriptores{4});
    ylabel(descriptores{5});
    plot(ValoresColoresNormalizados(POI,4), ValoresColoresNormalizados(POI,5), colores{i}); hold on;
end
legend(leyenda);
figure
%UV
for i = 1:length(CC)
    POI = CodifValoresColores == CC(i);
    xlabel(descriptores{8});
    ylabel(descriptores{9});
    plot(ValoresColoresNormalizados(POI,8), ValoresColoresNormalizados(POI,9), colores{i}); hold on;
end
legend(leyenda);
figure
%ab
for i = 1:length(CC)
    POI = CodifValoresColores == CC(i);
    xlabel(descriptores{11});
    ylabel(descriptores{12});
    plot(ValoresColoresNormalizados(POI,11), ValoresColoresNormalizados(POI,12), colores{i}); hold on;
end
legend(leyenda);
Hrecalculado = RecalculaH(ValoresColoresNormalizados(:,4));
ValoresColoresNormalizados(:,4) = Hrecalculado;
figure
%HS con H recalculado
for i = 1:length(CC)
    POI = CodifValoresColores == CC(i);
    xlabel('H recalculado');
    ylabel(descriptores{5});
    plot(ValoresColoresNormalizados(POI,4), ValoresColoresNormalizados(POI,5), colores{i}); hold on;
end
legend(leyenda);
%A partir de este punto ValoresColoresNormalizados pasara a ser VCN para
%abreviar
VCN = ValoresColoresNormalizados;
save datos2.mat VCN CodifValoresColores