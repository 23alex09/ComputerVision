clc
clear
close all
addpath(genpath('../../Practica 2'))
load datos2.mat 

%Para la funcion que calcula la separabilidad entre clase (indiceJ)
%necesitamos los imputs(VCN) y los outputs(CodifValoresColores)
%traspuestos. Ademas ahora las clases seran dos: Color rojo fresa y otro
%color

%Usando la funcion combnk, le paso los numeros con los que hara
%combinaciones y de cuantos seran las combinaciones y devolvera un array en
%el que cada fila contiene cada combinacion

VCNt = VCN';
CodifValoresColorest = CodifValoresColores';
CodifValoresColorest(CodifValoresColorest ~= 255) = 0;
CodifValoresColorest(CodifValoresColorest == 255) = 1;

%Modelos de color
SepModelosColor = [];
for i = 1:3:12
    datos = VCNt(i:i+2,:);
    SepModelosColor = [SepModelosColor indiceJ(datos, CodifValoresColorest)];
end

[val ind] = sort(SepModelosColor, 'descend');
MejoresModelos = ind(1,2);

%Combinaciones de 3 en 3
combinaciones3 = combnk([1:12], 3);
[numComb numDescriptores] = size(combinaciones3);
Jcomb3 = [];
for i = 1:numComb
    datos = VCNt(combinaciones3(i,:),:);
    Jcomb3 = [Jcomb3 indiceJ(datos, CodifValoresColorest)];
end

[val3 ind] = sort(Jcomb3, 'descend');
MejoresComb3 = combinaciones3(ind(1:3),:);

%Combinaciones de 4 en 4
combinaciones4 = combnk([1:12], 4);
[numComb numDesc] = size(combinaciones4);
Jcomb4  = [];
for i = 1:numComb
    datos = VCNt(combinaciones4(i,:),:);
    Jcomb4 = [Jcomb4 indiceJ(datos, CodifValoresColorest)]; 
end

[val4 ind] = sort(Jcomb4, 'descend');
Mejores4 = combinaciones4(ind(1:3), :);

%Combinaciones de 5 en 5
combinaciones5 = combnk([1:12], 5);
[numComb numDesc] = size(combinaciones5);
Jcomb5  = [];
for i = 1:numComb
    datos = VCNt(combinaciones5(i,:),:);
    Jcomb5 = [Jcomb5 indiceJ(datos, CodifValoresColorest)]; 
end

[val5 ind] = sort(Jcomb5, 'descend');
Mejores5 = combinaciones5(ind(1:3), :);

%Combinaciones de 6 en 6
combinaciones6 = combnk([1:12], 6);
[numComb numDesc] = size(combinaciones6);
Jcomb6  = [];
for i = 1:numComb
    datos = VCNt(combinaciones6(i,:),:);
    Jcomb6 = [Jcomb6 indiceJ(datos, CodifValoresColorest)]; 
end

[val6 ind] = sort(Jcomb6, 'descend');
Mejores6 = combinaciones6(ind(1:3), :);

%Entre la mejor combinacion de 5 y 6 no hay una gran diferencia asique no
%probare con combinaciones mayores de 5 ya que de esta manera ahorrare en
%recursos y tiempo aunque tengamos una combinacion con una separabilidad
%menor

RGB = VCNt(1:3,:);
Lab = VCNt(10:12,:);
RSL = VCNt(MejoresComb3(1,:),:);

%La combinacion de mas descrioptores sera la mejor de 5 ya que la mejor de
%4 tiene una separabilidad notablemente inferior(0.7) y la de 6 es solo 0.1 
%mayor que la de 5

Comb5 = VCNt(Mejores5(1,:), :);

save DatosOI.mat RGB Lab RSL Comb5
