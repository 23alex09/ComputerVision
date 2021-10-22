clc
clear
close all
addpath(genpath('../../../Practica 2'))
load Datos2.mat
load combinacion3.mat
%KNN:modelo = fitcknn(inputs_entrenamiento(Columnas descriptores),outputs(codificacion columna), 'NumNeighbors', k), 
%donde la k es el numero de muestras mas cercanas.
%codificacion = predict(modelo, inputs)


inputs_ent = VCN(:,MejorComb3);
outputs_ent = zeros(size(CodifValoresColores,1),1);
outputs_ent(CodifValoresColores == 128) = 1;
k = 5;

ModeloKNNVerde = Calcula_KNN(inputs_ent,outputs_ent,k);

save ModeloKNNVerde.mat ModeloKNNVerde