clc
clear
close all
addpath(genpath('../../Practica 2'))
load datos2.mat 

VCNt = VCN';
CodifValoresColorest = CodifValoresColores';
CodifValoresColorest(CodifValoresColorest ~= 128) = 0;
CodifValoresColorest(CodifValoresColorest == 128) = 1;

combinaciones3 = combnk([1:12], 3);
[numComb numDescriptores] = size(combinaciones3);
Jcomb3 = [];
for i = 1:numComb
    datos = VCNt(combinaciones3(i,:),:);
    Jcomb3 = [Jcomb3 indiceJ(datos, CodifValoresColorest)];
end

[val3 ind] = sort(Jcomb3, 'descend');
MejorComb3 = combinaciones3(ind(1),:);

CC = [0 1];
colores{1} = '.r';
colores{2} = '.g';

for i = 1:length(CC)
    POI = CodifValoresColorest == CC(i);
   
    plot3(VCN(POI,2), VCN(POI,4), VCN(POI, 8), colores{i}); hold on; 
end

save combinacion3V.mat MejorComb3