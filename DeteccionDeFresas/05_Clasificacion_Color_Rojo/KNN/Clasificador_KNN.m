clc
clear
close all
addpath(genpath('../../../Practica 2'))
load Datos2.mat

%KNN:modelo = fitcknn(inputs_entrenamiento(Columnas descriptores),outputs(codificacion columna), 'NumNeighbors', k), 
%donde la k es el numero de muestras mas cercanas.
%codificacion = predict(modelo, inputs)


inputs_ent = VCN(:,1:3);
outputs_ent = zeros(size(CodifValoresColores,1),1);
outputs_ent(CodifValoresColores == 255) = 1;
k = 5;

ModeloKNNRGB = Calcula_KNN(inputs_ent,outputs_ent,5);


inputs_ent = VCN(:,[1 5 10]);

ModeloKNNRSL = Calcula_KNN(inputs_ent,outputs_ent,5);

inputs_ent = VCN(:,10:12);

ModeloKNNLab = Calcula_KNN(inputs_ent,outputs_ent,5);

save ModelosKNN.mat ModeloKNNRGB ModeloKNNRSL ModeloKNNLab