clc
clear
close all
addpath(genpath('../../Practica 2'))
load datos2.mat 

VCNt = VCN';
CodifValoresColorest = CodifValoresColores';
CodifValoresColorest(CodifValoresColorest ~= 255 & CodifValoresColorest ~= 128) = 0;
CodifValoresColorest(CodifValoresColorest == 255 | CodifValoresColorest == 128) = 1;

combinaciones3 = combnk([1:12], 3);
[numComb numDescriptores] = size(combinaciones3);
Jcomb3 = [];
for i = 1:numComb
    datos = VCNt(combinaciones3(i,:),:);
    Jcomb3 = [Jcomb3 indiceJ(datos, CodifValoresColorest)];
end

[val3 ind] = sort(Jcomb3, 'descend');
combinacion3 = combinaciones3(ind(1),:);

save combinacion3.mat combinacion3